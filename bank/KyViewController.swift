//
//  KyViewController.swift
//  bank
//
//  Created by WSR on 14/10/2019.
//  Copyright © 2019 WSR. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftyXMLParser
class KyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var dateLaba: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var arrayCharCode: [String] = []
    var arrayName: [String] = []
    var arraySell: [String] = []
      var arrayBuy: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
kyView()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.dateFormat = "dd.MM.yyyy"
        let data = formatter.string(from: date)
        dateLaba.text = data
        // Do any additional setup after loading the view.
    }
    

    
    func kyView() {
        let url = "http://api.areas.su/valute"
       Alamofire.request(url, method: .get).validate().responseJSON { response in
           switch response.result {
           case .success(let value):
               let json = JSON(value)
               print("JSON: \(json)")
               for i in 0..<json.count {
                self.arrayName.append(json[i]["name"].stringValue)
                self.arrayCharCode.append(json[i]["charcode"].stringValue)
                         let ss = json[i]["sell"].doubleValue
                let sell = ss + ss*0.1
                let bb = json[i]["buy"].doubleValue
                let buy = bb + bb*0.1
                self.arrayBuy.append(String(buy))
                 self.arraySell.append(String(sell))
            }
               self.tableView.reloadData()
           case .failure(let error):
               print(error)
           }
       }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // #warning Incomplete implementation, return the number of rows
    return arrayBuy.count
   }

  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cellK", for: indexPath) as! KyTableViewCell
       
        cell.kyLaba.text = arrayCharCode[indexPath.row]
        cell.opisCursLaba.text = arrayName[indexPath.row]
        cell.pokypkaLaba.text = arrayBuy[indexPath.row]
        cell.prodaLaba.text = arraySell[indexPath.row]

       return cell
   }

}
