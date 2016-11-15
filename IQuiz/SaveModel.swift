//
//  SaveModel.swift
//  IQuiz
//
//  Created by Litthideth Phansiri on 11/13/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//

import UIKit
import Alamofire

class SaveModel {
    var subjects: [Subject] = []
    
    func downloadData(completed: @escaping DownloadComplete) {
        Alamofire.request(BASE_URL).responseJSON { response in
            let resultJSON = response.result
            NSLog("Inside Alamofire")
            
            if let result = resultJSON.value as? [Dictionary<String, Any>] {
                NSLog("Retrieved JSON")
                for index in 0...result.count - 1 {
                    let oneSubject = Subject()
                    let question = Question()

                    let obj = result[index]
                    NSLog("Performing calculations on object: \(index)")
                    // Subject portion
                    let title = obj["title"] as? String
                    let desc = obj["desc"] as? String
                    oneSubject.title = title?.capitalized
                    NSLog("oneSubject title saved with: \(title)")
                    oneSubject.desc = desc?.capitalized
                    NSLog("oneSubject desc saved with: \(desc)")
                    
                    
                    if oneSubject.title.contains("Math") {
                        oneSubject.imageFile = "math icon"
                        NSLog("oneSubject imageFile saved with: \(oneSubject.imageFile)")
                    } else if oneSubject.title.contains("Science") {
                        oneSubject.imageFile = "science icon"
                        NSLog("oneSubject imageFile saved with: \(oneSubject.imageFile)")
                    } else if oneSubject.title.contains("Hero") {
                        oneSubject.imageFile = "hero icon"
                        NSLog("oneSubject imageFile saved with: \(oneSubject.imageFile)")
                    }
                    
                    // Question portion
                    let questionObj = obj["questions"] as! [Dictionary<String, Any>]
                    for questionIndex in 0...questionObj.count - 1 {
                        let firstQuestion = questionObj[questionIndex]
                        let text = firstQuestion["text"] as! String
                        let answer = firstQuestion["answer"] as! String
                        let answerObj = firstQuestion["answers"] as! [String]
                        question.text = text.capitalized
                        NSLog("Question text saved with: \(text)")
                        question.answer = answer.capitalized
                        NSLog("Question answer saved with: \(answer)")
                        question.answers = answerObj
                        NSLog("Question answers saved with: \(answer)")
                        oneSubject.question.append(question)
                        NSLog("oneSubject questions saved")
                    }
                    
                    //NSLog("OneSubject Object: \(oneSubject.title)")
                    
                    self.subjects.append(oneSubject)
                }
            }
            NSLog("Subjects: \(self.subjects.count)")
            //self.saveData()
            completed()
        }
    }
    /*
    func saveData() {
        let defaults = UserDefaults.standard
        NSLog("NSLog: \(defaults.array(forKey: "subs"))")
        if (defaults.object(forKey: "subs") != nil) {
            defaults.removeObject(forKey: "subs")
        }
        var saveSubject = defaults.array(forKey: "subs")
        if saveSubject == nil {
            saveSubject = Array()
        }
        saveSubject?.append([self.subjects])
        defaults.set(saveSubject, forKey: "subs")
    }*/
}
