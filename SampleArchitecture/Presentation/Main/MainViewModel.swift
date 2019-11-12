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
    func cellClicked(userData: UserData)
}

protocol MainViewModelOutput {
    var dataList: PublishSubject<[UserData]> { get }
}

class MainViewModel: MainViewModelInput, MainViewModelOutput {
    var dataList: PublishSubject<[UserData]> = PublishSubject<[UserData]>()
    let fetchDataUseCase: FetchDataUseCase
    let markDataUseCase: MarkDataUseCase

    init(fetchDataUseCase: FetchDataUseCase, markDataUseCase: MarkDataUseCase) {
        self.fetchDataUseCase = fetchDataUseCase
        self.markDataUseCase = markDataUseCase
    }

    func viewDidLoad() {
        fetchDataUseCase.execute()
                .subscribe(self.dataList)
    }

    func cellClicked(userData : UserData) {
        markDataUseCase.execute(dataId: userData.userDataId, completed: !userData.completed)
                .do(onNext: { data in print(data.completed) })
                .subscribe()
    }
}
