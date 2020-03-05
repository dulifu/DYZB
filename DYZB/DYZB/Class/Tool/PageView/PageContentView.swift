//
//  PageContentView.swift
//  DYZB
//
//  Created by apple on 2020/3/5.
//  Copyright © 2020 dulifu. All rights reserved.
//

import UIKit

let pageContentCell = "pageContentCell"

class PageContentView: UIView {

    //子控制器数组
    private var childVCs: [UIViewController]
    private weak var parentVC: UIViewController?
    
    ///初始offset
    private var startOffset: CGFloat = 0
    
    //MARK: -懒加载collectionView
    private lazy var collectionView: UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: (self?.bounds)!, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        collection.bounces = false
        collection.backgroundColor = .white
        collection.dataSource = self
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: pageContentCell)
        
        return collection
        
    }()
    
    //MARK: -自定义构造函数
    init(frame: CGRect, childViewControllers: [UIViewController], parentViewController: UIViewController?) {
        childVCs = childViewControllers
        parentVC = parentViewController
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK: -设置UI界面
extension PageContentView {
    //MARK: -设置UI
    private func setupUI() {
        for childVC in childVCs {
            parentVC?.addChild(childVC)
        }
        //1.添加collectionView
        addSubview(collectionView)
        collectionView.frame = self.bounds
    }
}

//MARK: -遵循UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: pageContentCell, for: indexPath)
        let childVC = childVCs[indexPath.row]
        cell.contentView.addSubview(childVC.view)
        childVC.view.frame = cell.contentView.bounds
        return cell
    }
}

//MARK: -遵循
extension PageContentView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollWidth = scrollView.frame.width
        if currentOffsetX > startOffset {//左滑
            progress = currentOffsetX / scrollWidth - floor(currentOffsetX / scrollWidth)
            sourceIndex = Int(currentOffsetX / scrollWidth)
            targetIndex = (sourceIndex + 1 < childVCs.count) ? sourceIndex + 1 : childVCs.count - 1
        } else {//右滑
            progress = 1 - (currentOffsetX / scrollWidth - floor(currentOffsetX / scrollWidth))
        }
    }
}

//MARK: -对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex: Int)  {
        let offsetX = CGFloat(currentIndex) * frame.width
        collectionView .setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
