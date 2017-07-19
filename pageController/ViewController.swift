//
//  ViewController.swift
//  pageController
//
//  Created by xiangyu on 2017/7/5.
//  Copyright © 2017年 xiangyu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var segmentView: XYSegmentView!
  override func viewDidLoad() {
    super.viewDidLoad()
      segmentView.dataSource = ["热门", "推荐", "直播", "绝味"]
//    segmentView.selectIndex = 0
  }
  @IBAction func next(_ sender: Any) {
    segmentView.selectIndex = Int(arc4random_uniform(4))
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

