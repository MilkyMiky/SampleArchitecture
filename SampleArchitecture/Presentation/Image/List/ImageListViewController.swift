//
//  ImageListViewController.swift
//  SampleArchitecture
//
//  Created by user on 19.11.2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class ImageListViewController: UIViewController {
    @IBOutlet private weak var image : UIImageView!
    var viewModel: ImageListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewModel = viewModel {
            viewModel.loadImage(view: image)
        }
    }

}
