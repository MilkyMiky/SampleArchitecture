//
//  FetchDataUseCase.swift
//  SampleArchitecture
//
//  Created by user on 06.11.2019.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import RxSwift

class GetUserDataUseCase {
    private let userService: UserService

    init(userService: UserService) {
        self.userService = userService
    }

    func execute(dataId: Int) -> Observable<UserData> {
        userService.getUserData(dataId: dataId)
    }
}
