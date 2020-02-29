//
//  HomeViewController.swift
//  DYZB
//
//  Created by apple on 2020/2/29.
//  Copyright © 2020 dulifu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {

        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpUI()
    }

}

//MARK: -aa
extension HomeViewController {
    //设置UI
    private func setUpUI() {
        setupNavigationBar()
    }
    
    //设置导航栏
    private func setupNavigationBar() {
        //左侧按钮
        let button = UIButton()
        button.setImage(UIImage(named: "logo"), for: .normal)
        button.sizeToFit()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        let size = CGSize(width: 40, height: 40)
        
        /*通过类扩展方法
        let historyItem = UIBarButtonItem.create(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let qrcodeItem = UIBarButtonItem.create(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        let searchItem = UIBarButtonItem.create(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        self.navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        */
        
        //右侧三个Items
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        self.navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
        
    }
    
    
}
