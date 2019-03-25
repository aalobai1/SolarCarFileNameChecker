//
//  TableViewController.swift
//  
//
//  Created by Ali Alobaidi on 2/1/19.
//

import UIKit
import Firebase

class TableViewController: UITableViewController {
    
    var partsData = Parts()
    var partsRef: DatabaseReference?
    var partNameDataBaseHandle: DatabaseHandle?
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToMainScreen", sender: nil)
    }
    
    let list = ["ALi", "MO", "Ming"]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Parts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = editButtonItem
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "newCell")
        
        partsRef = Database.database().reference(withPath: "Parts")
        
        partNameDataBaseHandle = partsRef?.observe(.childAdded, with: {(snapshot) in
            
            if let dataBase = snapshot.value as? NSDictionary {
                let partAdded = Part(partName: dataBase.value(forKey: "partName") as! String, description: dataBase.value(forKey: "description") as! String)
                    self.partsData.parts.append(partAdded)
                
                    let partName = self.partsData.parts[0].partName
                
                    print(partName)
                    
                    self.tableView.reloadData()
               
                
                
            }
        })
        
        
       
    }
    
    

    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return partsData.parts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newCell", for: indexPath)
        
        let partNames = partsData.parts[indexPath.row].partName

        print("Part names in parts array: \(partNames)")

        cell.textLabel?.text = partNames

        print(partsData.parts[indexPath.row])
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let delelteRef = partsRef?.child(self.partsData.parts[indexPath.row].partName)
            delelteRef?.removeValue()
            print(self.partsData.parts[indexPath.row].partName)
            self.partsData.parts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert {
            performSegue(withIdentifier: "goToPart", sender: nil)
        }
    }
    
   

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
