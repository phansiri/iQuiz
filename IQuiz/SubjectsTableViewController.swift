//
//  SubjectsTableViewController.swift
//  IQuiz
//
//  Created by Litthideth Phansiri on 11/2/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//

import UIKit

var subjects = [Dictionary<String,String>()]
var subjectCounter: Int = 0

class SubjectsTableViewController: UITableViewController {
    
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
        if subjects.count ==  1 {
            subjects.removeAll()
            subjects.append(["subject": "Mathematics", "descr": "Hard subject", "imageFile": "math icon"])
            subjects.append(["subject": "Science", "descr": "Harder subject", "imageFile": "science icon"])
            subjects.append(["subject": "Marvel Super Heroes", "descr": "Pow!", "imageFile": "hero icon"])
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "iQuizCell", for: indexPath) as! SubjectsTableViewCell
        let subject = subjects[indexPath.row]
        cell.subjectLabel.text = subject["subject"]
        cell.descrLabel.text = subject["descr"]
        cell.imageLabel.image = UIImage(named: (subject["imageFile"])!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        subjectCounter = indexPath.row
        return indexPath
    }
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("Select a row")
        // let indexPathOne = tableView.indexPathsForSelectedRows
        
        // let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        let currentCell = tableView.cellForRow(at: indexPath)
        NSLog("Current cell is: \(currentCell)")
        performSegue(withIdentifier: "subjectSegue", sender: currentCell)
    }
 */
    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "subjectSegue" {
            let newController = segue.destination as! QuizTimeViewController
            if let data = sender as? [String : String]? {
                newController.sentData = data
            }
        
        }
        
    }
 */
    
 
    

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
    
}
