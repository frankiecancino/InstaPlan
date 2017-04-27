//
//  AddClassController.swift
//  InstaPlan
//
//  Created by 康壮伟 on 4/19/17.
//  Copyright © 2017 Zhuangwei Kang. All rights reserved.
//

import UIKit
import AVFoundation
import TextToSpeechV1
import SpeechToTextV1

class AddClassController: UIViewController {

    
    @IBOutlet weak var classNameTextField: UITextField!
    
    @IBOutlet weak var timeTextField: UITextField!
    
    @IBOutlet weak var dayTextField: UITextField!
    
    @IBOutlet weak var endDateTextField: UITextField!
    
    @IBOutlet weak var colorTextField: UITextField!
    
    @IBOutlet weak var voiceImage: UIImageView!
    
    @IBOutlet weak var quickInputBtn: UIButton!
    
    @IBOutlet weak var confirmSpeechInputBtn: UIButton!
    
    @IBOutlet weak var instructor_ta_info_text_field: UITextField!
    
    @IBOutlet weak var additional_info_text_field: UITextField!
    
    let timePickerView: UIDatePicker = UIDatePicker()
    
    let endDatePickerView: UIDatePicker = UIDatePicker()
    
    // Text to Speech service object
    var textToSpeech: TextToSpeech!
    
    // Audio player for playing synthesized text
    var player: AVAudioPlayer?
    
    
    let welcomeSpeech = "Hi, I'm InstaPlan quick input assistant. Let's start adding a class."
    let requestClassnameSpeech = "What's your class name?"
    let confirmClassName = "OK, I got your class name."
    let requestClassTimeSpeech = "What's your class time? For example, you can tell me 3 PM."
    let confirmClassTimeSpeech = "OK, I got your class time."
    let requestClassDaySpeech = "What's the weekday of your class? For example, you can say Monday, Wednesday, and Friday."
    let confirmClassDaySpeech = "Great, I got your class days."
    let requestEndDateSpeech = "Now, you need to tell me the end date of your class. For example, you can say: April 21st 2017."
    let confirmEndDateSpeech = "Cool, you are a smart boy, I got your class end date."
    let requestTAInstructorInfoSpeech = "Would you add your TA and instructor information? If so, just tell me."
    let confirmTAInstructorInfoSpeech = "Bingo, I got your TA and instructor information."
    let requestAdditionalSpeech = "OK, do your want to add some additional information for your class? If not, just say No."
    let confirmAdditionalSpeech = "Cool, I have got your additional information."
    let endSpeech = "Congratulation, we have finished all stuffs."
    let errorSpeech = "Sorry, I'm not sure what you are saying."
    let stopSpeech = "Thanks for using InstaPlan quick input, goodbye."
    
    // Speech to Text service object
    var speechToText: SpeechToText!
    var speechToTextSession: SpeechToTextSession!
    var isStreaming = false
    
   
    
    func updateUI() {
        var days: String = ""
        for day in selectedWeekdays{
            days += day + " "
        }
        dayTextField.text = days
        print("day: " + dayTextField.text!)
        //selectedWeekdays = []
    }

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.blackTranslucent
        
        toolBar.tintColor = UIColor.white
        
