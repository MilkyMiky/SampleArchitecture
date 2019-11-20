//
// Created by user on 20.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation
import RxSwift

class RemoteImageRepository: ImageRepository {
    func getImageList() -> Observable<[String]> {
        // Mock data
        Observable.just([String](repeating: "https://picsum.photos/id/237/200/300", count: 10))
    }
}
