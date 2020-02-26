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


    @IBOutlet weak var checkBoxImageView: UIImageView!
    @IBOutlet weak var titileLabel: UILabel!

    private let checkedImage = UIImage(named: "check_box")
    private let uncheckedImage = UIImage(named: "check_box_outline")
    private var disposeBag = DisposeBag()
    private var isChecked: Bool = false {
        didSet {
            if isChecked {
                checkBoxImageView.image = checkedImage
            } else {
                checkBoxImageView.image = uncheckedImage
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        isChecked = false
        titileLabel.text = nil
    }

    func setData(_ island: Island) {
        isChecked = island.isVisited
        titileLabel.text = island.name
    }

    func tapped() {
        isChecked = !isChecked
    }
}
