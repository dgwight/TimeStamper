//
//  TimeStampCell.swift
//  Patient Timestamper
//
//  Created by Dylan Wight on 3/30/16.
//  Copyright © 2016 Dylan Wight. All rights reserved.
//

import UIKit

class TimestampTableViewCell: UITableViewCell {

    @IBOutlet weak var patientId: UILabel!
    @IBOutlet weak var action: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var notes: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
            // Initialization code
        }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}