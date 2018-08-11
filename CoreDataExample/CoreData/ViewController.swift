//
//  ViewController.swift
//  CoreDataExample
//
//  Created by Himanshu Chimanji on 11/08/18.
//  Copyright © 2018 Talent4assure. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var userNameTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func ShowCoreDataButton(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowDataSegue", sender: self)
    }
    
    @IBAction func submitButton(_ sender: UIButton) {
        let userNames = userNameTf.text
        let passwords = passwordTf.text
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
                let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
                newUser.setValue(userNames, forKey: "userName")
                newUser.setValue(passwords, forKey: "password")
        
                do
                {
                    try context.save()
                    print("Saved")
                    userNameTf.text = ""
                    passwordTf.text = ""
                }
                catch
                {
                    // Process Error
                }
    }
    
}

