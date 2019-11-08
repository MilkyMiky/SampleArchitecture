//
//  MainViewModel.swift
//  SampleArchitecture
//
//  Created by user on 06.11.2019.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import RxSwift

protocol MainViewModelInput {
    func viewDidLoad()
}

protocol MainViewModelOutput {
    var title: PublishSubject<String> { get }
}

class MainViewModel: MainViewModelInput, MainViewModelOutput {
    var title: PublishSubject<String> = PublishSubject<String>()
    let fetchDataUseCase: FetchDataUseCase

    init(fetchDataUseCase: FetchDataUseCase) {
        self.fetchDataUseCase = fetchDataUseCase
    }

    func viewDidLoad() {
        fetchDataUseCase.execute()
                .map { _ in "completed"}
                .subscribe(self.title)
    }
}
