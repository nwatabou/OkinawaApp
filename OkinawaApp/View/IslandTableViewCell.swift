//
//  IslandTableViewCell.swift
//  OkinawaApp
//
//  Created by nancy on 2020/02/22.
//  Copyright © 2020 nwatabou. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class IslandTableViewCell: UITableViewCell {

    static let reuseIdentifier = "islandCell"
    static let cellHeight: CGFloat = 60.0

    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var titileLabel: UILabel!

    private let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData(_ island: Island) {
        titileLabel.text = island.name
    }
}
