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
    func refresh()
}

protocol MainViewModelOutput {
    var dataList: PublishSubject<[UserData]> { get }
    var isRefreshing: PublishSubject<Bool> { get }
}

class MainViewModel: MainViewModelInput, MainViewModelOutput {
    var dataList: PublishSubject<[UserData]> = PublishSubject<[UserData]>()
    var isRefreshing: PublishSubject<Bool> = PublishSubject<Bool>()

    private let fetchDataUseCase: FetchDataUseCase
    private let markDataUseCase: MarkDataUseCase
    private let refreshDataUseCase: RefreshDataUseCase

    init(fetchDataUseCase: FetchDataUseCase, markDataUseCase: MarkDataUseCase, refreshDataUseCase : RefreshDataUseCase) {
        self.fetchDataUseCase = fetchDataUseCase
        self.markDataUseCase = markDataUseCase
        self.refreshDataUseCase = refreshDataUseCase
    }

    func viewDidLoad() {
        fetchDataUseCase.execute()
                .map {self.dataList.onNext($0)}
                .subscribe()
    }

    func cellClicked(userData : UserData) {
        markDataUseCase.execute(dataId: userData.userDataId, completed: !userData.completed)
                .subscribe()
    }

    func refresh() {
        refreshDataUseCase.execute()
                .map {_ in self.isRefreshing.onNext(false)}
                .subscribe()
    }
}
