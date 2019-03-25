//
//  AssemblyViewController.swift
//  SolarCarFileNameChekcer
//
//  Created by Ali Alobaidi on 1/30/19.
//  Copyright © 2019 Ali Alobaidi. All rights reserved.
//

import UIKit
import Firebase

class AssemblyViewController: UIViewController {

    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }
    
  
    @IBOutlet weak var assmeblyNum: UITextField!
    @IBOutlet weak var assemblyName: UILabel!
    @IBOutlet weak var assemblyDescriptionlbl: UITextField!
    
    
    
    @IBAction func generateAssemName(_ sender: Any) {
        addAsemToFirebase()
    }
    
    
    
    
    
    
    
    
    func addAsemToFirebase() {
        if let assemText = assmeblyNum.text,
        let asemDescript = assemblyDescriptionlbl.text {
            
            if let assemCharacterCount = assmeblyNum.text?.count {
                    if assemCharacterCount <= 2 {
                        let nameOfAssembly = "SSC19-A\(assemText)"
                        
                        ref?.child("Assemblies").child("Description").child(nameOfAssembly).setValue(asemDescript)
                        
                        assemblyName.text = ("Assembly Name: \(nameOfAssembly)")
                    }
                    
                    else {
                        assemblyName.text? = "Invalid Assembly Name"
                    }
            }
        }
            
        else {
            assemblyName.text = "Missing Parameter"
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
