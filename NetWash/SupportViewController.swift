//
//  SupportViewController.swift
//  NetWash
//
//  Created by Kasun Chameera on 1/9/19.
//  Copyright © 2019 PK Software Solutions. All rights reserved.
//

import UIKit
import WebKit
import CoreData
import MaterialComponents.MDCSnackbarManager

class SupportViewController: UIViewController {

    @IBOutlet weak var btnMenuItem: UIBarButtonItem!
    @IBOutlet weak var webView: WKWebView?
    
    var anlagging:String!
    var dittMedlemNr:String!
    var losenord:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenuItem.target=revealViewController()
        btnMenuItem.action=#selector(SWRevealViewController.revealToggle(_:))
        self.title="Support"
        // Do any additional setup after loading the view.
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        request.returnsObjectsAsFaults = false
        
        
        do{
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject]{
                anlagging = data.value(forKey: "anlaggning") as! String
                dittMedlemNr = data.value(forKey: "dittMedlemsNr") as! String
                losenord = data.value(forKey: "losenord") as! String
                
            }
        }catch _ as NSError{
            let message = MDCSnackbarMessage()
            message.text = "Data Fetching Failed.. Please try again later.."
            MDCSnackbarManager.show(message)
        }
        
        print(anlagging)
        if(anlagging != nil){
            let url = URL(string: "http://support.wash-it.se?anl="+anlagging)!
            let request1 = URLRequest(url:url)
            webView?.load(request1)
            webView?.allowsBackForwardNavigationGestures = true
        }
        
        
        
        
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

}
