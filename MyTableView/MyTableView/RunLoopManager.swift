//
//  RunLoopManager.swift
//  UIBasic
//
//  Created by CaiLianfeng on 2017/11/18.
//  Copyright © 2017年 wangqinghai. All rights reserved.
//

import UIKit

public class RunLoopLogger: Logger {
    public class FrameLog {
        public var logNeeds: Int64 = 0
        public var logs: [String] = []
        public var beginTime: CFTimeInterval = 0
        public var endTime: CFTimeInterval = 0
        public init() {}
    }
    
    public var frameLogs: [FrameLog] = []
    
    
    public func corverTime(_ time: CFTimeInterval) -> String {
        let m = Int64((time - Double(Int64(time) / 60 * 60)) * 1000000000)
        let m1 = m / 1000000000
        let m2 = m % 1000000000 / 1000000
        let m3 = m % 1000000
        let ms = String(format: "%02ld +%03ld ++%06ld", m1, m2, m3)
        return "\(ms)"
    }
    
    public override var currentTimeString: String {
        let time = CFAbsoluteTimeGetCurrent()
        return corverTime(time)

//        return "\(formater.string(from: Date(timeIntervalSince1970: time + Date.timeIntervalSinceReferenceDate))) \(ms)"
    }
    
    public override init() {
        super.init()
        self.dateFormat = "mm:ss +SSS"
    }
    
    public func beginFrame(_ string: String? = nil) {
        let log = FrameLog()
        log.beginTime = CFAbsoluteTimeGetCurrent()
        if let str = string {
            log.logs.append("⏱\(self.corverTime(log.beginTime)) frame begin \(str) ------------")
        } else {
            log.logs.append("⏱\(self.corverTime(log.beginTime)) frame begin ------------")
        }
        self.frameLogs.append(log)
    }
    
    public func timeString(time: CFTimeInterval, count: Int) -> String {
        switch count {
        case 0:
            return String(format: "%.00lf", time)
        case 1:
            return String(format: "%.01lf", time)
        case 2:
            return String(format: "%.02lf", time)
        case 3:
            return String(format: "%.03lf", time)
        case 4:
            return String(format: "%.04lf", time)
        case 5:
            return String(format: "%.05lf", time)
        case 6:
            return String(format: "%.06lf", time)
        case 7:
            return String(format: "%.07lf", time)
        case 8:
            return String(format: "%.08lf", time)
        case 9:
            return String(format: "%.09lf", time)
        case 10:
            return String(format: "%.010lf", time)
        case 11:
            return String(format: "%.011lf", time)
        default:
            return String(format: "%lf", time)
        }
        
    }
    
    
    
    public func endFrame() {
        guard let log = self.frameLogs.last else {
            return
        }
        log.endTime = CFAbsoluteTimeGetCurrent()
        let dt = log.endTime - log.beginTime
        var str = ""
        let frames = Int(dt / (1.0/60) + 0.5)
        if frames >= 2 {
            str = " 掉帧数： \(frames-1)"
        }
        
        log.logs.append("⏱\(self.corverTime(log.endTime)) frame end 用时: \(self.timeString(time: dt, count: 6))\(str)  ===========\n")
        if log.logNeeds > 0 {
            for item in log.logs {
                Swift.print(item)
            }
        }
    }
    public override func print(_ string: String? = nil) {
        if let value = string {
            self.frameLogs.last?.logs.append("⏱\(self.currentTimeString) \(value)")
        } else {
            self.frameLogs.last?.logs.append("⏱\(self.currentTimeString) ")
        }
    }
    
    public func setNeetsPrint() {
        self.frameLogs.last?.logNeeds += 1
    }
    
}


let logger: RunLoopLogger = {
    let l = RunLoopLogger()
    return l
}()


public enum RunLoopWorkItemWillPerformResult: UInt32 {
    case perform = 0
    case canceled = 1
    case nextDisplay = 2
}


//调度的最小单位
public protocol RunLoopWorkItemProtocol: class {
    var cost: UInt32 { get }
    var cpuCost: UInt32 { get }
    var gpuCost: UInt32 { get }
    
    func perform(_ context: RunLoopWorkContext) -> UInt32
}

