//
//  AddCustomNotesController.swift
//  InstaPlan
//
//  Created by 康壮伟 on 4/25/17.
//  Copyright © 2017 Zhuangwei Kang. All rights reserved.
//

import UIKit
import SpeechToTextV1

class AddCustomNotesController: UIViewController {

    @IBOutlet weak var voiceToText: UIButton!
    
    @IBOutlet weak var textField: UITextView!
    
    var speechToText: SpeechToText!
    var speechToTextSession: SpeechToTextSession!
    var isStreaming = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
        speechToText = SpeechToText(
            username: SpeechToTextCredentials.SpeechToTextUsername,
            password: SpeechToTextCredentials.SpeechToTextPassword
        )
        
    }
    
    func goback() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "HomePage", bundle: nil)
        
        let todayView = storyBoard.instantiateViewController(withIdentifier: "startPoint")
        
        self.present(todayView, animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: Any) {
        //Save notes content to database
        let custom_notes: String = self.textField.text
        let alert = UIAlertController(title: "Note Name", message: "Enter note name", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Note Name"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            CoreDataController().storeCustomNotes(custom_notes: custom_notes, note_name: (textField?.text)!)
            self.goback()
        }))
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        goback()
    }
    
    @IBAction func voiceToTextAction(_ sender: Any) {
        streamMicrophoneBasic()
    }
   
    func streamMicrophoneBasic() {
        if !isStreaming {
            
            //update state
            voiceToText.setTitle("Stop Voice Recoring", for: .normal)
            isStreaming = true
            
            //define recognition settings
            var settings = RecognitionSettings(contentType: .opus)
            settings.continuous = true
            settings.interimResults = true
            
            //define error function
            let failure = {(error: Error) in print(error)}
            
            //start recognizing microphone audio
            speechToText.recognizeMicrophone(settings: settings, failure: failure){
                results in
                self.textField.text = results.bestTranscript
            }
        }
        else{
            
            //update state
            voiceToText.setTitle("Voice To Text", for: .normal)
            isStreaming = false
            
            //stop recognizing microphone audio
            speechToText.stopRecognizeMicrophone()
        }
    }

    
    @IBAction func clear(_ sender: Any) {
        self.textField.text = ""
    }
}
