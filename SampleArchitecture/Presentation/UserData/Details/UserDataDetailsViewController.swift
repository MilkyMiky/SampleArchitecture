//
// Created by user on 13.11.2019.
// Copyright (c) 2019 user. All rights reserved.
//

import UIKit
import RxSwift

class UserDataDetailsViewController: UIViewController {
    @IBOutlet weak var label : UILabel!

    private let disposeBag = DisposeBag()
    static let identifier = "UserDataDetailsViewController"
    var viewModel: UserDataDetailsViewModel?
    var userDataId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewModel = viewModel {
            bindTo(to: viewModel)
            if let userDataId = userDataId {
                viewModel.getUserData(dataId: userDataId)
            }
        }
    }

    private func bindTo(to viewModel: UserDataDetailsViewModel) {
        viewModel.userDataSubject
                .do(onNext: { [unowned self] userData in self.label.text = userData.userTitle})
                .subscribe()
                .disposed(by: disposeBag)
        
    }
}
