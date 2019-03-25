//
//  PartViewController.swift
//  SolarCarFileNameChekcer
//
//  Created by Ali Alobaidi on 1/30/19.
//  Copyright © 2019 Ali Alobaidi. All rights reserved.
//

import UIKit
import Firebase

class PartViewController: UIViewController {

    var ref: DatabaseReference?
    var partsData = Parts()
    var tableView = TableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var nameOfPart: UILabel!
    @IBOutlet weak var partNumLabel: UITextField!
    @IBOutlet weak var assemblyNumber: UITextField!
    @IBOutlet weak var descriptionTextfield: UITextField!
    
    @IBAction func generatePartName(_ sender: Any) {
        addPartNameToFirebase()
    }
    
    
    
    func addPartNameToFirebase() {
        if let partText = partNumLabel.text,
            let assemblyText = assemblyNumber.text,
            let descriptionOfPart = descriptionTextfield.text {
                    tableView.tableView.beginUpdates()
                    if let characterCount = partNumLabel.text?.count,
                    let assemCharacterCount = assemblyNumber.text?.count {
                        
                        if characterCount <= 2 && assemCharacterCount <= 2 {
                            
                            let partName = "SSC19-P\(partText)\(assemblyText)"
                            let partAdded = Part(partName: partName, description: descriptionOfPart)
                            
                            self.partsData.addPart(part: partAdded)         //Add part to Parts array
                            
                            self.nameOfPart.text = "Part Name: \(partName)" //Set name of label
                            
                            
                            //Add parts to Database
                            
                        self.ref?.child("Parts").child(partName).child("description").setValue(descriptionOfPart)
                        self.ref?.child("Parts").child(partName).child("partName").setValue(partName)
                            
                            
                        }
                        else {
                            nameOfPart.text? = "Invalid Part or Assembly Name"
                        }
                    tableView.tableView.endUpdates()
                    tableView.tableView.reloadData()
            }
        } else {
            nameOfPart.text = "No number was entered"
        }
        
    }
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


