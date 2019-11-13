//
// Created by user on 13.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//
import UIKit

class UserDataDetailsViewController: UIViewController {

    static let identifier = "UserDataDetailsViewController"
    var viewModel: UserDataDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load \(self)")
        if let viewModel = viewModel {
            viewModel.viewDidLoad()
        }
    }
}
