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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}

extension SwinjectStoryboard {
    @objc class func setup() {
        let remoteUserRepository = "RemoteUserRepository"
        let realmUserRepository = "RealmUserRepository"

        //        MARK: Repo
        defaultContainer.register(UserRepository.self, name: remoteUserRepository) { _ in RemoteUserRepository()}
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

        //        MARK: ViewModel
        defaultContainer.register(MainViewModel.self) { resolver in
            MainViewModel(fetchDataUseCase: resolver.resolve(FetchDataUseCase.self)!)
        }

        //        MARK: View
        defaultContainer.storyboardInitCompleted(MainViewController.self) { (resolver, viewController) in
            viewController.viewModel = resolver.resolve(MainViewModel.self)
        }
    }
}
