//
//  AnswerViewController.swift
//  IQuiz
//
//  Created by Litthideth Phansiri on 11/9/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "NextQuestionSegue" {
            if let transitionSegue = segue.destination as? FinishViewController {
                transitionSegue.testLabel.text = "hello"
            }
        }
    }
    

}
