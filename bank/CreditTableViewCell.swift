//
//  CreditTableViewCell.swift
//  bank
//
//  Created by WSR on 15/10/2019.
//  Copyright © 2019 WSR. All rights reserved.
//

import UIKit

class CreditTableViewCell: UITableViewCell {

    @IBOutlet weak var summaLaba: UILabel!
    @IBOutlet weak var datePlatiLaba: UILabel!
    @IBOutlet weak var typeLaba: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
