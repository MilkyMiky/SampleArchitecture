//
// Created by user on 20.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation
import RxSwift

class FetchImagesUseCase {

    private let imageRepository: ImageRepository

    init(imageRepository: ImageRepository) {
        self.imageRepository = imageRepository
    }

    func execute() -> Observable<[String]> {
        imageRepository.getImageList()
    }
}
