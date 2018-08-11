//
//  UpdateCoreDataViewController.swift
//  CoreDataExample
//
//  Created by Himanshu Chimanji on 11/08/18.
//  Copyright © 2018 Talent4assure. All rights reserved.
//

import UIKit
import CoreData

class UpdateCoreDataViewController: UIViewController , UIPickerViewDataSource , UIPickerViewDelegate {

    @IBOutlet weak var selectUserNameTf: UITextField!
    @IBOutlet weak var newUserNameTf: UITextField!
    @IBOutlet weak var newUserPassword: UITextField!
    
    var userNameUArray = [String]()
    let picker = UIPickerView()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        picker.dataSource = self
        picker.delegate = self
        

        
        selectUserNameTf.inputView = picker
        userNameDataExtract()
    }
    
    func userNameDataExtract()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        do
        {
            let results = try context.fetch(request)
            if results.count > 0
            {
                for result in results as! [NSManagedObject]
                {
                    if let userName = result.value(forKey: "userName")
                    {
                        print("User Name:\(userName)")
                        userNameUArray.append(userName as! String)
                    }
                }
            }
            else
            {
                print("Noo Data Found")
            }
            
        }
        catch
        {
            
        }
    }
    
    @IBAction func showDataButton(_ sender: UIButton) {
        performSegue(withIdentifier: "UCSCSegue", sender: self)
    }
    @IBAction func updateDetail(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        do
        {
            let results = try context.fetch(request)
            if results.count > 0
            {
                for result in results as! [NSManagedObject]
                {
                    if let userName = result.value(forKey: "userName") as? String
                    {
                        if userName == selectUserNameTf.text
                        {
                            if newUserNameTf.text?.isEmpty == false
                            {
                                result.setValue(newUserNameTf.text, forKey: "userName")
                            }
                            if newUserPassword.text?.isEmpty == false
                            {
                                result.setValue(newUserPassword.text, forKey: "password")
                            }
                            
                            do
                            {
                                try context.save()
                                newUserPassword.text = ""
                                newUserNameTf.text = ""
                                selectUserNameTf.text = nil
                                userNameUArray.removeAll()
                                userNameDataExtract()
                            }
                            catch
                            {
                                
                            }
                        }
                    }
                }
            }
            else
            {
                print("Noo Data Found")
            }
            
        }
        catch
        {
            
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return userNameUArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return userNameUArray.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectUserNameTf.text = userNameUArray[row]
                self.view.endEditing(false)
        
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
