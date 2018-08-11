//
//  ShowCoreDataViewController.swift
//  CoreDataExample
//
//  Created by Himanshu Chimanji on 11/08/18.
//  Copyright © 2018 Talent4assure. All rights reserved.
//

import UIKit
import CoreData

class ShowCoreDataViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var showCoreDataTableView: UITableView!
    
    var userNameArray = [String]()
    var userPasswordArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showCoreDataTableView.delegate = self
        showCoreDataTableView.dataSource = self
        
        fetchingFromCoreData()
        
    }
    
    func fetchingFromCoreData()
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
                    //                    context.delete(result)
                    
                    if let userName = result.value(forKey: "userName")
                    {
                        print("User Name:\(userName)")
                        userNameArray.append(userName as! String)
                    }
                    if let password = result.value(forKey: "password")
                    {
                        print("Password: \(password)")
                        userPasswordArray.append(password as! String)
                    }
                }
                OperationQueue.main.addOperation {
                    self.showCoreDataTableView.reloadData()
                }
                print(userNameArray)
                print(userPasswordArray)
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
    
    @IBAction func deleteData(_ sender: UIButton) {
        userNameArray.removeAll()
        userPasswordArray.removeAll()
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
                    context.delete(result)
                }
                try context.save()

                OperationQueue.main.addOperation {
                    self.showCoreDataTableView.reloadData()
                }

                
            }
            else
            {
                print(results)
            }
            
        }
        catch
        {
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userNameArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShowCoreDataTableViewCell", for: indexPath) as! ShowCoreDataTableViewCell
        cell.showUserNameLbl.text = userNameArray[indexPath.row]
        cell.showUserPassword.text = userPasswordArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
                    //                    context.delete(result)
                    
                    if let userName = result.value(forKey: "userName") as? String
                    {
                        print("User Name:\(userName)")
                        if userName == userNameArray[indexPath.row]
                        {
                            context.delete(result)
                        }
                    }
                    do
                    {
                        try context.save()
                    }
                    catch
                    {
                        
                    }
                    
                }
                userNameArray.remove(at: indexPath.row)
                userPasswordArray.remove(at: indexPath.row)

                OperationQueue.main.addOperation {
                    self.showCoreDataTableView.reloadData()
                }
                print(userNameArray)
                print(userPasswordArray)
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
}
