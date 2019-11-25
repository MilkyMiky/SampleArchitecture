//
// Created by Mikhail Lysyansky on 25.11.2019.
// Copyright (c) 2019 Mikhail Lysyansky . All rights reserved.
//

import Foundation
import RxSwift

protocol UserCredentialsService {
    func saveUserCredentials(userCredentials: UserCredentials) -> Completable
    func getUserCredentials() -> Single<UserCredentials>
    func removeUserCredentials() -> Completable
}