public protocol RunLoopWorkerProtocol: NSObjectProtocol {
    var isSuspended: Bool { get }
    var isEmpty: Bool { get }
    func willPerform(_ context: RunLoopWorkContext) -> Bool
    func perform(_ context: RunLoopWorkContext)
    
    func becomeKeyWorker()
    func resignKeyWorker()

}


public final class RunLoopWorkContext : NSObject {
    public private(set) var freeTime: Double = 0
    public fileprivate(set) var isInTrackingRunLoopMode: Bool = false
    public fileprivate(set) var displaySequence: UInt64 = 0
    public fileprivate(set) var totalTime: Double = 0

    public func consumeTime(_ time: Double) {
        freeTime -= time
    }
    public func resetFreeTime(_ time: Double) {
        freeTime = time
    }
}


public enum RunLoopWorkItemPerformResult: UInt32 {
    case canceled = 0
    case end = 1
    case nextDisplay = 2
}

public final class RunLoopWorkItem : RunLoopWorkItemProtocol {
    public static var oneFrameCost: Int32 {
        return 1000
    }
    public static let minCost: UInt32 = 1
    public static let defaultCost: UInt32 = 600
    public static let maxCost: UInt32 = 1200

    public var isCanceled: Bool = false
    public var isEnd: Bool = false

    public private(set) var cost: UInt32

    public private(set) var cpuCost: UInt32 = 1
    public private(set) var gpuCost: UInt32 = 1

    public private(set) var scale: Double = 1
    
    private var closure: (() -> Void)?
    
    public init<T: AnyObject>(object: T, cpuCost: UInt32, gpuCost: UInt32, closure: @escaping (T) -> Void) {
        if cpuCost < RunLoopWorkItem.minCost {
            self.cpuCost = RunLoopWorkItem.minCost
        } else if cpuCost > RunLoopWorkItem.maxCost {
            self.cpuCost = RunLoopWorkItem.maxCost
        } else {
            self.cpuCost = cpuCost
        }
        if gpuCost < RunLoopWorkItem.minCost {
            self.gpuCost = RunLoopWorkItem.minCost
        } else if gpuCost > RunLoopWorkItem.maxCost {
            self.gpuCost = RunLoopWorkItem.maxCost
        } else {
            self.gpuCost = gpuCost
        }
        self.cost = self.cpuCost + self.gpuCost
        
        
        weak var obj: T? = object
        
        let item: () -> Void = {[unowned self]()-> Void in
            guard let target = obj else {
                self.closure = nil
                return
            }
            
            closure(target)
            self.closure = nil
        }
        self.closure = item
    }
    
    public init(cpuCost: UInt32, gpuCost: UInt32, closure: @escaping () -> Void) {
        if cpuCost < RunLoopWorkItem.minCost {
            self.cpuCost = RunLoopWorkItem.minCost
        } else if cpuCost > RunLoopWorkItem.maxCost {
            self.cpuCost = RunLoopWorkItem.maxCost
        } else {
            self.cpuCost = cpuCost
        }
        if gpuCost < RunLoopWorkItem.minCost {
            self.gpuCost = RunLoopWorkItem.minCost
        } else if gpuCost > RunLoopWorkItem.maxCost {
            self.gpuCost = RunLoopWorkItem.maxCost
        } else {
            self.gpuCost = gpuCost
        }
        self.cost = self.cpuCost + self.gpuCost
        
        self.closure = closure
    }
    public func perform(_ context: RunLoopWorkContext) -> UInt32 {
        guard self.isEnd == false else {
            return RunLoopWorkItemPerformResult.end.rawValue
        }
        guard self.isCanceled == false else {
            self.closure = nil
            self.isCanceled = true
            return RunLoopWorkItemPerformResult.canceled.rawValue
        }
        
        let consumeTime = RunLoopManager.timeWithcost(self.cost)
        if context.freeTime > consumeTime * scale || context.totalTime < consumeTime {
            guard let closure = self.closure else {
                self.closure = nil
                return RunLoopWorkItemPerformResult.canceled.rawValue
            }
            closure()
            context.consumeTime(consumeTime)
            self.isEnd = true
            self.closure = nil
            return RunLoopWorkItemPerformResult.end.rawValue
        } else {
            self.scale /= 2
            return RunLoopWorkItemPerformResult.nextDisplay.rawValue
        }
    }
    public func cancel() {
        self.isCanceled = true
        self.closure = nil
    }
}

