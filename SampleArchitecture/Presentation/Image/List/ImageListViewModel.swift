//
// Created by user on 19.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import Foundation
import UIKit

protocol ImageListViewModelInput {
    func loadImage(view: UIImageView)
}

class ImageListViewModel : ImageListViewModelInput {
    private let fetchImageUseCase: FetchImageUseCase
    private let router: Router

    init(fetchImageUseCase: FetchImageUseCase, router: Router) {
        self.fetchImageUseCase = fetchImageUseCase
        self.router = router
    }

    func loadImage(view: UIImageView) {
        fetchImageUseCase.execute(url: URL(string: "https://picsum.photos/id/237/200/300")!,
                into: view)
        .subscribe()
    }
}
