//
//  FetchDataUseCase.swift
//  SampleArchitecture
//
//  Created by user on 06.11.2019.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import RxSwift

class RefreshDataUseCase {
    let userService: UserService

    init(userService: UserService) {
        self.userService = userService
    }

    func execute() -> Observable<[UserData]> {
        userService.refreshUserData()
    }
}
