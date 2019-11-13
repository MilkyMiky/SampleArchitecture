//
//  ViewController.swift
//  SampleArchitecture
//
//  Created by user on 06.11.2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!

    var viewModel: MainViewModel?
    private var userList = [UserData]()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewModel = viewModel {
            bindTo(to: viewModel)
            setupCellTapHandling()
            setRefreshControl()
            setRemoveItem()
            viewModel.viewDidLoad()
        }
    }

    private func setRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }

    @objc func handleRefreshControl() {
        viewModel?.refresh()
    }

    private func showRefresh(show: Bool) {
        if show {
            tableView.refreshControl?.beginRefreshing()
        } else {
            tableView.refreshControl?.endRefreshing()
        }
    }

    private func bindTo(to viewModel: MainViewModel) {
        viewModel.dataList
                .bind(
                        to: tableView.rx.items(cellIdentifier: MainTableViewCell.Identifier, cellType: MainTableViewCell.self)
                ) {
                    row, userData, cell in
                    cell.setUserData(userData: userData)
                }
                .disposed(by: disposeBag)

        disposeBag.insert(
                viewModel.isRefreshing
                        .map {
                            self.showRefresh(show: $0)
                        }
                        .subscribe()
        )
    }

    private func setupCellTapHandling() {
        tableView.rx
                .modelSelected(UserData.self)
                .subscribe(onNext: { userData in
                    self.viewModel?.cellClicked(viewController: self, dataId: userData.userDataId)
                })
                .disposed(by: disposeBag)
    }

    private func setRemoveItem() {
        tableView.rx
                .itemDeleted
                .subscribe(onNext: { indexPath in
                    self.viewModel?.cellRemoved(row: indexPath.row)
                })
                .disposed(by: disposeBag)
    }
}


