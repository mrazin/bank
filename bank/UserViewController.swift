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
class UserViewController: UIViewController,UISearchBarDelegate {
    var user = ""
    @IBOutlet weak var searchView: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.placeholder = "Search"
        if let userU = UserDefaults.standard.string(forKey: "user") {
            user = userU
            // Do any additional setup after loading the view.
        }
        
    }
    
    
    @IBAction func logout(_ sender: Any) {
        let errorAlert = UIAlertController(title: "Выход", message: "Вы уверены, что хотите выйти?", preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Нет", style: .cancel, handler: nil))
        errorAlert.addAction(UIAlertAction(title: "Да", style: .default, handler: { (action) in
            let url = "http://api.areas.su/logout?username=\(self.user)"
            
            Alamofire.request(url, method: .post).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                    
  self.performSegue(withIdentifier: "segueLogout", sender: self)
                    
                case .failure(let error):
                    print(error)
                }
            }
        }))
        
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    
}





