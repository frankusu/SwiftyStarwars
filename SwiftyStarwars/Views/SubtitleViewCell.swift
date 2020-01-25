//
//  SubtitleViewCell.swift
//  SwiftyStarwars
//
//  Created by Frank Su on 2020-01-24.
//  Copyright © 2020 frankusu. All rights reserved.
//

import UIKit

class SubtitleViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
