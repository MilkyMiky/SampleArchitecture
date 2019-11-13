//
//  AppDelegate.swift
//  SampleArchitecture
//
//  Created by user on 06.11.2019.
//  Copyright © 2019 user. All rights reserved.
//

import SwinjectStoryboard
import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let realmSchemaVersion: UInt64 = 1

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureRealm()
        return true
    }

    private func configureRealm() {
        let configuration = Realm.Configuration(
                schemaVersion: realmSchemaVersion,
                migrationBlock: { migration, oldSchemaVersion in
                    if oldSchemaVersion < self.realmSchemaVersion {
                        print("Update Realm DB")
                    }
                }
        )
        Realm.Configuration.defaultConfiguration = configuration
//        let realm = try! Realm()
    }
}

extension SwinjectStoryboard {
    @objc class func setup() {
        defaultContainer = AppContainer.instance.container
    }
}
