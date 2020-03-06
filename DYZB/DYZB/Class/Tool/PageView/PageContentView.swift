//
//  PageContentView.swift
//  DYZB
//
//  Created by apple on 2020/3/5.
//  Copyright © 2020 dulifu. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate: class {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

let pageContentCell = "pageContentCell"

class PageContentView: UIView {

    //子控制器数组
    private var childVCs: [UIViewController]
    private weak var parentVC: UIViewController?
    
    weak var delegate: PageContentViewDelegate?
    
  //禁用scroll代理（因为在pageTitleView点击时会调用setCurrentIndex方法，设置collecitonview滚动，这个时候又会走一遍代理方法，最终再去改变pageTitleView，形成了一个环）
    private var isForbidDelegate = false
    
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
        collection.delegate = self
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
extension PageContentView: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //真正的拖动时，允许代理方法
        isForbidDelegate = false
        startOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //如果代理禁止，直接返回
        if isForbidDelegate {
            return
        }
        
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollWidth = scrollView.frame.width
        if currentOffsetX > startOffset {//左滑
            progress = currentOffsetX / scrollWidth - floor(currentOffsetX / scrollWidth)
            sourceIndex = Int(currentOffsetX / scrollWidth)
            targetIndex = (sourceIndex + 1 < childVCs.count) ? sourceIndex + 1 : childVCs.count - 1
            
            //注意点
            if currentOffsetX - startOffset == scrollWidth {
                progress = 1
                targetIndex = sourceIndex
            }
        } else {//右滑
            progress = 1 - (currentOffsetX / scrollWidth - floor(currentOffsetX / scrollWidth))
            targetIndex = Int(currentOffsetX / scrollWidth)
            sourceIndex = (targetIndex + 1 < childVCs.count) ? targetIndex + 1 : childVCs.count - 1
        }
        
        //调用代理让pageTitleView变化
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

//MARK: -对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex: Int)  {
        //pagetitleView点击时 禁用代理
        isForbidDelegate = true
        
        //设置正确的滚动位置
        let offsetX = CGFloat(currentIndex) * frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
