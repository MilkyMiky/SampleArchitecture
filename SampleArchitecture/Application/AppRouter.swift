//
// Created by user on 13.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation
import UIKit

protocol Router {
    func openUserDataDetailsViewController(viewController: UIViewController, dataId: Int)
}

class AppRouter : Router {
    let mainStoryboardName = "Main"

    func openUserDataDetailsViewController(viewController: UIViewController, dataId: Int) {
        let storyBoard: UIStoryboard = UIStoryboard(name: mainStoryboardName, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: UserDataDetailsViewController.identifier)
                as! UserDataDetailsViewController
        newViewController.userDataId = dataId
        viewController.navigationController?.pushViewController(newViewController, animated: true)
    }
}
