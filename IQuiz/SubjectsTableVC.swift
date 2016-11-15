//
//  SubjectsTableViewController.swift
//  IQuiz
//
//  Created by Litthideth Phansiri on 11/2/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class SubjectTableVC: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var subjects = [SubjectObj]()
    var quizState = QuizState()
    
    var controller: NSFetchedResultsController<Subject>!
    var refresh: UIRefreshControl!
    
    // saving to UserDefaults
    
    private var records = SubjectTableVC.getData()
    private static func getData() -> [SubjectObj] {
        let data = UserDefaults.standard.array(forKey: "subs")
        if data == nil {
            return Array()
        } else {
            return data as! [SubjectObj]
        }
    }
    
    func refreshMe() {
        self.downloadData {
            NSLog("Inside Refreshing and Downloading...")
            
        }
        self.refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }

 
    
    @IBAction func settingsButton(_ sender: UIBarButtonItem) {
        let checkAction = UIAlertController(title: "Settings", message: "Shall you update?", preferredStyle: .alert)
        checkAction.addTextField() { (textField) in
            textField.placeholder = "\(BASE_URL)"
        }
        let checkNow = UIAlertAction(title: "Check Now", style: .default) { (_) in
            NSLog("Inside Check Now")
            self.downloadData {}
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        checkAction.addAction(checkNow)
        checkAction.addAction(cancel)
        self.present(checkAction, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subjects.removeAll()
        downloadData {}
        
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        self.refreshControl?.backgroundColor = UIColor.darkGray
        self.refreshControl?.tintColor = UIColor.green
        self.refreshControl?.addTarget(self, action: #selector(SubjectTableVC.refreshMe), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(self.refreshControl!)

        attemptFetch()
    }

    func downloadData(completion: @escaping DownloadComplete) {
        
        subjects.removeAll()
        
        Alamofire.request(BASE_URL).responseJSON { response in
            let resultJSON = response.result
            
            if let result = resultJSON.value as? [Dictionary<String, AnyObject>] {
                for index in 0...result.count - 1 {
                    let oneSubject = SubjectObj()
                    
                    let obj = result[index]

                    // Subject portion
                    if let title = obj["title"] as? String {
                        oneSubject.title = title.capitalized
                    }
                    if let desc = obj["desc"] as? String {
                        oneSubject.desc = desc.capitalized
                    }
                    
                    if oneSubject.title.contains("Math") {
                        oneSubject.imageFile = "math icon"
                    } else if oneSubject.title.contains("Science") {
                        oneSubject.imageFile = "science icon"
                    } else if oneSubject.title.contains("Hero") {
                        oneSubject.imageFile = "hero icon"
                    }
                    
                    // Question portion
                    if let questionObj = obj["questions"] as? [Dictionary<String, AnyObject>] {
                        for questionIndex in 0...questionObj.count - 1 {
                            let question = QuestionObj()
                            let firstQuestion = questionObj[questionIndex]
                            if let text = firstQuestion["text"] as? String {
                                question.text = text.capitalized
                            }
                            if let answer = firstQuestion["answer"] as? String {
                                question.answer = answer.capitalized
                            }
                            if let answerObj = firstQuestion["answers"] as? [String] {
                                question.answers = answerObj
                            }
                            oneSubject.question.append(question)
                        }
                        self.subjects.append(oneSubject)
                    }
                    self.tableView.reloadData()
                }
            }
            completion()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Core Data code
    func attemptFetch() {
        let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        self.controller = controller
        
        
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            NSLog("Attempt Fetch error: \(error)")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type) {
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! SubjectCellTableViewCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
                // update code
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        }
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0

//        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
//        return subjects.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SubjectCellTableViewCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: SubjectCellTableViewCell, indexPath: NSIndexPath) {
        
        //let subject = subjects[indexPath.row]
        
        let sub = controller.object(at: indexPath as IndexPath)
        cell.configureCell(subject: sub)
        
//        cell.titleLabel.text = subject.title
//        cell.descLabel.text = subject.desc
//        cell.imageLabel.image = UIImage(named: (subject.imageFile))
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subject = subjects[indexPath.row]
        performSegue(withIdentifier: "QuestionVC", sender: subject)
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? QuestionVC {
            if let subject = sender as? SubjectObj {
                
                // NSLog("SubjectTableVC - subject: \(subject)")
                
                // subject and questions
                destination.questionModel = subject
                
                // quiz state initated and sent over
                quizState.questionCounter = 0
                quizState.questionAnsweredCorrectly = 0
                quizState.maxQuestion = subject.question.count
                quizState.answerPressed = -1
                quizState.isCorrect = false
                
                // NSLog("SubjectTableVC - quizState: \(quizState)")
                
                
                destination.quizState = quizState
                
            }
        }
    }
    
    
}
