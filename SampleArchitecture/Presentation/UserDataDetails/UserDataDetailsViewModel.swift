//
// Created by user on 13.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation
import RxSwift

protocol UserDataDetailsViewModelInput {
    func getUserData(dataId: Int)
}

protocol UserDataDetailsViewModelOutput {
    var userDataSubject: PublishSubject<UserData> { get }
}

class UserDataDetailsViewModel: UserDataDetailsViewModelInput, UserDataDetailsViewModelOutput {
    var userDataSubject: PublishSubject<UserData> = PublishSubject<UserData>()
    private let getUserDataUseCase: GetUserDataUseCase
    private let router: Router

    init(getUserDataUseCase: GetUserDataUseCase, router: Router) {
        self.getUserDataUseCase = getUserDataUseCase
        self.router = router
    }

    func getUserData(dataId: Int) {
        getUserDataUseCase.execute(dataId: dataId)
                .map {
                    self.userDataSubject.onNext($0)
                }
                .subscribe()

    }
}
