//
//  EstatePopView.swift
//  BDS
//
//  Created by Trương Thắng on 3/2/16.
//  Copyright © 2016 Trương Thắng. All rights reserved.
//

import UIKit

@objc protocol EstatePopViewDelegate : class {
    func didSelect()
}

class EstatePopView: UIView {
    private let kHomeImageSize             : CGSize         = CGSize(width: 80, height: 80)
    
    private let homeImageView              : UIImageView!   = UIImageView(image: UIImage(named: "home"))
    private let label                      : UILabel        = {
        let label = UILabel()
        label.text = "60m2 - mt: 3,5m - 3 tầng \n đường 6m - Hướng Đông Tứ Trạch \n 3 ngủ - 2 tắm - 1 khách \nGiá: 800tr"
        label.numberOfLines = 0
        return label
    }()
    
    weak var delegate: EstatePopViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addConstraintForComponent()
        configGesture()
        
    }
    
    private func configGesture() {
        self.userInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: "onClickSelf")
        self.addGestureRecognizer(gesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraintForComponent() {
        let imageContainer = UIView()
        layoutHomeImageView(imageContainer)
        self.mt_splitVerticallyBySizes([imageContainer,label], sizes: [100, nil], edge: UIEdgeInsetsZero, gap: 4)
    }
    
    private func layoutHomeImageView(imageContainer: UIView) {
        imageContainer.addSubviews(homeImageView)
        homeImageView.mt_center(kHomeImageSize)
        
    }

    func onClickSelf() {
        delegate?.didSelect()
    }
    
    
    
    
}