//
//  UserViewController.swift
//  bank
//
//  Created by WSR on 14/10/2019.
//  Copyright © 2019 WSR. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class UserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var user = ""
  
    @IBOutlet weak var creditTable: UITableView!
    @IBOutlet weak var schetaTable: UITableView!
    @IBOutlet weak var cartsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let userU = UserDefaults.standard.string(forKey: "user") {
            user = userU
            // Do any additional setup after loading the view.
        }
        
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

   
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == cartsTable {
             let cell = tableView.dequeueReusableCell(withIdentifier: "cellCarts", for: indexPath) as! CartsTableViewCell
                return cell
        }
        else if tableView == creditTable {
             let cell = tableView.dequeueReusableCell(withIdentifier: "cellCredits", for: indexPath) as! CreditTableViewCell
                return cell
        } else {
             let cell = tableView.dequeueReusableCell(withIdentifier: "cellCheta", for: indexPath) as! SchetaTableViewCell
        
                return cell
        }


    }
   
}





