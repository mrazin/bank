//
//  SchetaTableViewCell.swift
//  bank
//
//  Created by WSR on 15/10/2019.
//  Copyright © 2019 WSR. All rights reserved.
//

import UIKit

class SchetaTableViewCell: UITableViewCell {

    @IBOutlet weak var numberSchet: UILabel!
    @IBOutlet weak var typeLaba: UILabel!
    @IBOutlet weak var summaLaba: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
