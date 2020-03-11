//
//  NormalCollectionViewCell.swift
//  DYZB
//
//  Created by apple on 2020/3/10.
//  Copyright © 2020 dulifu. All rights reserved.
//

import UIKit

class NormalCollectionViewCell: UICollectionViewCell {
    ///顶部图片
    public var topImgView: UIImageView!
    ///主播名字
    public var authorLabel: UILabel!
    ///观看人数
    public var watchNumLabel: UILabel!
    
    ///左侧占位图
    public var leftImgView: UIImageView!
    ///标题
    public var titleLabel: UILabel!
    
    
    
    //MARK: -初始化方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NormalCollectionViewCell {
    
    //MARK: -设置UI
    private func setupUI() {
        //1.添加顶部图片
        topImgView = UIImageView()
        topImgView.layer.cornerRadius = 4
        topImgView.layer.masksToBounds = true
        contentView.addSubview(topImgView)
        
        topImgView.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.top.equalTo(5)
            make.bottom.equalTo(-25)
        }
        
        //2.添加authorLabel
        authorLabel = UILabel()
        authorLabel.text = "小马哥教育"
        authorLabel.font = UIFont.systemFont(ofSize: 11)
        topImgView.addSubview(authorLabel)
        
        authorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(5)
            make.bottom.equalTo(-5)
        }
        
        //3.添加观看人数label
        watchNumLabel = UILabel()
        watchNumLabel.text = "10万人"
        watchNumLabel.font = UIFont.systemFont(ofSize: 11)
        topImgView.addSubview(watchNumLabel)
        
        watchNumLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-5)
            make.bottom.equalTo(authorLabel.snp.bottom)
            make.left.greaterThanOrEqualTo(authorLabel.snp.right).offset(10)
        }
        
        //4.标题label
        titleLabel = UILabel()
        titleLabel.text = "小马哥教育"
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(topImgView)
            make.top.equalTo(topImgView.snp.bottom).offset(5)
        }
        
        
    }
}
