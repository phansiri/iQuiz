//
//  SubjectsTableViewController.swift
//  IQuiz
//
//  Created by Litthideth Phansiri on 11/2/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//

import UIKit

class SubjectsTableViewController: UITableViewController {
    /*
    private var subjects = SubjectsTableViewController.getSubjects()
    
    private static func getSubjects() -> [[String:[String:String]]] {
        let subjects = UserDefaults.standard.array(forKey: "saves")
        if subjects == nil {
            return Array()
        } else {
            return subjects as! [[String:[String:String]]]
        }
    }
 */
    //private var subjects = [String:ModelSubject]()
    /*
    var math: ModelSubject = ModelSubject(imageFile: "math icon", subject: "Mathematics", descr: "its hard")
    var hero: ModelSubject = ModelSubject(imageFile: "hero icon", subject: "Marvel Super Heroes", descr: "Pow!")
    var science: ModelSubject = ModelSubject(imageFile: "science icon", subject: "Science", descr: "its harder than meth")
    
    private var math = [
        "image": "math icon",
        "subject": "Mathematics",
        "descr": "Its a hard subject"
    ]
    
    private var hero = [
        "image": "hero icon",
        "subject": "Marvel Super Heroes",
        "descr": "Pow!"
    ]
    
    private var science = [
        "image": "science icon",
        "subject": "Science",
        "descr": "Its a harder subject"
    ]*/

    
    
    
    
    var subjects = [[String:[String:String]]]()
 
    @IBAction func settingsButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        // let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        // alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.subjects.removeAll()
        delegate.addSubjects()
        subjects = delegate.subjects
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return dataSource.count
        return self.subjects.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "iQuizCell", for: indexPath) as! SubjectsTableViewCell
        let subject = self.subjects[indexPath.row]
        let oneSubject = subject["data"]
        //let oneSubject = subject
        cell.subjectLabel.text = oneSubject?["subject"]
        cell.descrLabel.text = oneSubject?["descr"]
        cell.imageLabel.image = UIImage(named: (oneSubject?["imageFile"])!)
        /*
        let subject = dataSource[indexPath.row]
        cell.subjectLabel.text = subject.subject
        cell.descrLabel.text = subject.descr
        let imageFile = subject.imageFile
        cell.imageLabel.image = UIImage(named: imageFile!)
*/
        // Configure the cell...

        return cell
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
            
            self.subjects.remove(at: indexPath.row)
            var arr = SubjectsTableViewController.getSubjects()
            arr.remove(at: indexPath.row)
            UserDefaults.standard.set(arr, forKey: "saves")
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
