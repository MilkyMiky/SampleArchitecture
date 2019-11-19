//
// Created by user on 19.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

class FetchImageUseCase {
    let imageService: ImageLoader

    init(imageService: ImageLoader) {
        self.imageService = imageService
    }

    func execute(url: URL, into: UIImageView) -> Completable {
        imageService.loadImage(url: url, into: into)
    }
}
