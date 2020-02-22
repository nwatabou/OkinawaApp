//
//  IslandsListViewController.swift
//  OkinawaApp
//
//  Created by nancy on 2020/02/22.
//  Copyright © 2020 nwatabou. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class IslandsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var islands = [Island]()
    private let disposeBag = DisposeBag()
    private let viewModel = IslandsListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }

    private func commonInit() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: IslandTableViewCell.self)
        viewModel.fetchIslands()
            .asDriver(onErrorRecover: { error in
                return Driver.empty()
            }).drive(onNext: { [weak self] data in
                self?.islands = data
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
}

extension IslandsListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return islands.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: IslandTableViewCell.self, for: indexPath)
        cell.setData(islands[indexPath.row])
        return cell
    }
}

extension IslandsListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return IslandTableViewCell.cellHeight
    }
}
