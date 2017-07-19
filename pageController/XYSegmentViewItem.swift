//
//  XYSegmentViewItem.swift
//  pageController
//
//  Created by xiangyu on 2017/7/5.
//  Copyright © 2017年 xiangyu. All rights reserved.
//

import UIKit

class XYSegmentViewItem: UICollectionViewCell {

  @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  func selected(_ selected: Bool) {
    self.titleLabel.textColor = selected ? #colorLiteral(red: 0.3254901961, green: 0.8039215686, blue: 0.7647058824, alpha: 1) : #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
  }
  
}
