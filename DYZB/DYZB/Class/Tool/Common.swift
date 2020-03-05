//
//  Common.swift
//  DYZB
//
//  Created by apple on 2020/3/4.
//  Copyright © 2020 dulifu. All rights reserved.
//

import UIKit


///导航栏高度(一定要添加CGFloat类型，否则44.0赋值默认是double类型）
let kNavigationBarH: CGFloat = 44.0

///状态栏高度
let kStatusBarH = UIApplication.shared.statusBarFrame.height
///X以上底部空白
let kDeviceBottomH:CGFloat = UIApplication.shared.statusBarFrame.height > 20 ? 34 : 0
///TabBar高度
let kTabBarH:CGFloat = UIApplication.shared.statusBarFrame.height > 20 ? 49 + kDeviceBottomH : 49
///屏幕宽高
let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height



