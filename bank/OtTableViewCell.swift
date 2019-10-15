//
//  OtTableViewCell.swift
//  bank
//
//  Created by WSR on 14/10/2019.
//  Copyright © 2019 WSR. All rights reserved.
//

import UIKit

class OtTableViewCell: UITableViewCell {

    
    @IBOutlet weak var rejLaba: UILabel!
    @IBOutlet weak var typeLaba: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var adresLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
