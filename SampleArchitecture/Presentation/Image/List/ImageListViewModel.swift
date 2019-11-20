//
// Created by user on 19.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol ImageListViewModelInput {
    func loadImage(url: URL, view: UIImageView)
}

protocol ImageListViewModelOutput {
    func getImageURLs() -> Observable<[String]>
}

class ImageListViewModel : ImageListViewModelInput, ImageListViewModelOutput {
    private let fetchImageUseCase: FetchImageUseCase
    private let router: Router

    init(fetchImageUseCase: FetchImageUseCase, router: Router) {
        self.fetchImageUseCase = fetchImageUseCase
        self.router = router
    }

    func loadImage(url: URL, view: UIImageView) {
        fetchImageUseCase.execute(url: url, into: view)
        .subscribe()
    }

    func getImageURLs() -> Observable<[String]> {
        var urls = [String]()
        for i in 1...10 {
            urls.append("https://picsum.photos/id/237/200/300")
        }
        return Observable.just(urls)
    }
}