public final class RunLoopWorkLinker<T: AnyObject> {
    let target: T
    let worker: RunLoopWorker
    public init(target: T, worker: RunLoopWorker) {
        self.target = target
        self.worker = worker
    }
    
    public func append(cpuCost: UInt32, gpuCost: UInt32, closure: @escaping (T) -> Void) -> RunLoopWorkLinker<T> {
        let item = RunLoopWorkItem(object: self.target, cpuCost: cpuCost, gpuCost: gpuCost, closure: closure)
        worker.appendItem(item)
        return self
    }
}

public final class RunLoopWorker: NSObject, RunLoopWorkerProtocol {
 
    typealias RunLoopWorkerClosure = (RunLoopWorker) -> Void
    
    public private(set) var isKeyWorker: Bool = false
    fileprivate var items: [RunLoopWorkItemProtocol] = []
    public private(set) var isSuspended: Bool = false
    public var isEmpty: Bool {
        return self.items.isEmpty
    }
    private var breakedDisplaySequence: UInt64 = 0
    
    public override init() {
        super.init()
    }
    
    public func makeWorkQueue<T: AnyObject>(_ target: T) -> RunLoopWorkLinker<T> {
        return RunLoopWorkLinker<T>(target: target, worker: self)
    }
    
    public func appendItem(_ item: RunLoopWorkItem) {
        self.items.append(item)
    }
    
    public func suspend() {
        self.isSuspended = true
    }
    public func resume() {
        self.isSuspended = false
    }
    
    
    public func willPerform(_ context: RunLoopWorkContext) -> Bool {
        if self.isEmpty {
            return false
        } else {
            if breakedDisplaySequence == context.displaySequence {
                return false
            }
            return true
        }
    }
    public func perform(_ context: RunLoopWorkContext) {
        if let item = self.items.first {
            let result = item.perform(context)
            if result == RunLoopWorkItemPerformResult.nextDisplay.rawValue {
                self.breakedDisplaySequence = context.displaySequence
            } else {// others remove item
                self.items.removeFirst()
            }
        }
    }
    public func becomeKeyWorker() {
        self.isKeyWorker = true
    }
    public func resignKeyWorker() {
        self.isKeyWorker = false
    }

}

public protocol UIViewControllerRunLoopWorkLoadSubviewsLinker {
//    public func appendLoadSubviewItem(cost: Int32, closure: @escaping (T) -> Void) -> UIViewControllerRunLoopWorkLinker<T>

    
}

public final class UIViewControllerRunLoopWorkLinker<T: AnyObject> {
    weak var target: T?
    unowned var worker: UIViewControllerRunLoopWorker
    public init(target: T, worker: UIViewControllerRunLoopWorker) {
        self.target = target
        self.worker = worker
    }
    
    @discardableResult public func appendLoadSubviewItem(cpuCost: UInt32, gpuCost: UInt32, closure: @escaping (T) -> Void) -> Self {
        guard let target = self.target else {
            return self
        }
        let item = RunLoopWorkItem(object: target, cpuCost: cpuCost, gpuCost: gpuCost, closure: closure)
        worker.loadSubviewItems.append(item)
        return self
    }
    @discardableResult public func appendItem(cpuCost: UInt32, gpuCost: UInt32, closure: @escaping (T) -> Void) -> Self {
        guard let target = self.target else {
            return self
        }
        let item = RunLoopWorkItem(object: target, cpuCost: cpuCost, gpuCost: gpuCost, closure: closure)
        worker.items.append(item)
        return self
    }
    @discardableResult public func appendLoadSubviewItem(gpuCost: UInt32, closure: @escaping (T) -> Void) -> Self {
        guard let target = self.target else {
            return self
        }
        let item = RunLoopWorkItem(object: target, cpuCost: 1, gpuCost: gpuCost, closure: closure)
        worker.loadSubviewItems.append(item)
        return self
    }
    @discardableResult public func appendItem(gpuCost: UInt32, closure: @escaping (T) -> Void) -> Self {
        guard let target = self.target else {
            return self
        }
        let item = RunLoopWorkItem(object: target, cpuCost: 1, gpuCost: gpuCost, closure: closure)
        worker.items.append(item)
        return self
    }
}
public class UIViewControllerRunLoopWorker: NSObject, RunLoopWorkerProtocol {
    public private(set) var isKeyWorker: Bool = false

//    typealias RunLoopWorkerClosure = (RunLoopWorker) -> Void
    
