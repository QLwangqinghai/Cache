//
//  MessageTableViewCell.swift
//  UIBasic
//
//  Created by wangqinghai on 2017/11/17.
//  Copyright © 2017年 wangqinghai. All rights reserved.
//

import UIKit


open class MessageTableViewHeaderFooterView: UIView {
    public let reuseIdentifier: String?
    
    public var layout: MessageTableViewItemLayout!
    
    public private(set) var contentView: UIView!
    public init(frame: CGRect, reuseIdentifier: String) {
        self.reuseIdentifier = reuseIdentifier
        super.init(frame: frame)
        let contentView = UIView(frame: self.bounds)
        self.addSubview(contentView)
        self.contentView = contentView
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.reuseIdentifier = nil
        super.init(coder: aDecoder)
        let contentView = UIView(frame: self.bounds)
        self.addSubview(contentView)
        self.contentView = contentView
    }
}

open class MessageTableViewCell: UIView {
    public let reuseIdentifier: String?

    public var layout: MessageTableViewItemLayout!
    
    public private(set) var contentView: UIView!
    public init(frame: CGRect, reuseIdentifier: String) {
        self.reuseIdentifier = reuseIdentifier
        super.init(frame: frame)
        let contentView = UIView(frame: self.bounds)
        self.addSubview(contentView)
        self.contentView = contentView
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.reuseIdentifier = nil
        super.init(coder: aDecoder)
        let contentView = UIView(frame: self.bounds)
        self.addSubview(contentView)
        self.contentView = contentView
    }

}

//open class TT: UITableViewDelegate {
//
//
//}

