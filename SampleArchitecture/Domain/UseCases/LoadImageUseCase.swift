//
// Created by user on 19.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

class LoadImageUseCase {
    let imageLoader: ImageLoader

    init(imageLoader: ImageLoader) {
        self.imageLoader = imageLoader
    }

    func execute(url: URL, into: UIImageView) -> Completable {
        imageLoader.loadImage(url: url, into: into)
    }
}
