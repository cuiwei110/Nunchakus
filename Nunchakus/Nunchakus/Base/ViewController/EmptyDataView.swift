//
//  EmptyDataView.swift
//  operation4ios
//
//  Created by sungrow on 2017/2/28.
//  Copyright © 2017年 阳光电源股份有限公司. All rights reserved.
//

import UIKit

class EmptyDataView: UIView {

    var contentText: String = NSLocalizedString("暂无数据", comment: "") {
        didSet {
            contentTextLabel.text = contentText
        }
    }
    var contentImage: UIImage = #imageLiteral(resourceName: "placeholder_bgimg") {
        didSet {
            contentImageView.image = contentImage
        }
    }
    
    var clickAction: (() -> Void)?
    
    // MARK:- 控件
    fileprivate lazy var contentImageView: UIImageView = UIImageView()
    fileprivate lazy var contentTextLabel: UILabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let clickAction = clickAction {
            clickAction()
        }
    }

}

// MARK:-  private func
extension EmptyDataView {
    // MARK:- UI
    fileprivate func createUI() {
        isHidden = false
        addSubview(contentImageView)
        addSubview(contentTextLabel)
        
        contentTextLabel.text = contentText
        contentTextLabel.textAlignment = .center
        contentTextLabel.textColor = UIColor.lineColor()
        contentImageView.image = contentImage
        
        contentImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-80)
        }
        contentTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(contentImageView.snp.bottom).offset(16)
            make.centerX.equalTo(contentImageView)
        }
    }
}