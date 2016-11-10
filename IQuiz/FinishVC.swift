//
//  FinishViewController.swift
//  IQuiz
//
//  Created by Litthideth Phansiri on 11/9/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//

import UIKit

class FinishVC: UIViewController {
    
    var questionModel: Subject = Subject()
    var quizState: QuizState = QuizState()
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var pickUpWordLabel: UILabel!
    
    @IBAction func nextButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        if let home = self.storyboard?.instantiateViewController(withIdentifier: "Initial") as? UINavigationController {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController!.present(home, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let score: Double = Double(quizState.questionAnsweredCorrectly!) / Double(quizState.maxQuestion!) * 100
        
        scoreLabel.text = "\(quizState.questionAnsweredCorrectly!) / \(quizState.maxQuestion!)"
        
        // NSLog("Score: \(score)")
        
        if score == 100.0 {
            pickUpWordLabel.text = "Perfect!!!"
        } else if score >= 50.0 {
            pickUpWordLabel.text = "Almost! Keep up the effort"
        } else {
            pickUpWordLabel.text = "Better try harder!"
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*if let destination = segue.destination as? SubjectTableVC {
         if let subject = sender as? Subject {
         
         }
         }*/
    }
    
    
}
