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
    func cellRemoved(row: Int)
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
    private let removeDataUseCase: RemoveDataUseCase
    private var userDataList: [UserData] = [UserData]()

    init(fetchDataUseCase: FetchDataUseCase, markDataUseCase: MarkDataUseCase, refreshDataUseCase: RefreshDataUseCase,
         removeDataUseCase: RemoveDataUseCase) {
        self.fetchDataUseCase = fetchDataUseCase
        self.markDataUseCase = markDataUseCase
        self.refreshDataUseCase = refreshDataUseCase
        self.removeDataUseCase = removeDataUseCase
    }

    func viewDidLoad() {
        fetchDataUseCase.execute()
                .map {
                    self.userDataList = $0
                    self.dataList.onNext($0)
                }
                .subscribe()
    }

    func cellClicked(userData: UserData) {
        markDataUseCase.execute(dataId: userData.userDataId, completed: !userData.completed)
                .subscribe()
    }

    func refresh() {
        refreshDataUseCase.execute()
                .map { _ in
                    self.isRefreshing.onNext(false)
                }
                .subscribe()
    }

    func cellRemoved(row: Int) {
        let removedData = userDataList[row]
        removeDataUseCase
                .execute(dataId: removedData.userDataId)
                .subscribe()
    }
}