    fileprivate var loadSubviewItems: [RunLoopWorkItemProtocol] = []
    fileprivate var items: [RunLoopWorkItemProtocol] = []
    
    public private(set) var isSuspended: Bool = false
    public var isEmpty: Bool {
        return self.loadSubviewItems.isEmpty && self.items.isEmpty
    }
    private var breakedDisplaySequence: UInt64 = 0
    
    public override init() {
        super.init()
    }
    
    public func linker<T: AnyObject>(_ target: T) -> UIViewControllerRunLoopWorkLinker<T> {
        return UIViewControllerRunLoopWorkLinker<T>(target: target, worker: self)
    }
    
    public func suspend() {
        self.isSuspended = true
    }
    public func resume() {
        self.isSuspended = false
    }
    
    public func willPerform(_ context: RunLoopWorkContext) -> Bool {
        if breakedDisplaySequence == context.displaySequence {
            return false
        } else {
            var first = self.loadSubviewItems.first
            if nil == first {
                first = self.items.first
            }
            if nil != first {
                return true
            } else {
                return false
            }
        }
    }
    public func perform(_ context: RunLoopWorkContext) {
        var first = self.loadSubviewItems.first
        if let item = first {
            let result = item.perform(context)
            if result != RunLoopWorkItemPerformResult.nextDisplay.rawValue {
                self.loadSubviewItems.removeFirst()
            }
        } else {
            first = self.items.first
            if let item = first {
                let result = item.perform(context)
                if result != RunLoopWorkItemPerformResult.nextDisplay.rawValue {
                    self.items.removeFirst()
                }
            }
        }
    }
    public func becomeKeyWorker() {
        self.isKeyWorker = true
    }
    public func resignKeyWorker() {
        self.isKeyWorker = false
    }
}



public final class CADisplayLinkInfo: NSObject {
    public fileprivate(set) var lastTimestamp: CFTimeInterval = 0
    public fileprivate(set) var lastDuration: CFTimeInterval = 0
    public fileprivate(set) var lastWaitingTime: CFTimeInterval = 0

    public fileprivate(set) var timestamp: CFTimeInterval
    public fileprivate(set) var duration: CFTimeInterval
    public fileprivate(set) var targetTimestamp: CFTimeInterval
    
    public fileprivate(set) var waitingTime: CFTimeInterval = 0
    public fileprivate(set) var isInTrackingRunLoopMode: Bool = false
    fileprivate var displaySequence: UInt64 = 0

    public let workContext: RunLoopWorkContext = RunLoopWorkContext()

    fileprivate init(timestamp: CFTimeInterval, duration: CFTimeInterval, targetTimestamp: CFTimeInterval?) {
        self.timestamp = timestamp
        self.duration = duration
        if let targetTimestampValue = targetTimestamp {
            self.targetTimestamp = targetTimestampValue
        } else {
            self.targetTimestamp = timestamp + duration
        }
        super.init()
    }
    
    fileprivate func nextDisplaySequence() {
        displaySequence = displaySequence &+ 1
    }
    
}
public extension CADisplayLink {
    public var info: CADisplayLinkInfo {
        if #available(iOS 10.0, *) {
            return CADisplayLinkInfo(timestamp: self.timestamp, duration: self.duration, targetTimestamp: self.targetTimestamp)
        } else {
            return CADisplayLinkInfo(timestamp: self.timestamp, duration: self.duration, targetTimestamp: nil)
        }
    }
}


private var CADisplayLinkPrinterDefaultContext = 0
open class CADisplayLinkPrinter: NSObject {
    fileprivate var _count: Int = 0
    fileprivate var _lastLogTime: CFTimeInterval = 0

