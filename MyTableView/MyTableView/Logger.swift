//
//  Loger.swift
//  UIBasic
//
//  Created by CaiLianfeng on 2017/11/25.
//  Copyright © 2017年 wangqinghai. All rights reserved.
//

import Foundation

open class Logger: NSObject {
    public static let defaultDateFormat = "HH:mm:ss +SSS"
    
    let formater: DateFormatter = {
        let result = DateFormatter()
        result.dateFormat = Logger.defaultDateFormat
        return result
    }()
    
    open var dateFormat: String {
        get {
            return formater.dateFormat
        }
        set {
            formater.dateFormat = newValue
        }
    }
    
    open var currentTimeString: String {
        return formater.string(from: Date())
    }
    
    open func print(_ string: String? = nil) {
        if let value = string {
            Swift.print("⏱\(self.currentTimeString) \(value)")
        } else {
            Swift.print("⏱\(self.currentTimeString) ")
        }
    }
}


//@asmname("LoadModule") func OnLoadEndModule() {
//    
//    
//}



