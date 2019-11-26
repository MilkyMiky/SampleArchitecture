//
// Created by Mikhail Lysyansky on 25.11.2019.
// Copyright (c) 2019 Mikhail Lysyansky . All rights reserved.
//

import Foundation
import UIKit

class LoginViewController : UIViewController {

    @IBAction func loginClicked(_ sender: Any) {
        viewModel?.login(vc: self)
    }
    
    var viewModel: LoginViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewModel = viewModel {

        }
    }
}
