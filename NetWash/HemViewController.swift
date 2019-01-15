//
//  HemViewController.swift
//  NetWash
//
//  Created by Kasun Chameera on 1/9/19.
//  Copyright © 2019 PK Software Solutions. All rights reserved.
//

import UIKit

class HemViewController: UIViewController {

    @IBOutlet weak var btnMenuItem: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMenuItem.target=revealViewController()
        btnMenuItem.action=#selector(SWRevealViewController.revealToggle(_:))
        self.title="Hem"
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

}
