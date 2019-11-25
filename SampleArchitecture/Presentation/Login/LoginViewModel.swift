//
// Created by Mikhail Lysyansky on 25.11.2019.
// Copyright (c) 2019 Mikhail Lysyansky . All rights reserved.
//

import Foundation

class LoginViewModel {

    private let loginUseCase: LoginUseCase
    private let router: Router

    init(loginUseCase: LoginUseCase, router: Router) {
        self.loginUseCase = loginUseCase
        self.router = router
    }

    func login() {
        print("login")
        loginUseCase.execute(userCredentials: UserCredentials(login: "login", password: "pswd"))
                .do(onCompleted: { print("ok")})
        .subscribe()

    }
}
