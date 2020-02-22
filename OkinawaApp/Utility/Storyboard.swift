//
//  Storyboard.swift
//  OkinawaApp
//
//  Created by nancy on 2020/02/22.
//  Copyright © 2020 nwatabou. All rights reserved.
//

import UIKit

extension UIViewController {

    /**
     StoryBoardからインスタンスを作成

     前提条件
     - StoryBoardの名前がViewControllerと同一になっている
     - StoryBoard内のViewControllerがinitial ViewControllerになっている

     呼び出し方
     let vc = ExampleViewController.instanceFromStoryBoard(ExampleViewController.self)
     */

    /// Storyboadのファイル名(クラス名)
    static var storyboardName: String {
        return String(describing: self)
    }

    class func instanceFromStoryBoard() -> UIViewController {
        let storyboard = UIStoryboard(name: self.storyboardName,
                                      bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() else {
            // インスタンスが取れない時は設定ミスのためクラッシュさせる
            fatalError("Couldn't instantiate \(storyboardName)")
        }
        return vc
    }
}
