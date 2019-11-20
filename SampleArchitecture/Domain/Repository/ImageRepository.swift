//
// Created by user on 20.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation
import RxSwift

protocol ImageRepository {
    func getImageList() -> Observable<[String]>
}
