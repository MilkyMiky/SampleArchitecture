//
//  ImageListViewController.swift
//  SampleArchitecture
//
//  Created by user on 19.11.2019.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit
import RxSwift

class ImageListViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    var viewModel: ImageListViewModel?
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setCellSize()
        if let viewModel = viewModel {
            bindTo(to: viewModel)
        }
    }

    private func setCellSize() {
        let width = (view.frame.size.width - 10) / 2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }

   private func bindTo(to viewModel: ImageListViewModel) {
       viewModel.getImageURLs()
               .bind(to: collectionView.rx.items(cellIdentifier: ImageListTableViewCell.Identifier,
                       cellType: ImageListTableViewCell.self)) { (_, url, cell) in
                   self.viewModel?.loadImage(url: URL(string: url)!, view: cell.cellImage)
               }
               .disposed(by: disposeBag)
   }

}