    public override init() {
        super.init()
        RunLoopManager.manager.addDisplayLinkListener(self, context: &CADisplayLinkPrinterDefaultContext) {[unowned self] (linkInfo) in
            self.handleDisplayLink(linkInfo)
        }
    }
    
    open func handleDisplayLink(_ linkInfo: CADisplayLinkInfo) {
        if (_lastLogTime == 0) {
            _lastLogTime = linkInfo.timestamp
        }
        _count += 1
//
//        let fps = Double(_count) / linkInfo.
//        _count = 0
//
//        if linkInfo.lastDuration < 5000 {
//            print("上一帧 main 空闲占比: \(self.lastFrameWaitingScale)/10000, 帧间隔时间:\(delta) 空闲时间: \(lastFrameWaitingTime)")
//        }
//
        
//        if link.timestamp - lastPTime > 1 {
//            lastPTime = link.timestamp
//            let progress = fps / 60.0;
//            self._label.text = "\(Int(fps+0.5))FPS"
//            self._label.textColor = UIColor(hue: CGFloat(0.27 * ( progress - 0.2 )) , saturation: 1, brightness: 0.9, alpha: 1)
//        }
        if linkInfo.timestamp > _lastLogTime + 1 {
            let times = Double(_count) / (linkInfo.timestamp - _lastLogTime) + 0.5
            logger.print("帧率：\(Int(times))")
            _count = 0
            _lastLogTime = linkInfo.timestamp
            
            if times < 59 {
                logger.setNeetsPrint()
            }
        }

    }
    
    deinit {
        RunLoopManager.manager.removeDisplayLinkListener(self, context: &CADisplayLinkPrinterDefaultContext)
    }
    
    public static let `default`: CADisplayLinkPrinter = CADisplayLinkPrinter()
}


public final class RunLoopManager: NSObject {
    public typealias DisplayLinkClosure = (CADisplayLinkInfo) -> Void
    
    public typealias RunLoopWorkerE = RunLoopWorkerProtocol

    
    fileprivate struct ObjectDisplayLinkClosure {
        let closure: DisplayLinkClosure
        let context: UnsafeRawPointer?
        
        init(closure: @escaping DisplayLinkClosure, context: UnsafeRawPointer?) {
            self.closure = closure
            self.context = context
        }
    }
    
    fileprivate var runloopWorkers: [NSObject & RunLoopWorkerProtocol] = []

    fileprivate var displayLinkListeners: [UnsafeMutableRawPointer: [ObjectDisplayLinkClosure]] = [:]
    
    public private(set) var observer: CFRunLoopObserver!
    public static let manager: RunLoopManager = RunLoopManager()
    
    //单位 万分之1
    public private(set) var lastFrameWaitingScale: Int = 0
    
    fileprivate var lastRunLoopSleepTime: TimeInterval?
    
    public private(set) var isWaiting: Bool = false
    
    fileprivate var displayLink: CADisplayLink!
    
    public fileprivate(set) var currentMode: String = "" {
        didSet(oldValue) {
            if oldValue != currentMode {
                self.isInTrackingRunLoopMode = currentMode == RunLoopMode.UITrackingRunLoopMode.rawValue
                logger.print("currentMode from:\(oldValue) changed to: \(currentMode) ")
            }
        }
    }
    public fileprivate(set) var isInTrackingRunLoopMode: Bool
    fileprivate var lastPerformDisplaySequence: UInt64 = 0

