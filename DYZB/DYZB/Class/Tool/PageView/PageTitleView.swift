//
//  PageTitleView.swift
//  DYZB
//
//  Created by dulf on 2020/3/3.
//  Copyright © 2020 dulifu. All rights reserved.
//

import UIKit

private let kScrollLineH: CGFloat = 2
private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectedColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

//MARK: -添加协议（class代表协议只能被类遵守）
protocol PageTitleViewDelegate: class {
    func pageTitleView(titleView: PageTitleView, index: Int)
}

class PageTitleView: UIView {
    //title
    private let titles: [String]
    
    //label数组
    lazy private var titleLabels: [UILabel] = [UILabel]()
    
    ///当前下标
    private var currentIndex = 0
    
    weak var delegate: PageTitleViewDelegate?
       
    //懒加载scrollView
    lazy private var scrollView: UIScrollView = { [weak self] in
        let scroll = UIScrollView()
        scroll.frame = (self?.bounds)!
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.scrollsToTop = false
        return scroll
    }()
    
    lazy private var scrollLine: UIView = {
        let line = UIView()
        line.backgroundColor = .orange
        return line
    }()
    
    
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: -设置UI
extension PageTitleView {
    private func setUpUI() {
        //添加scrollview
        addSubview(scrollView)
        
        //添加labels
        addLabels()
        
        //添加顶部线条和滚动条
        addBottomLineAndScrollLine()
    }
    
    //MARK: -添加labels
    private func addLabels() {
        let labelW = frame.width / CGFloat(titles.count)
        let labelH = frame.height - kScrollLineH
        let labelY: CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = NSTextAlignment.center
            label.text = title
            label.tag = index
            
            let labelX = labelW * CGFloat(index)

            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelClick(tapGes:)))
            label.addGestureRecognizer(tapGesture)
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    
    //MARK: -添加顶部线条和滚动条
    private func addBottomLineAndScrollLine() {
        //1.添加底部线条
        let line = UIView()
        line.backgroundColor = .lightGray
        let lineH: CGFloat = 0.5
        line.frame = CGRect(x: 0, y: frame.height - 0.5, width: frame.width, height: lineH)
        addSubview(line)
        
        //2.添加滚动条
        scrollView.addSubview(scrollLine)
        
        guard let label = titleLabels.first else {
            return
        }
        label.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        scrollLine.frame = CGRect(x: label.frame.origin.x, y: frame.height - kScrollLineH, width: label.frame.width, height: kScrollLineH)
        
    }
}

//MARK: -label点击事件
extension PageTitleView {
    @objc func labelClick(tapGes: UIGestureRecognizer) {
        //设置新的label
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        currentLabel.textColor = UIColor(r: kSelectedColor.0, g: kSelectedColor.1, b: kSelectedColor.2)
        
        //重置旧的label
        let oldLabel = titleLabels[currentIndex]
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //设置currentIndex
        currentIndex = currentLabel.tag
        
        //设置滚动条
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //调用代理来让下方contentView滚动
        delegate?.pageTitleView(titleView: self, index: currentIndex)
    }
}

//MARK: -暴露的外部方法
extension PageTitleView {
    func setTitleView(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        //找到最初和最终的label
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //滚动条移动距离
        let moveX = (targetLabel.frame.origin.x - sourceLabel.frame.origin.x) * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //颜色变化
        let colorDelta = (kSelectedColor.0 - kNormalColor.0, kSelectedColor.1 - kNormalColor.1, kSelectedColor.2 - kNormalColor.2)

        sourceLabel.textColor = UIColor(r: kSelectedColor.0 - colorDelta.0 * progress, g: kSelectedColor.1 - colorDelta.1 * progress, b: kSelectedColor.2 - colorDelta.2 * progress)

        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        currentIndex = targetIndex
    }
}


