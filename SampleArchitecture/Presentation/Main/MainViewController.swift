//
//  ViewController.swift
//  SampleArchitecture
//
//  Created by user on 06.11.2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var viewModel : MainViewModel?
    
    @IBOutlet private weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewModel = viewModel {
            bind(to: viewModel)
            viewModel.viewDidLoad()
        }
    }
    
    func bind(to viewModel: MainViewModel) {
        viewModel.title
            .subscribe(
                onNext: { self.label?.text = $0 },
                onError: { _ in print("error")}
        )
    }

}

