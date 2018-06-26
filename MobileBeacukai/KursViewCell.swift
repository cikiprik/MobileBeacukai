//
//  KursViewCell.swift
//  MobileBeacukai
//
//  Created by DEWA on 5/19/18.
//  Copyright © 2018 beacukai. All rights reserved.
//

import UIKit

class KursViewCell: UITableViewCell {
    @IBOutlet weak var imgFlag: UIImageView!
    
    @IBOutlet weak var curNegara: UILabel!
    
    @IBOutlet weak var value: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
