//
// Created by user on 08.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class RxMoyaProvider<APIServiceType: TargetType> : MoyaProvider<APIServiceType> {

    func request(_ token: Target) -> Observable<Response> {
        self.rx.request(token).asObservable()
    }

}