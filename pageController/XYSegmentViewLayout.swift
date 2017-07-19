//
//  XYSegmentViewLayout.swift
//  pageController
//
//  Created by xiangyu on 2017/7/14.
//  Copyright © 2017年 xiangyu. All rights reserved.
//

import UIKit

class XYSegmentViewLayout: UICollectionViewFlowLayout {
  private var numberOfItems : Int = 0
  private var layoutAttributesArray: [UICollectionViewLayoutAttributes] = []
  private let spacing: CGFloat = 0
  override func prepare() {
    super.prepare()
    var array : [UICollectionViewLayoutAttributes] = []
    self.numberOfItems = self.collectionView!.numberOfItems(inSection: 0)
    let itemCount = collectionView?.numberOfItems(inSection: 0)
    for i in 0 ..< itemCount! {
      let indexPath = IndexPath(item: i, section: 0)
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      let cellWidth = ((collectionView?.bounds.size.width)! - CGFloat(numberOfItems - 1) * spacing) / CGFloat(numberOfItems)
      let cellHeight = collectionView?.bounds.size.height
      
      let center_x = (cellWidth + spacing) * CGFloat(i) + cellWidth / 2
      let center_y = self.collectionView!.bounds.height / 2.0
      
      attributes.center = CGPoint(x:  center_x, y: center_y)
      attributes.bounds.size = CGSize(width: cellWidth, height: cellHeight ?? 0)
      array.append(attributes)
    }
    self.layoutAttributesArray = array
  }
  
  override var collectionViewContentSize : CGSize {
    
    return CGSize(width: self.collectionView!.bounds.width  , height: self.collectionView!.bounds.height)
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return self.layoutAttributesArray[indexPath.row]
  }
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return self.layoutAttributesArray
  }
}
