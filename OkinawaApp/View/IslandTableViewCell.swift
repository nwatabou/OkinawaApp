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

    private var disposeBag = DisposeBag()
    private var isChecked: Bool = false {
        didSet {
            if isChecked {
                checkButton.setImage(checkedImage, for: .normal)
            } else {
                checkButton.setImage(uncheckedImage, for: .normal)
            }
        }
    }
    private let checkedImage = UIImage(named: "check_box")
    private let uncheckedImage = UIImage(named: "check_box_outline")

    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        isChecked = false
        titileLabel.text = nil
    }

    func setData(_ island: Island) {
        titileLabel.text = island.name
    }

    func tapped() {
        isChecked = !isChecked
    }

    private func commonInit() {
        checkButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.tapped()
            }).disposed(by: disposeBag)
    }
}
