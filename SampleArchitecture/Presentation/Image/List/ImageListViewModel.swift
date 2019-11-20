//
// Created by user on 19.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol ImageListViewModelInput {
    func loadImage(url: URL, view: UIImageView)
    func fetchImages()
}

protocol ImageListViewModelOutput {
    var imageList: PublishSubject<[String]> { get }
}

class ImageListViewModel: ImageListViewModelInput, ImageListViewModelOutput {
    var imageList = PublishSubject<[String]>()
    private let loadImageUseCase: LoadImageUseCase
    private let fetchImagesUseCase: FetchImagesUseCase
    private let router: Router

    init(loadImageUseCase: LoadImageUseCase, fetchImagesUseCase: FetchImagesUseCase, router: Router) {
        self.loadImageUseCase = loadImageUseCase
        self.fetchImagesUseCase = fetchImagesUseCase
        self.router = router
    }

    func fetchImages() {
        fetchImagesUseCase.execute()
                .map {
                    self.imageList.onNext($0)
                }
                .subscribe()
    }

    func loadImage(url: URL, view: UIImageView) {
        loadImageUseCase.execute(url: url, into: view)
                .subscribe()
    }
}
