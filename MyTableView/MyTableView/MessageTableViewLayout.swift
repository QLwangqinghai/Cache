//
//  MessageTableViewLayout.swift
//  UIBasic
//
//  Created by wangqinghai on 2017/11/16.
//  Copyright © 2017年 wangqinghai. All rights reserved.
//

import UIKit


open class MessageTableViewBaseLayout: NSObject {
    public internal(set) var frame: CGRect


    public init(frame: CGRect) {
        self.frame = frame
    }
}


open class MessageTableSectionHeaderViewLayout: MessageTableViewBaseLayout {
    public internal(set) var indexPath: IndexPath
    public var info: [String: Any] = [:]
    
    public var viewInfo: [String: Any] = [:]
    
    fileprivate var cell: MessageTableViewCell? = nil
    fileprivate var isShowing: Bool {
        if let cell = self.cell {
            return cell.superview != nil
        } else {
            return false
        }
    }
    
    internal init(frame: CGRect, indexPath: IndexPath) {
        self.indexPath = indexPath
        super.init(frame: frame)
    }
}


open class MessageTableViewItemLayout: NSObject {
    public internal(set) var frame: CGRect
    public internal(set) var indexPath: IndexPath
    public var info: [String: Any] = [:]
    
    public var viewInfo: [String: Any] = [:]
    
    fileprivate var cell: MessageTableViewCell? = nil
    fileprivate var isShowing: Bool {
        if let cell = self.cell {
            return cell.superview != nil
        } else {
            return false
        }
    }
    
    
    internal init(frame: CGRect, indexPath: IndexPath) {
        self.frame = frame
        self.indexPath = indexPath
    }
}


open class MessageTableViewFooterViewLayout: NSObject {
    public internal(set) var frame: CGRect
    public internal(set) var indexPath: IndexPath
    public var info: [String: Any] = [:]
    
    public var viewInfo: [String: Any] = [:]
    
    fileprivate var cell: MessageTableViewCell? = nil
    fileprivate var isShowing: Bool {
        if let cell = self.cell {
            return cell.superview != nil
        } else {
            return false
        }
    }
    
    internal init(frame: CGRect, indexPath: IndexPath) {
        self.frame = frame
        self.indexPath = indexPath
    }
}
open class MessageTableViewHeaderViewLayout: NSObject {
    public internal(set) var frame: CGRect
    public internal(set) var indexPath: IndexPath
    public var info: [String: Any] = [:]
    
    public var viewInfo: [String: Any] = [:]
    
    fileprivate var cell: MessageTableViewCell? = nil
    fileprivate var isShowing: Bool {
        if let cell = self.cell {
            return cell.superview != nil
        } else {
            return false
        }
    }
    
    
    internal init(frame: CGRect, indexPath: IndexPath) {
        self.frame = frame
        self.indexPath = indexPath
    }
}
open class MessageTableViewSectionFooterViewLayout: NSObject {
    public internal(set) var frame: CGRect
    public internal(set) var indexPath: IndexPath
    public var info: [String: Any] = [:]
    
    public var viewInfo: [String: Any] = [:]
    
    fileprivate var cell: MessageTableViewCell? = nil
    fileprivate var isShowing: Bool {
        if let cell = self.cell {
            return cell.superview != nil
        } else {
            return false
        }
    }
    
    
    internal init(frame: CGRect, indexPath: IndexPath) {
        self.frame = frame
        self.indexPath = indexPath
    }
}
open class MessageTableViewSectionHeaderViewLayout: NSObject {
    public internal(set) var frame: CGRect
    public internal(set) var indexPath: IndexPath
    public var info: [String: Any] = [:]
    
    public var viewInfo: [String: Any] = [:]
    
    fileprivate var cell: MessageTableViewCell? = nil
    fileprivate var isShowing: Bool {
        if let cell = self.cell {
            return cell.superview != nil
        } else {
            return false
        }
    }
    
    
    internal init(frame: CGRect, indexPath: IndexPath) {
        self.frame = frame
        self.indexPath = indexPath
    }
}

open class MessageTableViewSectionLayout: NSObject {
    public internal(set) var frame: CGRect
    
    public var headerLayout: MessageTableViewSectionHeaderViewLayout?
    public var footerLayout: MessageTableViewSectionFooterViewLayout?
    
    public var items: [MessageTableViewItemLayout] = []

    internal init(frame: CGRect, indexPath: IndexPath) {
        self.frame = frame
    }
}

open class MessageTableViewLayout: NSObject {
    public internal(set) var frame: CGRect
    
    public var headerLayout: MessageTableViewHeaderViewLayout?
    public var footerLayout: MessageTableViewFooterViewLayout?
    
    public var sections: [MessageTableViewSectionLayout] = []
    
    public var info: [String: Any] = [:]
    
    public var viewInfo: [String: Any] = [:]
    
    fileprivate var cell: MessageTableViewCell? = nil
    fileprivate var isShowing: Bool {
        if let cell = self.cell {
            return cell.superview != nil
        } else {
            return false
        }
    }
    
    
    internal init(frame: CGRect, indexPath: IndexPath) {
        self.frame = frame
    }
}







