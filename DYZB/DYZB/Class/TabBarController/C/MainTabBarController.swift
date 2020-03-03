//
//  MainTabBarController.swift
//  DYZB
//
//  Created by apple on 2020/2/29.
//  Copyright © 2020 dulifu. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: -注意点
        //因为tabbar有默认的渲染色，所以要先去掉，否则颜色并不是我们想要的颜色
        UITabBar.appearance().isTranslucent = false
        //之后再设置tabbar的背景色
        UITabBar.appearance().barTintColor = .white
        
        // Do any additional setup after loading the view.
        addChildVC(childVC: HomeViewController(), title: "首页", imageName: "btn_home")
        addChildVC(childVC: LiveViewController(), title: "直播", imageName: "btn_live")
        addChildVC(childVC: FollowViewController(), title: "关注", imageName: "btn_column")
        addChildVC(childVC: ProFileViewController(), title: "我的", imageName: "btn_user")
        
        //统一设置方法
        //整体颜色
//        UITabBar.appearance().tintColor = .blue
        
        //设置选中颜色与 未选中颜色
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.blue], for: .selected)
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.orange], for: .normal)
    }
    

    private func addChildVC(childVC: UIViewController, title: String, imageName: String) {
        childVC.tabBarItem.title = title
        
        //每个控制器可单独设置，注意必须先设置好上方mark注意点，否则normal状态不生效
        childVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.gray], for: UIControl.State.normal)
        childVC.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.orange], for: UIControl.State.selected)
        
        
        var image = UIImage(named: imageName)
        //设置mode 始终使用图片本身颜色防止颜色随着切换变化
        image = image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        var selectImage = UIImage(named: imageName + "_selected")
        selectImage = selectImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        
        childVC.tabBarItem.image = image
        childVC.tabBarItem.selectedImage = selectImage
        
        
        let navigationController = UINavigationController.init(rootViewController: childVC)
        addChild(navigationController)
        
    }

}
