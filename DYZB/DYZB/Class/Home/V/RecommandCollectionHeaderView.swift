//
//  RecommandCollectionHeaderView.swift
//  DYZB
//
//  Created by dulf on 2020/3/8.
//  Copyright © 2020 dulifu. All rights reserved.
//

import UIKit
import SnapKit

class RecommandCollectionHeaderView: UICollectionReusableView {
    
    ///图片
    private var imgView: UIImageView!
    ///标题
    private var label: UILabel!
    ///按钮
    private var moreButton: UIButton!
    
    //MARK: -系统方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: -设置UI
extension RecommandCollectionHeaderView {
    //MARK: -
    private func setupUI() {
        //1.添加图片
        imgView = UIImageView()
        addSubview(imgView)
        
        imgView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalTo(self)
            make.width.height.equalTo(20)
        }
        
        //2.添加label
        label = UILabel()
        label.text = "趣玩"
        label.font = UIFont.systemFont(ofSize: 14);
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.left.equalTo(imgView.snp_rightMargin).offset(10)
            make.centerY.equalTo(imgView)
        }
        
        //3.更多按钮
        moreButton = UIButton(type: .custom)
        moreButton .setTitle("更多", for: .normal)
        addSubview(moreButton)
        
        moreButton.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.centerY.equalTo(imgView)
            make.height.equalTo(30)
            make.width.equalTo(70)
        }
        
    }
}
