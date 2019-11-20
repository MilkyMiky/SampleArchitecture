//
// Created by user on 19.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation
import Nuke
import RxSwift

class NukeImageLoader: ImageLoader {

    func loadImage(url: URL, into: UIImageView) -> Completable {
        Completable.create { completable in
            Nuke.loadImage(with: url, into: into)
            completable(.completed)
            return Disposables.create {
            }
        }
    }
}