        toolBar.backgroundColor = UIColor.black

        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.donePressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 20)
        
        label.backgroundColor = UIColor.clear
        
        label.textColor = UIColor.white
        
        label.text = "InstaPlan"
        
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([textBtn, flexSpace, okBarBtn], animated: true)
        
        endDateTextField.inputAccessoryView = toolBar
        
        timeTextField.inputAccessoryView = toolBar

        confirmSpeechInputBtn.isHidden = true
        
        voiceImage.image = UIImage(named: "voice1")
        
        // Instantiate Text to Speech service
        textToSpeech = TextToSpeech(
            username: TextToSpeechCredentials.TextToSpeechUsername,
            password: TextToSpeechCredentials.TextToSpeechPassword
        )
        
        speechToText = SpeechToText(
            username: SpeechToTextCredentials.SpeechToTextUsername,
            password: SpeechToTextCredentials.SpeechToTextPassword
        )
        
        timePickerView.datePickerMode = UIDatePickerMode.time
        timeTextField.inputView = timePickerView
        timePickerView.addTarget(self, action: #selector(self.timePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        endDatePickerView.datePickerMode = UIDatePickerMode.date
        endDateTextField.inputView = endDatePickerView
        endDatePickerView.addTarget(self, action: #selector(self.endDatePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddClassController.updateUI), name: NSNotification.Name(rawValue: "UpdateDayTextField"), object: nil)
    }
    
    func donePressed() {
        endDateTextField.resignFirstResponder()
        timeTextField.resignFirstResponder()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func getUserInput() -> (class_name: String, class_time: String, class_day: String, enddate: NSDate, class_color: String, instructor_ta_info: String, additional_info: String){
        
        let class_name: String = self.classNameTextField.text!
        let class_time: String = self.timeTextField.text!
        let class_day: String = self.dayTextField.text!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let enddate: NSDate = dateFormatter.date(from: self.endDateTextField.text!)! as NSDate
        
        let class_color: String = self.colorTextField.text!
        
        let instructor_ta_info: String = self.instructor_ta_info_text_field.text!
        let additional_info: String = self.additional_info_text_field.text!
        
        return (class_name, class_time, class_day, enddate, class_color, instructor_ta_info, additional_info)
        
    }
    
    func goback() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "HomePage", bundle: nil)
        
        let todayView = storyBoard.instantiateViewController(withIdentifier: "startPoint")
        
        self.present(todayView, animated: true, completion: nil)
    }

    func jumpToPickWeekdays() {
        let popChoosedayView = UIStoryboard(name: "HomePage", bundle: nil).instantiateViewController(withIdentifier: "weekDays") as! PickWeekDaysController
        
        
        self.addChildViewController(popChoosedayView)
        popChoosedayView.view.frame = self.view.frame
        self.view.addSubview(popChoosedayView.view)
        popChoosedayView.didMove(toParentViewController: self)
    }
    
    @IBAction func cancelAddClass(_ sender: Any) {
        goback()
    }

    @IBAction func addClass(_ sender: Any) {
        //store class information into database
        let class_name: String
        let class_time: String
        let class_day: String
        let enddate: NSDate
        let class_color: String
        let instructor_ta_info: String
        let additional_info: String
        (class_name, class_time, class_day, enddate, class_color, instructor_ta_info, additional_info) = getUserInput()
        CoreDataController().storeClass(class_name: class_name, class_time: class_time, class_color: class_color, class_day: class_day, class_end_date: enddate, instructor_ta_info: instructor_ta_info, additional_info: additional_info)
        goback()
    }
    
    func timePickerValueChanged(sender: UIDatePicker) {
        
        let timeFormatter = DateFormatter()
        
        timeFormatter.dateStyle = .none
        
        timeFormatter.timeStyle = .short
        
        timeTextField.text = timeFormatter.string(from: sender.date)
    }
    
    
    func endDatePickerValueChanged(sender: UIDatePicker) {
        
        let enddateFormatter = DateFormatter()
        
        enddateFormatter.dateStyle = .full
        
        enddateFormatter.timeStyle = .none
        
        endDateTextField.text = enddateFormatter.string(from: sender.date)
    }
    @IBAction func timeTextAction(_ sender: UITextField) {
        
        
    }
    
    @IBAction func dayTextFieldAction(_ sender: UITextField) {
        jumpToPickWeekdays()
    }
    
    @IBAction func endDateTextFieldAction(_ sender: UITextField) {
        
        
    }
    
    @IBAction func colorTextFieldAction(_ sender: Any) {
        
    }
    
    @IBAction func quickInputAction(_ sender: UIButton) {
        if (quickInputBtn.title(for: .normal) == "Quick Input") {
            quickInputBtn.setTitle("Stop Quick Input", for: .normal)
            voiceImage.image = UIImage(named: "voice2")
            let welcome_queue = DispatchQueue(label: "welcome")
            welcome_queue.sync(execute: {
                self.confirmSpeechInputBtn.isHidden = false
                self.synthesizeText(text: self.welcomeSpeech)

            })
            
            let queue = DispatchQueue(label: "class name")
            queue.sync(execute: {
                //request class name speech
                self.synthesizeText(text: self.requestClassnameSpeech)
                //class name input
                self.streamMicrophoneBasic(textField: self.classNameTextField)
                
            })
            //class name input
            self.streamMicrophoneBasic(textField: self.classNameTextField)

            //confirm class name speech
            if(self.classNameTextField.text == "" || self.classNameTextField.text == nil){
                self.synthesizeText(text: self.errorSpeech)
            }else{
                self.synthesizeText(text: self.confirmClassName)
            }

                /*
                DispatchQueue.main.sync(execute: {
                    //confirm class name speech
                    if(self.classNameTextField.text == "" || self.classNameTextField.text == nil){
                        self.synthesizeText(text: self.errorSpeech)
                    }else{
                        self.synthesizeText(text: self.confirmClassName)
                    }
                })
                 */
            
            
            
            
            
                    
                    /*
                     //request class time speech
                     synthesizeText(text: requestClassDaySpeech)
                     //class time input
                     streamMicrophoneBasic(textField: timeTextField)
                     //confirm class time input
                     if(timeTextField.text == nil || timeTextField.text == "") {
                     synthesizeText(text: errorSpeech)
                     }else{
                     synthesizeText(text: confirmClassTimeSpeech)
                     }
                     
                     
                     //request class day speech
                     synthesizeText(text: requestClassDaySpeech)
                     //class day input
                     streamMicrophoneBasic(textField: dayTextField)
                     //confirm class day input
                     if (dayTextField.text == "" || dayTextField.text == nil) {
                     synthesizeText(text: errorSpeech)
                     }else{
                     synthesizeText(text: confirmClassDaySpeech)
                     }
                     
                     
                     //request end date speech
                     synthesizeText(text: requestEndDateSpeech)
                     //class end date input
                     streamMicrophoneBasic(textField: endDateTextField)
                     //confirm class end date speech
                     if (endDateTextField.text == nil || endDateTextField.text == "") {
                     synthesizeText(text: errorSpeech)
                     }else{
                     synthesizeText(text: confirmEndDateSpeech)
                     }
                     */
                    
            

            
        }
        else{
            quickInputBtn.setTitle("Quick Input", for: .normal)
            confirmSpeechInputBtn.isHidden = true
            voiceImage.image = UIImage(named: "voice1")
            //quickInputThread?.cancel()
            synthesizeText(text: stopSpeech)
        }
    }
    
    //Text to Speech
    func synthesizeText(text: String) {
        textToSpeech.synthesize(
            text,
            success: { (data) in
            do{
                self.player = try AVAudioPlayer(data: data)
                self.player?.play()
            }catch{
                print("Failed to create audio player.")
            }
        })
    }
    
    //Speech to Text
    func streamMicrophoneBasic(textField: UITextField) {
        let loopTimer = Timer.init(timeInterval: 10, repeats: false) { (timer) in
            if !self.isStreaming {
                
                self.isStreaming = true
                
                //define recognition settings
                var settings = RecognitionSettings(contentType: .opus)
                settings.continuous = true
                settings.interimResults = true
                
                //define error function
                let failure = {(error: Error) in print(error)}
                
                //start recognizing microphone audio
                self.speechToText.recognizeMicrophone(settings: settings, failure: failure){
                    results in
                    textField.text = results.bestTranscript
                }
            }
            else{
                
                self.isStreaming = false
                //stop recognizing microphone audio
                self.speechToText.stopRecognizeMicrophone()
            }

        }
        RunLoop.main.add(loopTimer, forMode: .commonModes)
        loopTimer.fire()
    }
    
    @IBAction func confirmSpeechInput(_ sender: UIButton) {
        let defaultTextField = UITextField()
        streamMicrophoneBasic(textField: defaultTextField)
    }
}
