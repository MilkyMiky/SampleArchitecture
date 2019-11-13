//
//  MainTableViewCell.swift
//  SampleArchitecture
//
//  Created by user on 11.11.2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    static let Identifier = "MainTableViewCell"

    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var checkImage : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setUserData(userData: UserData) {
        title.text = userData.userTitle
        checkImage.isHidden = !userData.completed
    }
}
