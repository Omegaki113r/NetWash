//
//  ViewController.swift
//  NetWash
//
//  Created by Kasun Chameera on 1/9/19.
//  Copyright © 2019 PK Software Solutions. All rights reserved.
//

import UIKit
import WebKit
import CoreData
import MaterialComponents.MDCSnackbarManager

class ViewController: UIViewController {

    @IBOutlet weak var btnMenuItem: UIBarButtonItem!
    @IBOutlet weak var webView: WKWebView!
    
    var anlagging:String!
    var dittMedlemNr:String!
    var losenord:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnMenuItem.target=revealViewController()
        btnMenuItem.action=#selector(SWRevealViewController.revealToggle(_:))
        self.title="Boka"
        
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
        let url = URL(string: "http://www.lkjz.se/send.aspx?s="+anlagging+"&l="+dittMedlemNr+"&p="+losenord)!
        let request1 = URLRequest(url:url)
        webView?.load(request1)
        webView?.allowsBackForwardNavigationGestures = true
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

