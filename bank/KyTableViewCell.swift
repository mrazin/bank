//
//  KyTableViewCell.swift
//  bank
//
//  Created by WSR on 14/10/2019.
//  Copyright © 2019 WSR. All rights reserved.
//

import UIKit

class KyTableViewCell: UITableViewCell {

    @IBOutlet weak var prodaLaba: UILabel!
    
    @IBOutlet weak var pokypkaLaba: UILabel!
    @IBOutlet weak var kyLaba: UILabel!
    @IBOutlet weak var imgKy: UIImageView!
    
    @IBOutlet weak var opisCursLaba: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
