//
//  AlbumTableViewCell.swift
//  iosSkillTest
//
//  Created by Pedro Nascimento on 25/09/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

}
