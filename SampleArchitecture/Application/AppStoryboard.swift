//
// Created by Mikhail Lysyansky on 25.11.2019.
// Copyright (c) 2019 Mikhail Lysyansky . All rights reserved.
//

import Foundation
import UIKit

enum AppStoryboard : String {
    case Main = "Main"
    case Login = "Login"
    case UserData = "UserData"

    var instance : UIStoryboard {
        UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
}
