//
//  OtViewController.swift
//  bank
//
//  Created by WSR on 14/10/2019.
//  Copyright © 2019 WSR. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class Pin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    init(coor: CLLocationCoordinate2D) {
        self.coordinate = coor
    }
}
class OtViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate {

    
    var arrayClose: [String] = []
      var arrayOpen: [String] = []
      var arrayAdres: [String] = []
        var arrayType: [String] = []
       var arrayRej: [String] = []
    var arrayLon: [Double] = []
     var arrayLat: [Double] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mappView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
otd()
        
        // Do any addiional setup after loading the view.
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
        return arrayAdres.count
       }
    
    
    func otd() {
        let url = "http://api.areas.su/bankomats"
         Alamofire.request(url, method: .get).validate().responseJSON { response in
             switch response.result {
             case .success(let value):
                 let json = JSON(value)
                 print("JSON: \(json)")
                 for i in 0..<json.count {
                    self.arrayType.append(json[i]["type"].stringValue)
                    self.arrayAdres.append(json[i]["address"].stringValue)
                    self.arrayOpen.append(json[i]["hours_start"].stringValue)
                     self.arrayClose.append(json[i]["hours_end"].stringValue)
                    self.arrayLat.append(json[i]["lat"].doubleValue)
                     self.arrayLon.append(json[i]["lon"].doubleValue)
                    
              }
                 self.addMapAnnot()
                 self.tableView.reloadData()
             case .failure(let error):
                 print(error)
             }
         }
       
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cellO", for: indexPath) as! OtTableViewCell
            cell.adresLabel.text = arrayAdres[indexPath.row]
            cell.typeLaba.text = arrayType[indexPath.row]
            cell.timeLabel.text = "Часы работы " + arrayOpen[indexPath.row] + "-" + arrayClose[indexPath.row]
            
           // Configure the cell...

           return cell
       }
   
  func  addMapAnnot() {
        for i in 0..<arrayLat.count {
            let pin = Pin(coor: CLLocationCoordinate2DMake(arrayLat[i], arrayLon[i]))
            mappView.addAnnotation(pin)
        }
   
    let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: arrayLat.first!, longitude: arrayLon.first!), latitudinalMeters: 1500, longitudinalMeters: 1500)
        mappView.setRegion(region, animated: true)
    }


}
