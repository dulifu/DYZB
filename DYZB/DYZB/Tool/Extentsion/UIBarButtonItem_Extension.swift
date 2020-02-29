//
//  UIBarButtonItem_Extension.swift
//  DYZB
//
//  Created by apple on 2020/2/29.
//  Copyright © 2020 dulifu. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    //extentsion 只能添加便利构造函数
    convenience init(imageName: String, highImageName: String?, size: CGSize) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != nil {
            btn.setImage(UIImage(named: highImageName!), for: .selected)
        }
        
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        self.init(customView: btn)
    }
    
    
    
    //类扩展方法
    class func create(imageName: String, highImageName: String?, size: CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != nil {
            btn.setImage(UIImage(named: highImageName!), for: .selected)
        }
        
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn)
    }
}