    private override init() {
        self.isInTrackingRunLoopMode = RunLoop.current.currentMode == RunLoopMode.UITrackingRunLoopMode
        super.init()
        
        let observer: CFRunLoopObserver = CFRunLoopObserverCreateWithHandler(nil, CFRunLoopActivity.allActivities.rawValue, true, 0) {[unowned self] (observer, event) in
            if let currentMode = RunLoop.current.currentMode?.rawValue {
                self.currentMode = currentMode
            }
            
            var eventString: [String] = []
            if event.contains(CFRunLoopActivity.entry) {
                eventString += ["entry"]
            }
            if event.contains(CFRunLoopActivity.beforeTimers) {
                eventString += ["doTimers"]
            }
            if event.contains(CFRunLoopActivity.beforeSources) {
                eventString += ["doSources"]
            }
    
            if event.contains(CFRunLoopActivity.beforeWaiting) {
                eventString += ["waiting"]
            }
            if event.contains(CFRunLoopActivity.afterWaiting) {
                eventString += ["afterWaiting"]
            }
            if event.contains(CFRunLoopActivity.exit) {
                eventString += ["exit"]
            }

//            if event.contains(CFRunLoopActivity.entry) {
//                self.isInTrackingRunLoopMode = RunLoop.current.currentMode == RunLoopMode.UITrackingRunLoopMode
//            }
            if event.contains(CFRunLoopActivity.beforeWaiting) {
                if self.lastPerformDisplaySequence != self.linkInfo.displaySequence {
                    self.lastPerformDisplaySequence = self.linkInfo.displaySequence
                    if !self.runloopWorkers.isEmpty {
                        let time = CFAbsoluteTimeGetCurrent()
                        self.perform()
                        let endTime = CFAbsoluteTimeGetCurrent()
                        let used = endTime - time
                        logger.print("perform used time: \(String(format: "%.06lf", used))")
                    }
                }
                logger.print("events: \(eventString)")
                self.isWaiting = true
                self.lastRunLoopSleepTime = CACurrentMediaTime()
            } else {
                logger.print("events: \(eventString)")
            }
            if event.contains(CFRunLoopActivity.afterWaiting) {
                if let lastSleepTime = self.lastRunLoopSleepTime {
                    self.linkInfo.waitingTime += CACurrentMediaTime() - lastSleepTime
                    self.lastRunLoopSleepTime = nil
                }
                self.isWaiting = false
            }
        }
        CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, CFRunLoopMode.commonModes)
        self.observer = observer
        
        let displayLink = CADisplayLink(target: self, selector:#selector(RunLoopManager.tick(_:)) );
        displayLink.frameInterval = 1
        displayLink.add(to: RunLoop.main, forMode:RunLoopMode.commonModes)
        self.displayLink = displayLink
    }
    
