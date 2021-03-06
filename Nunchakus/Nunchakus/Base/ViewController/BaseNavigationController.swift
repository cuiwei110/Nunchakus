//
//  BaseNavigationController.swift
//  Nunchakus
//
//  Created by kjlink on 2017/3/21.
//  Copyright © 2017年 sungrow. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    /*
    /// 这个类第一次被创建时调用,且只调用一次
    func initialize() {
        /// 1. 设置导航栏 UINavigationBar
        let navBar = UINavigationBar.appearance()
        navBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18), NSAttributedStringKey.foregroundColor: UIColor.globalColor()]
//        navBar.tintColor = UIColor.color(0xeeeeee)
        navBar.setBackgroundImage(#imageLiteral(resourceName: "navbar-bg"), for: UIBarMetrics.default)
        /// 2. 设置 UIBarButtonItem
        let barButtonItem = UIBarButtonItem.appearance()
        var normalItemDic: [NSAttributedStringKey: Any] = [NSAttributedStringKey: Any]()
        normalItemDic[NSAttributedStringKey.font] = UIFont.systemFont(ofSize: 15)
        normalItemDic[NSAttributedStringKey.foregroundColor] = UIColor.globalColor()
        barButtonItem.setTitleTextAttributes(normalItemDic, for: .normal)
        
        var disabledItemDic: [NSAttributedStringKey: Any] = [NSAttributedStringKey: Any]()
        disabledItemDic[NSAttributedStringKey.foregroundColor] = UIColor.globalColor()
        barButtonItem.setTitleTextAttributes(disabledItemDic, for: .disabled)
    }*/
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.isTranslucent = false
        /// 只要自定义导航栏左边的按钮, 右滑删除控制器的功能就没了,需要把delegate设置为nil, 让系统重新设置
        interactivePopGestureRecognizer?.delegate = nil
    }
    
    /// 在push之前拦截所有控制器, 然后自定义返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        /// 当前控制器不需要设置, 只有push到下一个页面时, 才需要设置返回按钮
        if self.viewControllers.count > 0 {
            let backButton = UIButton(type: .custom)
            backButton.setTitle(NSLocalizedString("返回", comment: ""), for: .normal)
            backButton.setTitleColor(UIColor.black, for: .normal)
            backButton.setTitleColor(UIColor.black, for: .highlighted)
            backButton.setImage(#imageLiteral(resourceName: "navbar-back").image(UIColor.globalColor()), for: .normal)
            backButton.setImage(#imageLiteral(resourceName: "navbar-back").image(UIColor.globalColor()), for: .highlighted)
            backButton.frame.size = CGSize(width: 70, height: 30)
            /// 设置按钮的内容左对齐
            backButton.contentHorizontalAlignment = .left
            /// 设置按钮内容的内边距
            backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
            backButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
            backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
            viewController.hidesBottomBarWhenPushed = true
            navigationBar.isHidden = false
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    // MARK:- 返回
    @objc private func backAction() {
        popViewController(animated: true)
    }
}
