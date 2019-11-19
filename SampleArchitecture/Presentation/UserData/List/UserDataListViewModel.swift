//
//  MainViewModel.swift
//  SampleArchitecture
//
//  Created by user on 06.11.2019.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import RxSwift

protocol UserDataListViewModelInput {
    func viewDidLoad()
    func cellClicked(viewController: UIViewController, dataId: Int)
    func cellRemoved(row: Int)
    func refresh()
}

protocol UserDataListViewModelOutput {
    var dataList: PublishSubject<[UserData]> { get }
    var isRefreshing: PublishSubject<Bool> { get }
}

class UserDataListViewModel: UserDataListViewModelInput, UserDataListViewModelOutput {
    var dataList: PublishSubject<[UserData]> = PublishSubject<[UserData]>()
    var isRefreshing: PublishSubject<Bool> = PublishSubject<Bool>()
    private let router: Router
    private let fetchDataUseCase: FetchDataUseCase
    private let markDataUseCase: MarkDataUseCase
    private let refreshDataUseCase: RefreshDataUseCase
    private let removeDataUseCase: RemoveDataUseCase
    private var userDataList: [UserData] = [UserData]()

    init(fetchDataUseCase: FetchDataUseCase, markDataUseCase: MarkDataUseCase, refreshDataUseCase: RefreshDataUseCase,
         removeDataUseCase: RemoveDataUseCase, router: Router) {
        self.fetchDataUseCase = fetchDataUseCase
        self.markDataUseCase = markDataUseCase
        self.refreshDataUseCase = refreshDataUseCase
        self.removeDataUseCase = removeDataUseCase
        self.router = router
    }

    func viewDidLoad() {
        fetchDataUseCase.execute()
                .map {
                    self.userDataList = $0
                    self.dataList.onNext($0)
                }
                .subscribe()
    }

    func cellClicked(viewController: UIViewController, dataId: Int) {
        router.openUserDataDetailsViewController(viewController: viewController, dataId: dataId)
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
