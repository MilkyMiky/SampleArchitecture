//
// Created by user on 13.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation
import UIKit

protocol Router {
    func openUserDataDetailsViewController(viewController: UIViewController, dataId: Int)
    func openMainViewController(viewController: UIViewController)
    func openLoginViewController(viewController: UIViewController)
}

class AppRouter: Router {

    func openUserDataDetailsViewController(viewController: UIViewController, dataId: Int) {
        let storyBoard: UIStoryboard = UIStoryboard(name: AppStoryboard.UserData.rawValue, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: UserDataDetailsViewController.identifier)
                as! UserDataDetailsViewController
        newViewController.userDataId = dataId
        viewController.navigationController?.pushViewController(newViewController, animated: true)
    }

    func openMainViewController(viewController: UIViewController) {
        let storyBoard: UIStoryboard = UIStoryboard(name: AppStoryboard.Main.rawValue, bundle: nil)
        let newViewController = storyBoard.instantiateInitialViewController() as! UIViewController
        newViewController.modalPresentationStyle = .overFullScreen
        viewController.present(newViewController, animated: true)
    }

    func openLoginViewController(viewController: UIViewController) {
        let storyBoard: UIStoryboard = UIStoryboard(name: AppStoryboard.Login.rawValue, bundle: nil)
        let newViewController = storyBoard.instantiateInitialViewController() as! UIViewController
        newViewController.modalPresentationStyle = .overFullScreen
        viewController.present(newViewController, animated: true)
    }
}
