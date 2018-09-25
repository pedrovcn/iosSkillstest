//
//  NibLoadableView.swift
//  iosSkillTest
//
//  Created by Pedro Nascimento on 25/09/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import Foundation
import UIKit

protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
