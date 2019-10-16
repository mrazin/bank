//
//  InfoViewController.swift
//  bank
//
//  Created by WSR on 15/10/2019.
//  Copyright © 2019 WSR. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var user = ""
    var token = ""
    var arrayTabl = ["Изменение пароля", "Изменение логина", "История посещений", "Информация о приложении", "Выход"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tokU = UserDefaults.standard.string(forKey: "tok") {
            token = tokU
        }
        // Do any additional setup after loading the view.
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          // #warning Incomplete implementation, return the number of rows
        return arrayTabl.count
      }

      
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "cellInfo", for: indexPath) as! InfoTableViewCell
        cell.infoLaba.text = arrayTabl[indexPath.row]
          // Configure the cell...

          return cell
      }
    
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let alert = UIAlertController(title: "Изменение пароля", message: "Введите новый пароль", preferredStyle: .alert)
            alert.addTextField { (t) in
                t.placeholder = "Password"
                t.isSecureTextEntry = true
            }
            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Изменить", style: .default, handler: { (action) in
                let userpass = alert.textFields![0].text!
                let url = "http://api.areas.su/editepassword?token=\(self.token)&password=\(userpass)"
                   Alamofire.request(url, method: .put).validate().responseJSON { response in
                       switch response.result {
                       case .success(let value):
                           let json = JSON(value)
                           print("JSON: \(json)")
                        let alertok = UIAlertController(title: "Успешно", message: "Пароль изменен.", preferredStyle: .alert)
                                  alertok.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
                           self.present(alertok, animated: true, completion: nil)
                       case .failure(let error):
                           print(error)
                       }
                   }
            }))
            present(alert, animated: true, completion: nil)
        }
         
        if indexPath.row == 1 {
                   let alert = UIAlertController(title: "Изменение логина", message: "Введите новый логин", preferredStyle: .alert)
                   alert.addTextField { (t) in
                       t.placeholder = "Логин"
                   }
                   alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
                   alert.addAction(UIAlertAction(title: "Изменить", style: .default, handler: { (action) in
                    let username = alert.textFields![0].text!
                    let url = "http://api.areas.su/editeusername?token=\(self.token)&username=\(username)"
                       Alamofire.request(url, method: .put).validate().responseJSON { response in
                           switch response.result {
                           case .success(let value):
                               let json = JSON(value)
                               print("JSON: \(json)")
                            let alertok = UIAlertController(title: "Успешно", message: "Логин изменен.", preferredStyle: .alert)
                                      alertok.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
                               self.present(alertok, animated: true, completion: nil)
                           case .failure(let error):
                               print(error)
                           }
                       }
                   }))
             present(alert, animated: true, completion: nil)
               }
        if indexPath.row == 2 {
             performSegue(withIdentifier: "segueTB2", sender: self)
        }
        if indexPath.row == 3 {
                   performSegue(withIdentifier: "segueTB3", sender: self)
               }
        
        if indexPath.row == 4 {
            if let log = UserDefaults.standard.string(forKey: "user") {
               user = log
            }
            let url = "http://api.areas.su/logout?username=\(user)"
                   Alamofire.request(url, method: .post).validate().responseJSON { response in
                       switch response.result {
                       case .success(let value):
                           let json = JSON(value)
                           self.performSegue(withIdentifier: "segueAuth", sender: self)
                           print("JSON: \(json)")
                       case .failure(let error):
                           print(error)
                       }
                   }
               }
        
    }
    
    

}
