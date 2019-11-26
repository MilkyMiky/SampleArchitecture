//
// Created by Mikhail Lysyansky on 26.11.2019.
// Copyright (c) 2019 Mikhail Lysyansky . All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController : UIViewController {

    var viewModel: ProfileViewModel?

    @IBAction func logoutClicked(_ sender: Any) {
        viewModel?.logout(vc: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
