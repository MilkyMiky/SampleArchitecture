//
// Created by user on 13.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class AppContainer {
    private let remoteUserRepository = "RemoteUserRepository"
    private let realmUserRepository = "RealmUserRepository"

    static let instance = AppContainer()
    let container = Container()

    private init() {
        Container.loggingFunction = nil
        registerDataDependencies()
        registerDomainDependencies()
        registerPresentationDependencies()
    }

    private func registerDataDependencies() {
        //        MARK: Network
        container.register(RxMoyaProvider.self) { _ in RxMoyaProvider<UserAPIService>()}

        //        MARK: Repositories
        container.register(UserRepository.self, name: remoteUserRepository) { resolver in
            RemoteUserRepository(rxMoyaProvider: resolver.resolve(RxMoyaProvider.self)!)
        }
        container.register(UserRepository.self, name: realmUserRepository) { _ in RealmUserRepository()}

        //        MARK: Services
        container.register(UserService.self) { resolver in
            UserServiceImpl(
                    realmRepo: resolver.resolve(UserRepository.self, name: self.realmUserRepository)!,
                    remoteRepo: resolver.resolve(UserRepository.self, name: self.remoteUserRepository)!
            )
        }
    }

    private func registerDomainDependencies() {
        container.register(FetchDataUseCase.self) { resolver in
            FetchDataUseCase(userService: resolver.resolve(UserService.self)!)
        }
        container.register(MarkDataUseCase.self) { resolver in
            MarkDataUseCase(userService: resolver.resolve(UserService.self)!)
        }
        container.register(RefreshDataUseCase.self) { resolver in
            RefreshDataUseCase(userService: resolver.resolve(UserService.self)!)
        }
        container.register(RemoveDataUseCase.self) { resolver in
            RemoveDataUseCase(userService: resolver.resolve(UserService.self)!)
        }
        container.register(GetUserDataUseCase.self) { resolver in
            GetUserDataUseCase(userService: resolver.resolve(UserService.self)!)
        }
    }

    private func registerPresentationDependencies() {
        //        MARK: ViewModels
        container.register(MainViewModel.self) { resolver in
            MainViewModel(
                    fetchDataUseCase: resolver.resolve(FetchDataUseCase.self)!,
                    markDataUseCase: resolver.resolve(MarkDataUseCase.self)!,
                    refreshDataUseCase: resolver.resolve(RefreshDataUseCase.self)!,
                    removeDataUseCase: resolver.resolve(RemoveDataUseCase.self)!
            )
        }

        container.register(UserDataDetailsViewModel.self) { resolver in
            UserDataDetailsViewModel(
                    getUserDataUseCase: resolver.resolve(GetUserDataUseCase.self)!
            )
        }

        //        MARK: ViewControllers
        container.storyboardInitCompleted(MainViewController.self) { (container, viewController) in
            viewController.viewModel = container.resolve(MainViewModel.self)
        }

        container.storyboardInitCompleted(UserDataDetailsViewController.self) { (container, viewController) in
            viewController.viewModel = container.resolve(UserDataDetailsViewModel.self)
        }
    }
}
