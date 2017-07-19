//
//  XYSegmentView.swift
//  pageController
//
//  Created by xiangyu on 2017/7/5.
//  Copyright © 2017年 xiangyu. All rights reserved.
//

import UIKit

protocol XYSegmentViewDelegate: NSObjectProtocol {
  func segmentView(_ segmentView: XYSegmentView, didSelectItemAt index: Int)
}

class XYSegmentView: UIView {
  public var selectIndexBlock: ((Int)->())?
  fileprivate var selectedCell: XYSegmentViewItem?
  fileprivate var collectionView: UICollectionView!
  
  var dataSource = [String]() {
    didSet {
      collectionView.reloadData()
      selectIndex = 0
    }
  }

  public var selectIndex = 0 {
    didSet {
      let indexPath = NSIndexPath(item: selectIndex, section: 0)
      selectedCell?.selected(false)
      collectionView.reloadItems(at: [indexPath as IndexPath])
      updateIndicatorPositionForIndex(selectIndex, animated: true)
    }
  }

  fileprivate var indicatorView: UIView = {
    let indicator = UIView()
    indicator.backgroundColor = #colorLiteral(red: 0.7529411765, green: 0.9411764706, blue: 0.9294117647, alpha: 1)
    indicator.layer.cornerRadius = 2
    return indicator
  }()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  override func awakeFromNib() {
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clear
    self.layer.masksToBounds = true
    setup()
  }
  
  private func setup() {
    let layout = XYSegmentViewLayout()
    layout.scrollDirection = .horizontal
    
    collectionView = UICollectionView(frame: self.bounds , collectionViewLayout: layout)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = self.backgroundColor
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.register(UINib(nibName:"XYSegmentViewItem",bundle:nil ), forCellWithReuseIdentifier: "segmentItem")
    addSubview(collectionView)
    addSubview(indicatorView)
  }
  
  private func updateIndicatorPositionForIndex(_ index: Int, animated: Bool) {
    let indexPath = NSIndexPath(item: index, section: 0)
    
    guard let cell = collectionView.cellForItem(at: indexPath as IndexPath) else { return }
    let segmentViewItem = cell as! XYSegmentViewItem
    let textFrame = segmentViewItem.titleLabel.convert(segmentViewItem.titleLabel.bounds, to: self)
    var frame = self.indicatorView.frame
      
      if(self.indicatorView.frame.size.height == 0 && self.indicatorView.frame.size.width == 0) {
        frame = CGRect(x: 0, y: self.bounds.height - 4, width: 0, height: 4)
      }
      
      frame.origin.x = textFrame.origin.x + textFrame.size.width * 0.15
      frame.size.width = textFrame.size.width * 0.7
      if(animated) {
        UIView.animate(withDuration: 0.3, animations: {
          self.indicatorView.frame = frame
        })
      } else {
        self.indicatorView.frame = frame
      }
    }
}

extension XYSegmentView: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataSource.count
  }
  
}
extension XYSegmentView: UICollectionViewDelegate {
  
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "segmentItem", for: indexPath) as! XYSegmentViewItem
    if selectIndex == indexPath.item {
      cell.selected(true)
      selectedCell = cell
    }
    cell.titleLabel.text = dataSource[indexPath.item]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectedCell?.selected(false)
    let cell = collectionView.cellForItem(at: indexPath) as! XYSegmentViewItem
    cell.selected(true)
    selectedCell = cell
    selectIndex = indexPath.item
    selectIndexBlock?(indexPath.item)
  }
}
