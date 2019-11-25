//
// Created by Mikhail Lysyansky on 25.11.2019.
// Copyright (c) 2019 Mikhail Lysyansky . All rights reserved.
//

import Foundation
import RxSwift

class LoginUseCase {
    private let userCredentialsService : UserCredentialsService

    init(userCredentialsService : UserCredentialsService) {
        self.userCredentialsService = userCredentialsService
    }

    func execute(userCredentials: UserCredentials) -> Completable {
        userCredentialsService.saveUserCredentials(userCredentials: userCredentials)
    }
}
