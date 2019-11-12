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
            setupCellTapHandling(viewModel: viewModel)
            viewModel.viewDidLoad()
        }
    }

    func bindTo(to viewModel: MainViewModel) {
        viewModel.dataList
                .bind(
                        to: tableView.rx.items(cellIdentifier: MainTableViewCell.Identifier,
                                cellType: MainTableViewCell.self)
                ) {
                    row, userData, cell in
                    cell.setUserData(userData: userData)
                }
                .disposed(by: disposeBag)
    }

    func setupCellTapHandling(viewModel: MainViewModel) {
        tableView.rx
                .modelSelected(UserData.self)
                .subscribe(onNext: { [unowned self] userData in
                    viewModel.cellClicked(userData: userData)
                })
                .disposed(by: disposeBag)
    }
}


