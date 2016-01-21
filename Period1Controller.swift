//
//  Period1Controller.swift
//  final
//
//  Created by student1 on 1/13/16.
//  Copyright © 2016 John Hersey High school. All rights reserved.
//

import UIKit
import CoreData

class Period1Controller: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var enterName: UITextField!
    @IBOutlet weak var presentName: UITextView!
    @IBOutlet weak var independceStatue: UITextField!
    @IBOutlet weak var driverSelection: UITextField!
    
    
    var entitys = [NSManagedObject]()
    var nameList : [String] = []
    var period1 = ""
    var period1NameList = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let request = NSFetchRequest(entityName: "Entity")
        
        do {
            let results = try context.executeFetchRequest(request)
            entitys = results as! [NSManagedObject]
        } catch let error as NSError {
    print("Could not fetch \(error), \(error.userInfo)")
        }
        let otherEntity = entitys.last
        if otherEntity != nil {
            let stringEntity = otherEntity!.valueForKey("period1Core")as? String
            presentName.text = ("  " + stringEntity!)
        }
       
    }

   
    func setValues() {
        nameList = [enterName.text!]
    }
    
    @IBAction func setName(sender: UIButton) {
        setValues()
        for item in nameList{
            period1 += (item + "  ")
            period1NameList += item
        }
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let entity = NSEntityDescription.entityForName("Entity", inManagedObjectContext: context)
        let otherEntity = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: context)
        otherEntity.setValue(period1NameList, forKey: "period1Core")
        do {
            try context.save()
            print("Item Saved")
        } catch {
            print("Saved Failed")
        }
        presentName.text = period1
        enterName.text = ""
        print(otherEntity)
    }

    @IBAction func start(sender: UIButton) {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let request = NSFetchRequest(entityName: "Entity")
        //var results = [AnyObject]()
        do {
            let results = try context.executeFetchRequest(request)
            entitys = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        let randomIndex = Int(arc4random_uniform(UInt32(entitys.count)))
        driverSelection.text! = nameList[randomIndex]
        print(randomIndex)

    }
    
}

