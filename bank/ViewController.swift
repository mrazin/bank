//
//  ViewController.swift
//  bank
//
//  Created by WSR on 14/10/2019.
//  Copyright © 2019 WSR. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftyXMLParser
class ViewController: UIViewController {
    
    var user = ""
    var pass = ""
    var token = ""
    @IBOutlet weak var dateLaba: UILabel!
    @IBOutlet weak var usdLaba: UILabel!
    @IBOutlet weak var eurLaba: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        curs()
      
    }
    
    
    
    func auth() {
                let url = "http://api.areas.su/login?username=\(user)&password=\(pass)"
        Alamofire.request(url, method: .post).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        print("JSON: \(json)")
                        if json["notice"]["token"].stringValue != "" {
                            self.token = json["notice"]["token"].stringValue
                            UserDefaults.standard.set(self.user, forKey: "user")
                            UserDefaults.standard.set(self.token, forKey: "tok")
                            self.performSegue(withIdentifier: "segueuser", sender: self)
                        } else {
                            let errorAlert = UIAlertController(title: "Ошибка", message: "Неверный логин или пароль.", preferredStyle: .alert)
                            errorAlert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
                            self.present(errorAlert, animated: true, completion: nil)
                        }
                    case .failure(let error):
                        let errorAlert = UIAlertController(title: "Ошибка", message: "Неверный логин или пароль.", preferredStyle: .alert)
                                                  errorAlert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
                                                  self.present(errorAlert, animated: true, completion: nil)
                        print(error)
                    }
                }
    }
    func curs() {
        let date = Date()
        let formater = DateFormatter()
        formater.dateStyle = .short
        formater.timeStyle = .none
        formater.dateFormat = "dd/MM/yyyy"
        let data = formater.string(from: date)
   print(data)
     formater.dateFormat = "dd.MM.yyyy"
        let labaDate = formater.string(from: date)
        dateLaba.text = String(labaDate)
        let url = "http://www.cbr.ru/scripts/XML_daily.asp?date_req=\(data)"
        Alamofire.request(url, method: .get )
            .responseData { response in
                if let data = response.data {
                    let xml = XML.parse(data)
                    let count = xml["ValCurs"]["Valute"].all?.count
                    print(count)
                    if count != nil {
                        for i in 0..<count! {
                        if xml["ValCurs"]["Valute"][i]["CharCode"].text == "USD" {
                            if let innt = xml["ValCurs"]["Valute"][i]["Value"].double {
                            self.usdLaba.text = String(format: "%2f", innt)
                            }
                        }
                            
                        if xml["ValCurs"]["Valute"][i]["CharCode"].text == "EUR" {
                            if let innt = xml["ValCurs"]["Valute"][i]["Value"].double {
                            self.eurLaba.text = String(format: "%2f", innt)
                            }
                        }
                    }
                    } else {
                        print("Sosamba")
                    }
                    
}

}
}
    
    @IBAction func auth(_ sender: Any) {
        let alert = UIAlertController(title: "Авторизация", message: "Введите Ваш логин и пароль.", preferredStyle: .alert)
                   alert.addTextField { (user) in
                       user.placeholder = "Username"
                   }
                   alert.addTextField { (pass) in
                       pass.placeholder = "Password"
                    pass.isSecureTextEntry = true
                   }
                   alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
                   alert.addAction(UIAlertAction(title: "Войти", style: .default, handler: { (action) in
                    self.user = alert.textFields![0].text!
                    self.pass = alert.textFields![1].text!
                    self.auth()
                       
                   }))
                   present(alert,animated: true, completion: nil)
               }
               
    }
    
    
    









