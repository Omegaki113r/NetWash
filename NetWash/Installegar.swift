//
//  Installegar.swift
//  NetWash
//
//  Created by Kasun Chameera on 1/9/19.
//  Copyright © 2019 PK Software Solutions. All rights reserved.
//

import UIKit
import Alamofire
import MaterialComponents.MaterialSnackbar
import CoreData

class Installegar: UIViewController {

    
    @IBOutlet weak var btnMenuItem: UIBarButtonItem!
    @IBOutlet weak var anlaggning: UITextField!
    @IBOutlet weak var dittMedlemsNr: UITextField!
    @IBOutlet weak var losenord: UITextField!
    
    var context:NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenuItem.target=revealViewController()
        btnMenuItem.action=#selector(SWRevealViewController.revealToggle(_:))
        
        self.title="Installningar"
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        context = appdelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        request.returnsObjectsAsFaults = false

        
        do{
            let result = try context?.fetch(request)
            
            for data in result as! [NSManagedObject]{
                anlaggning.text = data.value(forKey: "anlaggning") as? String
                dittMedlemsNr.text = data.value(forKey: "dittMedlemsNr") as? String
                losenord.text = data.value(forKey: "losenord") as? String
            }
        }catch _ as NSError{
            let message = MDCSnackbarMessage()
            message.text = "Data Fetching Failed.. Please try again later.."
            MDCSnackbarManager.show(message)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func saveDetails(_ sender: UIButton) {
        
        let message = MDCSnackbarMessage()
        
        guard let area=anlaggning.text else {
            message.text = "Please insert the anlagging..."
            MDCSnackbarManager.show(message)
            return
        }
        guard let user = dittMedlemsNr.text else {
            message.text = "Please insert the ditt meldems nr."
            MDCSnackbarManager.show(message)
            return
        }
        guard let password = losenord.text else {
            message.text = "Please insert the losenord"
            MDCSnackbarManager.show(message)
            return
        }
        
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context!)
        let newUser = NSManagedObject(entity: entity!, insertInto: context!)
        
        newUser.setValue(area, forKey: "anlaggning")
        newUser.setValue(user, forKey: "dittMedlemsNr")
        newUser.setValue(password, forKey: "losenord")
        
        do{
            try context?.save()
            let message = MDCSnackbarMessage()
            message.text = "Data Successfully Saved..."
            MDCSnackbarManager.show(message)
        }catch{
            let message = MDCSnackbarMessage()
            message.text = "Saving Failed.. Please try again later.."
            MDCSnackbarManager.show(message)
            print("Comitted")
        }
        
        
    }
}
