//
//  HistoryViewController.swift
//  bank
//
//  Created by WSR on 15/10/2019.
//  Copyright © 2019 WSR. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class HistoryViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    var arrayDate: [String] = []
    var arrayTime: [String] = []
    var token = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tok = UserDefaults.standard.string(forKey: "tok") {
            token = tok
        }
        appArray()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayTime.count
    }

   
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellHis", for: indexPath) as! HistoryTableViewCell
        cell.dateLaba.text = arrayDate[indexPath.row] + "      " + arrayTime[indexPath.row]
        // Configure the cell...

        return cell
    }
    func appArray() {
        let url = "http://api.areas.su/lastlogin?token=\(token)"
        Alamofire.request(url, method: .post).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for i in 0..<json.count {
                    let date = Date(timeIntervalSince1970: json[i]["date"].doubleValue)
                    let format = DateFormatter()
                    format.timeStyle = .none
                    format.dateStyle = .short
                    format.dateFormat = "dd.MM.yyyy"
                    let data = format.string(from: date)
                                      self.arrayDate.append(data)
                    
                    let dateTime = Date(timeIntervalSince1970: json[i]["date"].doubleValue)
                    let formatTime = DateFormatter()
                    formatTime.timeStyle = .short
                    formatTime.dateStyle = .none
                    formatTime.timeZone = .current
                    let time = formatTime.string(from: dateTime)
                    self.arrayTime.append(time)
                }
                self.tableView.reloadData()
               
            case .failure(let error):
                print(error)
            }
        }
    }
  
}
