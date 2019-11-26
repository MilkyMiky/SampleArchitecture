//
// Created by Mikhail Lysyansky on 26.11.2019.
// Copyright (c) 2019 Mikhail Lysyansky . All rights reserved.
//

import Foundation

class ProfileViewModel {
    private let logoutUseCase: LogoutUseCase
    private let router: Router

    init(logoutUseCase: LogoutUseCase, router: Router) {
        self.logoutUseCase = logoutUseCase
        self.router = router
    }

    func logout(vc: ProfileViewController) {
        logoutUseCase.execute()
                .do(onCompleted: { self.router.openLoginViewController(viewController: vc) })
                .subscribe()
    }
}
