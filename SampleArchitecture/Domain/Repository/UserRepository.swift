//
//  UserRepository.swift
//  SampleArchitecture
//
//  Created by user on 07.11.2019.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import RxSwift

protocol UserRepository {
    func getUsers() -> Observable<[User]>

    func saveUsers(users: [User]) -> Completable
}
