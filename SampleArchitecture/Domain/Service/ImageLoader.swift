//
// Created by user on 19.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation
import RxSwift

protocol ImageLoader {
    func loadImage(url: URL, into: UIImageView) -> Completable
}
