//
//  PageTitleView.swift
//  DYZB
//
//  Created by dulf on 2020/3/3.
//  Copyright © 2020 dulifu. All rights reserved.
//

import UIKit

class PageTitleView: UIView {
    //title
    private let titles: [String]
    
    
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
