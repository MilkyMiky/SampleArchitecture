//
//  AppDelegate.swift
//  SampleArchitecture
//
//  Created by user on 06.11.2019.
//  Copyright © 2019 user. All rights reserved.
//
import Swinject
import SwinjectStoryboard
import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let realmSchemaVersion : UInt64 = 1

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureRealm()
        return true
    }

    private  func configureRealm() {
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
        let remoteUserRepository = "RemoteUserRepository"
        let realmUserRepository = "RealmUserRepository"

        //        MARK: Network
        defaultContainer.register(RxMoyaProvider.self) { _ in RxMoyaProvider<UserAPIService>()}

        //        MARK: Repo
        defaultContainer.register(UserRepository.self, name: remoteUserRepository) { resolver in
            RemoteUserRepository(rxMoyaProvider: resolver.resolve(RxMoyaProvider.self)!)
        }
        defaultContainer.register(UserRepository.self, name: realmUserRepository) { _ in RealmUserRepository()}

        //        MARK: Service
        defaultContainer.register(UserService.self) { resolver in
            UserServiceImpl(
                    realmRepo: resolver.resolve(UserRepository.self, name: realmUserRepository)!,
                    remoteRepo: resolver.resolve(UserRepository.self, name: remoteUserRepository)!
            )
        }

        //        MARK: UseCase
        defaultContainer.register(FetchDataUseCase.self) { resolver in
            FetchDataUseCase(userService: resolver.resolve(UserService.self)!)
        }
        defaultContainer.register(MarkDataUseCase.self) { resolver in
            MarkDataUseCase(userService: resolver.resolve(UserService.self)!)
        }
        defaultContainer.register(RefreshDataUseCase.self) { resolver in
            RefreshDataUseCase(userService: resolver.resolve(UserService.self)!)
        }
        defaultContainer.register(RemoveDataUseCase.self) { resolver in
            RemoveDataUseCase(userService: resolver.resolve(UserService.self)!)
        }

        //        MARK: ViewModel
        defaultContainer.register(MainViewModel.self) { resolver in
            MainViewModel(
                    fetchDataUseCase: resolver.resolve(FetchDataUseCase.self)!,
                    markDataUseCase: resolver.resolve(MarkDataUseCase.self)!,
                    refreshDataUseCase: resolver.resolve(RefreshDataUseCase.self)!,
                    removeDataUseCase: resolver.resolve(RemoveDataUseCase.self)!
            )
        }

        //        MARK: View
        defaultContainer.storyboardInitCompleted(MainViewController.self) { (resolver, viewController) in
            viewController.viewModel = resolver.resolve(MainViewModel.self)
        }
    }
}
