//
// Created by Mikhail Lysyansky on 25.11.2019.
// Copyright (c) 2019 Mikhail Lysyansky . All rights reserved.
//

import Foundation
import SwiftKeychainWrapper
import RxSwift

class KeyChainService: UserCredentialsService {

    class KeychainSavingError: Error {
    }

    class KeychainReadError: Error {
    }

    class KeychainRemovingError: Error {
    }

    func saveUserCredentials(userCredentials: UserCredentials) -> Completable {
        Completable.create { completable in
            let loginSaved = KeychainWrapper.standard.set(userCredentials.login, forKey: UserCredentials.keyLogin)
            let passwordSaved = KeychainWrapper.standard.set(userCredentials.password, forKey: UserCredentials.keyPassword)

            if loginSaved && passwordSaved {
                completable(.completed)
            } else {
                completable(.error(KeychainSavingError()))
            }
            return Disposables.create {
            }
        }
    }

    func getUserCredentials() -> Single<UserCredentials> {
        Single<UserCredentials>.create { single in
            if let password = KeychainWrapper.standard.string(forKey: UserCredentials.keyPassword),
               let login = KeychainWrapper.standard.string(forKey: UserCredentials.keyLogin) {
                single(.success(UserCredentials(login: login, password: password)))
            } else {
                single(.error(KeychainReadError()))
            }
            return Disposables.create {
            }
        }
    }

    func removeUserCredentials() -> Completable {
        Completable.create {
            completable in
            let loginRemoved = KeychainWrapper.standard.removeObject(forKey: UserCredentials.keyLogin)
            let passwordRemoved = KeychainWrapper.standard.removeObject(forKey: UserCredentials.keyPassword)

            if loginRemoved && passwordRemoved {
                completable(.completed)
            } else {
                completable(.error(KeychainRemovingError()))
            }
            return Disposables.create {
            }
        }
    }
}
