//
//  HomeViewController.swift
//  DYZB
//
//  Created by apple on 2020/2/29.
//  Copyright © 2020 dulifu. All rights reserved.
//

import UIKit

let kTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {
    
    //MARK: -懒加载pageTitleView
    lazy var pageTitleView: PageTitleView = { [weak self] in
        let frame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView.init(frame: frame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    //MARK: -懒加载pageContentView
    lazy var pageContentView: PageContentView = { [weak self] in
        let originY = kStatusBarH + kNavigationBarH + kTitleViewH
        
        let frame = CGRect(x: 0, y: originY, width: kScreenW, height: kScreenH - originY - kTabBarH)
        var childVCs = [UIViewController]()
        let recomendContoller = RecommandViewController()
        childVCs .append(recomendContoller)
        for i in 0...2 {
            let controller = UIViewController()
            if i == 0 {
                controller.view.backgroundColor = .red
            } else if i == 1 {
                controller.view.backgroundColor = .green
            } else {
                controller.view.backgroundColor = .blue
            }
            childVCs.append(controller)
        }
        
        let contentView = PageContentView(frame: frame, childViewControllers: childVCs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()
    
    //MARK: -系统方法
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
        automaticallyAdjustsScrollViewInsets = false
        //设置导航栏
        setupNavigationBar()
        
        //添加titleView
        view.addSubview(pageTitleView)
        
        //添加contentView
        view.addSubview(pageContentView)
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

//MARK: -遵守PageTitleViewDelegate
extension HomeViewController: PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

//MARK: -遵守PageContentViewDelegate
extension HomeViewController: PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleView(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