    private let linkInfo: CADisplayLinkInfo = {
        let linkInfo: CADisplayLinkInfo
        if #available(iOS 10.0, *) {
            linkInfo = CADisplayLinkInfo(timestamp: 0, duration: 0, targetTimestamp: 0)
        } else {
            linkInfo = CADisplayLinkInfo(timestamp: 0, duration: 0, targetTimestamp: 0)
        }
        return linkInfo
    } ()
    private var workContext: RunLoopWorkContext {
        return self.linkInfo.workContext
    }
    
    public func displayLinkInfo(_ link: CADisplayLink) -> CADisplayLinkInfo {
        let linkInfo: CADisplayLinkInfo = self.linkInfo
        linkInfo.lastTimestamp = linkInfo.timestamp
        linkInfo.lastDuration = link.timestamp - linkInfo.lastTimestamp
        linkInfo.lastWaitingTime = linkInfo.waitingTime

        linkInfo.timestamp = link.timestamp
        linkInfo.duration = link.duration
        linkInfo.isInTrackingRunLoopMode = self.isInTrackingRunLoopMode
        linkInfo.waitingTime = 0
        
        var duration: CFTimeInterval = 0
        if #available(iOS 10.0, *) {
            duration = link.targetTimestamp - link.timestamp
        } else {
            duration = link.duration
        }
        
        linkInfo.targetTimestamp = link.timestamp + duration
        
        return linkInfo
    }
    
    
    public static func timeWithcost(_ cost: UInt32) -> CFTimeInterval {
        
        return Double(cost) / 1000.0
    }
    
    
    func perform() {
        workContext.isInTrackingRunLoopMode = self.isInTrackingRunLoopMode
        for worker in self.runloopWorkers {
            if worker.isSuspended {
                continue
            }

            var isTimeNotEnough = false
            var loop: Bool = !worker.isSuspended && (!worker.isEmpty)
            
            while loop {
                let time = CACurrentMediaTime()
                let remainTimeLimit: Double = 0.0001
                if workContext.freeTime < remainTimeLimit {
                    loop = false
                    isTimeNotEnough = true
                } else {
                    let time = CFAbsoluteTimeGetCurrent()
                    if worker.willPerform(workContext) {
                        worker.perform(workContext)
                        loop = !worker.isSuspended && (!worker.isEmpty)
                    } else {
                        loop = false
                    }
                    let endTime = CFAbsoluteTimeGetCurrent()
                    let used = endTime - time
                    logger.print("item perform used time: \(String(format: "%.06lf", used))")

                }
                workContext.consumeTime(CACurrentMediaTime() - time)
            }
            
            if isTimeNotEnough {
                return
            }
        }
    }
    
    @objc func tick(_ link: CADisplayLink) {
        
        self.linkInfo.duration = link.timestamp - self.linkInfo.timestamp
        if self.linkInfo.duration > 1.0 / 60 * 9 / 8 {
            logger.print("好像掉帧了 帧间隔时间:\(String.init(format: "%.06lf", self.linkInfo.lastDuration))")
            logger.setNeetsPrint()
        }
        
        logger.endFrame()
        
        let linkInfo: CADisplayLinkInfo = self.displayLinkInfo(link)
        logger.beginFrame("\(link.duration)")

        linkInfo.nextDisplaySequence()
        workContext.displaySequence = linkInfo.displaySequence
        let displayLinkInfoMaxSpaceTime = 0.016 * 2
        var duration = linkInfo.duration
        if duration > displayLinkInfoMaxSpaceTime {
            duration = displayLinkInfoMaxSpaceTime
        }
        self.workContext.resetFreeTime(duration - 0.001)
        self.workContext.totalTime = duration - 0.001
        
        
        if linkInfo.lastTimestamp == 0  {
            return
        }
        
        if (linkInfo.lastDuration != 0) {
            self.lastFrameWaitingScale = Int(linkInfo.lastWaitingTime / linkInfo.lastDuration * 10000.0)
        }
        
        _ = self.displayLinkListeners.mapValues { (itemArray) -> Void in
            _ = itemArray.map({ (item) -> Void in
                item.closure(linkInfo)
            })
        }
    }
    
    public func addDisplayLinkListener(_ listener: AnyObject, context: UnsafeRawPointer, closure: @escaping DisplayLinkClosure) {
        if var array = self.displayLinkListeners[Unmanaged.passUnretained(listener).toOpaque()] {
            array = array.filter({ (item) -> Bool in
                return item.context != context
            })
            
            array.append(ObjectDisplayLinkClosure(closure: closure, context: context))
            self.displayLinkListeners[Unmanaged.passUnretained(listener).toOpaque()] = array
        } else {
            self.displayLinkListeners[Unmanaged.passUnretained(listener).toOpaque()] = [ObjectDisplayLinkClosure(closure: closure, context: context)]
        }
    }
    public func removeDisplayLinkListener(_ listener: AnyObject, context: UnsafeRawPointer) {
        if var array = self.displayLinkListeners[Unmanaged.passUnretained(listener).toOpaque()] {
            array = array.filter({ (item) -> Bool in
                return item.context != context
            })
            if array.isEmpty {
                self.displayLinkListeners.removeValue(forKey:Unmanaged.passUnretained(listener).toOpaque())
            } else {
                self.displayLinkListeners[Unmanaged.passUnretained(listener).toOpaque()] = array
            }
        }
    }
    public func removeDisplayLinkListener(_ listener: AnyObject) {
        self.displayLinkListeners.removeValue(forKey:Unmanaged.passUnretained(listener).toOpaque())
    }
    
    public func insertWorker(_ worker: NSObject & RunLoopWorkerProtocol) {
        self.runloopWorkers.insert(worker, at: 0)
    }
    public func appendWorker(_ worker: NSObject & RunLoopWorkerProtocol) {
        self.runloopWorkers.append(worker)
    }
    public func removeWorker(_ worker: NSObject & RunLoopWorkerProtocol) {
        if let index = self.runloopWorkers.index(where: { (item) -> Bool in
            return item == worker
        }) {
            self.runloopWorkers.remove(at: index)
        }
    }
}

