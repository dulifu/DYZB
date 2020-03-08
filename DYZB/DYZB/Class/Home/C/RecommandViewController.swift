//
//  RecommandViewController.swift
//  DYZB
//
//  Created by dulf on 2020/3/8.
//  Copyright © 2020 dulifu. All rights reserved.
//

import UIKit

private let cellMargin:CGFloat = 10
private let itemWidth:CGFloat = (kScreenW - 3 * cellMargin)/2
private let itemHeight = itemWidth * 3/4

private let sectionHeaderH:CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kSectionHeaderID = "kSectionHeaderID"

class RecommandViewController: UIViewController {
    
    //MARK: -懒加载collectionView
    private lazy var collectionView: UICollectionView = { [weak self] in
        //1.初始化布局layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.sectionInset = UIEdgeInsets(top: 0, left: cellMargin, bottom: 0, right: cellMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: sectionHeaderH)
        
        //2.创建collectionview
        let collectionView = UICollectionView(frame: (self?.view)!.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .purple
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(RecommandCollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kSectionHeaderID)
        
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return collectionView
    }()

    //MARK: -系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

}

//MARK: -设置UI
extension RecommandViewController {
    private func setupUI() {
        view.addSubview(collectionView)
    }
}

//MARK: -遵循UICollectionViewDataSource
extension RecommandViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:kNormalCellID, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kSectionHeaderID, for: indexPath)
        
        header.backgroundColor = .white
            return header
    }
    
}
