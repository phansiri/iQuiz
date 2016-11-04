//
//  SubjectAddViewController.swift
//  IQuiz
//
//  Created by Litthideth Phansiri on 11/3/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//

import UIKit

class SubjectAddViewController: UIViewController {

    @IBOutlet weak var addImageTextField: UITextField!
    @IBOutlet weak var addSubjectTextField: UITextField!
    @IBOutlet weak var addDescrTextField: UITextView!
    
    @IBAction func addSaveButton(_ sender: Any) {
        /*
        let subject: ModelSubject = ModelSubject()
        subject.subject = addSubjectTextField.text
        subject.descr = addDescrTextField.text
        subject.imageFile = addImageTextField.text
        */
        let subject = ["subject": addSubjectTextField.text,
                       "descr": addDescrTextField.text,
                       "imageFile": addImageTextField.text]
        // let delegate = UIApplication.shared.delegate as! AppDelegate
        // delegate.subjects.append(subject)
        
        let defaults = UserDefaults.standard
        var saveSubjects = defaults.array(forKey: "saves")
        if saveSubjects == nil {
            saveSubjects = Array()
        }
        saveSubjects?.append(["data": subject])
        
        defaults.set(saveSubjects, forKey: "saves")

        //self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
