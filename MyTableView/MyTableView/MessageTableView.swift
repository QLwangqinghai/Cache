//
//  MessageTableView.swift
//  UIBasic
//
//  Created by wangqinghai on 2017/11/16.
//  Copyright © 2017年 wangqinghai. All rights reserved.
//

import UIKit


//adapter

public class MessageTableViewWrapperView: UIImageView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isUserInteractionEnabled = true
    }
    
    open override var frame: CGRect {
        didSet(old) {
            print("<MessageTableViewWrapperView frame- didSet: \(frame), old: \(old)")
        }
    }
    open override var bounds: CGRect {
        didSet(old) {
            print("<MessageTableViewWrapperView bounds- didSet: \(bounds), old: \(old)")
        }
    }
    open override func safeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            print("MessageTableViewWrapperView safeAreaInsets: \(self.safeAreaInsets) bounds: \(self.bounds) \n【safeAreaLayoutGuide\(self.safeAreaLayoutGuide) ")
        }
    }
    
    func tt() {
        self.alignmentRectInsets
        
    }

}

private var __messageTableViewContext: UInt32 = 0
public let messageTableViewContext: UnsafeMutableRawPointer = UnsafeMutableRawPointer(&__messageTableViewContext)




//public protocol UITableViewDataSource : NSObjectProtocol {
//
//
//    @available(iOS 2.0, *)
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//
//
//    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
//    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
//
//    @available(iOS 2.0, *)
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//
//
//    @available(iOS 2.0, *)
//    optional public func numberOfSections(in tableView: UITableView) -> Int // Default is 1 if not implemented
//
//
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? // fixed font style. use custom view (UILabel) if you want something different
//
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
//
//
//    // Editing
//
//    // Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
//
//
//    // Moving/reordering
//
//    // Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
//
//
//    // Index
//
//    @available(iOS 2.0, *)
//    optional public func sectionIndexTitles(for tableView: UITableView) -> [String]? // return list of section titles to display in section index view (e.g. "ABCD...Z#")
//
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int // tell table which section corresponds to section title/index (e.g. "B",1))
//
//
//    // Data manipulation - insert and delete support
//
//    // After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
//    // Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
//
//
//    // Data manipulation - reorder / moving support
//
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
//}


@objc public protocol MessageTableViewDataSource: NSObjectProtocol {
    func tableView(_ tableView: MessageTableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: MessageTableView, cellForRowAt indexPath: IndexPath) -> MessageTableViewCell
    func numberOfSections(in tableView: MessageTableView) -> Int // Default is 1 if not implemented
    
    func tableView(_ tableView: MessageTableView, hasHeaderInSection section: Int) -> Bool
    func tableView(_ tableView: MessageTableView, hasFooterInSection section: Int) -> Bool
    
    func tableView(_ tableView: MessageTableView, viewForHeaderInSection section: Int) -> MessageTableViewHeaderFooterView
    func tableView(_ tableView: MessageTableView, viewForFooterInSection section: Int) -> MessageTableViewHeaderFooterView
}

@objc public protocol MessageTableViewDelegate : NSObjectProtocol {
    
    @objc optional func tableView(_ tableView: MessageTableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    @objc optional func tableView(_ tableView: MessageTableView, willDisplayHeaderView view: UIView, forSection section: Int)
    @objc optional func tableView(_ tableView: MessageTableView, willDisplayFooterView view: UIView, forSection section: Int)
    @objc optional func tableView(_ tableView: MessageTableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
    @objc optional func tableView(_ tableView: MessageTableView, didEndDisplayingHeaderView view: UIView, forSection section: Int)
    @objc optional func tableView(_ tableView: MessageTableView, didEndDisplayingFooterView view: UIView, forSection section: Int)

    
    func tableView(_ tableView: MessageTableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    

    func tableView(_ tableView: MessageTableView, heightForHeaderInSection section: Int) -> CGFloat
    func tableView(_ tableView: MessageTableView, heightForFooterInSection section: Int) -> CGFloat
    
    
    @objc optional func tableView(_ tableView: MessageTableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
    @objc optional func tableView(_ tableView: MessageTableView, didHighlightRowAt indexPath: IndexPath)
    @objc optional func tableView(_ tableView: MessageTableView, didUnhighlightRowAt indexPath: IndexPath)
    @objc optional func tableView(_ tableView: MessageTableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
    @objc optional func tableView(_ tableView: MessageTableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath?
    @objc optional func tableView(_ tableView: MessageTableView, didSelectRowAt indexPath: IndexPath)
    @objc optional func tableView(_ tableView: MessageTableView, didDeselectRowAt indexPath: IndexPath)
    
    
//    // Editing
//
//    // Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle
//
//    @available(iOS 3.0, *)
//    optional public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
//
//
//    // Use -tableView:trailingSwipeActionsConfigurationForRowAtIndexPath: instead of this method, which will be deprecated in a future release.
//    // This method supersedes -tableView:titleForDeleteConfirmationButtonForRowAtIndexPath: if return value is non-nil
//    @available(iOS 8.0, *)
//    optional public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
//
//
//    // Swipe actions
//    // These methods supersede -editActionsForRowAtIndexPath: if implemented
//    // return nil to get the default swipe actions
//    @available(iOS 11.0, *)
//    optional public func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
//
//    @available(iOS 11.0, *)
//    optional public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
//
//
//    // Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool
//
//
//    // The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath)
//
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?)
//
//
//    // Moving/reordering
//
//    // Allows customization of the target row for a particular row as it is being moved/reordered
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath
    
    
    // Indentation
    
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int // return 'depth' of row for hierarchies
//
//
//    // Copy/Paste.  All three methods must be implemented by the delegate.
//
//    @available(iOS 5.0, *)
//    optional public func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool
//
//    @available(iOS 5.0, *)
//    optional public func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool
//
//    @available(iOS 5.0, *)
//    optional public func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?)
//
//
//    // Focus
//
//    @available(iOS 9.0, *)
//    optional public func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool
//
//    @available(iOS 9.0, *)
//    optional public func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool
//
//    @available(iOS 9.0, *)
//    optional public func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator)
//
//    @available(iOS 9.0, *)
//    optional public func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath?
//
//
//    // Spring Loading
//
//    // Allows opting-out of spring loading for an particular row.
//    // If you want the interaction effect on a different subview of the spring loaded cell, modify the context.targetView property. The default is the cell.
//    // If this method is not implemented, the default is YES except when the row is part of a drag session.
//    @available(iOS 11.0, *)
//    optional public func tableView(_ tableView: UITableView, shouldSpringLoadRowAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool
}


open class MessageTableView: UIScrollView {
    let worker: RunLoopWorker = RunLoopWorker()
    
    public weak var dataSource: MessageTableViewDataSource?
    public weak var tableViewDelegate: MessageTableViewDelegate?

    fileprivate class Section {
        var hasHeader: Bool = false
        var hasFooter: Bool = false

        var headerFrame: CGRect = CGRect()
        var footerFrame: CGRect = CGRect()
        
        var sectionRect: CGRect = CGRect()

        
        var index: Int
        fileprivate(set) var items: [MessageTableViewItemLayout] = []
        init(index: Int) {
            self.index = index
        }
    }
    
    fileprivate class ReuseCache {
        let reuseIdentifier: String
        let nib: UINib?
        let cellClass: Swift.AnyClass?

        var cache: [IndexPath: MessageTableViewCell] = [:]
        init(reuseIdentifier: String, nib: UINib) {
            self.reuseIdentifier = reuseIdentifier
            self.nib = nib
            self.cellClass = nil
        }
        init(reuseIdentifier: String, cellClass: Swift.AnyClass) {
            self.reuseIdentifier = reuseIdentifier
            self.nib = nil
            self.cellClass = cellClass
        }
        init(reuseIdentifier: String) {
            self.reuseIdentifier = reuseIdentifier
            self.nib = nil
            self.cellClass = nil
        }
        
        func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath, showFrame: CGRect, scrollDirection: ScrollDirection) -> MessageTableViewCell? {
            
            return nil
        }
    }
    
    public private(set) var cellLayouts: [MessageTableViewItemLayout] = []
    private var sections: [Section] = []

    open var tableTopSpace: CGFloat = 0
    open var tableBottomSpace: CGFloat = 0

    
    open var tableHeaderViewHeight: CGFloat = 0
    open var tableFooterViewHeight: CGFloat = 0
    
    open var tableHeaderView: UIView?
    open var tableFooterView: UIView?
    private var contentWidth: CGFloat = 0
    
    public weak var topSpaceView: UIView!
    public weak var bottomSpaceView: UIView!

    
    
    enum ScrollDirection: UInt32 {
        case up
        case down
    }
    
    
    
    let formater: DateFormatter = {
        let result = DateFormatter()
        result.dateFormat = "HH:mm:ss +SSS"
        return result
    }()
    
    
    
    private var lastScrollTime: CFTimeInterval = CACurrentMediaTime()
    private var contentOffsetChangedY: CGFloat = 0
    public private(set) var currentScrollRate: CGFloat = 0

    
    
    //换 有 header cell footer
    var cells: [MessageTableViewItemLayout] = []
    
    public private(set) weak var wrapperView: MessageTableViewWrapperView!
    public private(set) var wrapperViewShowFrame: CGRect {
        willSet(new) {
            print("<\(formater.string(from: Date())) wrapperViewShowFrame- willSet: \(wrapperViewShowFrame), new: \(new)")
            
            
        }
        didSet(old) {
            print("<\(formater.string(from: Date())) wrapperViewShowFrame- didSet: \(wrapperViewShowFrame), old: \(old)")
            
            var oldRect = wrapperViewShowFrame
            var oldOffsetY: CGFloat = 100
            if oldRect.origin.y < 100 {
                oldOffsetY = oldRect.origin.y;
            }
            oldRect.origin.y -= oldOffsetY
            oldRect.size.height += 100 + oldOffsetY
            
            var rect = wrapperViewShowFrame
            var offsetY: CGFloat = 100
            if rect.origin.y < 100 {
                offsetY = rect.origin.y;
            }
            rect.origin.y -= offsetY
            rect.size.height += 100 + offsetY

            
            if oldRect.origin.y < rect.origin.y {
                // up
            } else {
                while let item = self.cells.first {
                    if item.frame.origin.y + item.frame.height < rect.origin.y {
                        //remove call back
                        // do remove
                        self.cells.removeFirst()
                    } else {
                        break
                    }
                }
            }
            if oldRect.origin.y + oldRect.height < rect.origin.y + rect.height {
                // down
            } else {
                while let item = self.cells.last {
                    if item.frame.origin.y > rect.origin.y + rect.height {
                        //remove call back
                        // do remove
                        self.cells.removeLast()
                    } else {
                        break
                    }
                }
            }
            
            
            if oldRect.origin.y < rect.origin.y {
                // up
                
                
                
            }
            if oldRect.origin.y + oldRect.height < rect.origin.y + rect.height {
                // down
            }
            
            // do remove

            //do add
        }
    }
    
    private func resetContentShowFrame() {
        var rect = CGRect(x: 0, y: contentOffset.y, width: contentShowRect.width, height: contentShowRect.height)
        if #available(iOS 11.0, *) {
            var insets = UIEdgeInsets()
            insets = self.safeAreaInsets
            rect.origin.x -= insets.left
            rect.origin.y -= insets.top
            rect.size.height += (insets.top + insets.bottom)
        }
//        var offsetY: CGFloat = 100
//        if rect.origin.y < 100 {
//            offsetY = rect.origin.y;
//        }
//        rect.origin.y -= offsetY
//        rect.size.height += 100 + offsetY
        self.wrapperViewShowFrame = rect
    }

    
    open var contentShowRect: CGRect {
        willSet(new) {
            print("<\(formater.string(from: Date())) contentShowRect- willSet: \(contentShowRect), new: \(new)")

        }
        didSet(old) {
            print("<\(formater.string(from: Date())) contentShowRect- didSet: \(contentShowRect), old: \(old)")
            if old != contentShowRect {
                self.resetContentShowFrame()
            }
            //jisuan wrapperViewShowFrame
            
        }
    }
    open override var contentOffset: CGPoint {
        willSet(new) {
            let changed = new.y - contentOffset.y
            contentOffsetChangedY += changed
        }
        didSet(old) {
            print("<\(formater.string(from: Date())) contentOffset- didSet: \(contentOffset), old: \(old), ychange: \(contentOffset.y - old.y)  currentScrollRate: \(self.currentScrollRate)>, lastWaitTime: \(RunLoopManager.manager.lastFrameWaitingScale)")
            if old != contentOffset {
                resetContentShowFrame()
            }
        }
    }
    
    open override var contentSize: CGSize {
        didSet(old) {
            if old != contentSize {
                self.wrapperView.frame.size = CGSize(width: self.contentShowRect.width, height: contentSize.height)
                self.resetContentShowFrame()
            }
        }
    }

    private func resetContentShowRect() {
        
        var rect = CGRect(x: 0, y: 0, width: self.frame.width - contentOffset.x, height: self.frame.height)
        
        var insets = UIEdgeInsets()
        if #available(iOS 11.0, *) {
            insets = self.safeAreaInsets
        }
        rect.origin.x += insets.left
        rect.origin.y += insets.top
        rect.size.width -= (insets.left + insets.right)
        rect.size.height -= (insets.top + insets.bottom)

        self.contentShowRect = rect
    }
    
    open override var contentInset: UIEdgeInsets {
        didSet(old) {
            print("<\(formater.string(from: Date())) contentInset- didSet: \(contentInset), old: \(old)")

            self.wrapperView.frame.size = CGSize(width: self.frame.width, height: contentSize.height)
        }
    }
    
//    func aa(){
//        if #available(iOS 11.0, *) {
//            self.contentInsetAdjustmentBehavior = .scrollableAxes
//        } else {
//            // Fallback on earlier versions
//        }
//    }
    open override func safeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            self.resetContentShowRect()
            
            print("safeAreaInsetsDidChange safeAreaInsets: \(self.safeAreaInsets) adjustedContentInset: \(self.adjustedContentInset) bounds: \(self.bounds) \n【safeAreaLayoutGuide\(self.safeAreaLayoutGuide)】\n【contentLayoutGuide:  \(self.contentLayoutGuide)】 ")
            super.safeAreaInsetsDidChange()
        }
    }

    
    open override var frame: CGRect {
        didSet(old) {
            print("<\(formater.string(from: Date())) frame- didSet: \(frame), old: \(old)")
            self.wrapperView.frame.size = CGSize(width: self.frame.width, height: contentSize.height)
            resetContentShowFrame()
        }
    }
    
    open override var bounds: CGRect {
        didSet(old) {
            print("<\(formater.string(from: Date())) bounds- didSet: \(bounds), old: \(old)")
        }
    }

    
    open override func willMove(toWindow newWindow: UIWindow?) {
        if let _ = newWindow {
            self.contentOffsetChangedY = 0
            self.startListenDisplayLink()
        } else {
            self.stopListenDisplayLink()
        }
        super.willMove(toWindow: newWindow)
    }
    
    private func startListenDisplayLink() {
        RunLoopManager.manager.addDisplayLinkListener(self, context: messageTableViewContext) {(linkInfo) in
            self.currentScrollRate = CGFloat( self.contentOffsetChangedY )
            self.contentOffsetChangedY = 0
        }
    }
    private func stopListenDisplayLink() {
        RunLoopManager.manager.removeDisplayLinkListener(self, context: messageTableViewContext)
    }
    
    public override init(frame: CGRect) {
        self.contentShowRect = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        self.wrapperViewShowFrame = CGRect(x: 0, y: 0, width: frame.width, height: 0)
        let wrapperView = MessageTableViewWrapperView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: frame.size))
        self.wrapperView = wrapperView
        super.init(frame: frame)

        //UIScrollViewDecelerationRateNormal 0.998， UIScrollViewDecelerationRateFast 0.99， UIScrollView 默认 UIScrollViewDecelerationRateNormal, UITableView 默认 UIScrollViewDecelerationRateNormal
//        print(" self \(self.decelerationRate)")
//        self.decelerationRate = UIScrollViewDecelerationRateFast
        

        self.addSubview(wrapperView)

        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .scrollableAxes
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        self.contentShowRect = CGRect()
        self.wrapperViewShowFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let wrapperView = MessageTableViewWrapperView(frame: CGRect())
        self.wrapperView = wrapperView
        super.init(coder: aDecoder)
        wrapperView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 0)
        self.contentShowRect = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        self.wrapperViewShowFrame = CGRect(x: 0, y: 0, width: frame.width, height: 0)

        self.addSubview(wrapperView)
    }
    
    open func reloadData() {
        self.reloadData2()
    }
    
    open func reloadData2() {
        
        
        
        var y: CGFloat = 0
        if let dataSource = self.dataSource, let delegate = self.tableViewDelegate {
            let sectionCount = dataSource.numberOfSections(in: self)
            
            let width = self.frame.size.width
            if let _ = self.tableHeaderView {
                y += self.self.tableHeaderViewHeight
            }
            
            var sections = self.sections
            
            if sections.count < sectionCount {
                while sections.count < sectionCount {
                    sections.append(Section(index: sections.count))
                }
            } else if sections.count > sectionCount {
                sections.removeLast(sections.count - sectionCount)
            }
            
            self.sections = sections
            for section in self.sections {
                let sectionBeginY = y
                
                let itemCount = dataSource.tableView(self, numberOfRowsInSection: section.index)
                if dataSource.tableView(self, hasHeaderInSection: section.index) {
                    section.hasHeader = true
                    section.headerFrame = CGRect(x: 0, y: y, width: width, height: delegate.tableView(self, heightForHeaderInSection: section.index))
                } else {
                    section.hasHeader = false
                    section.headerFrame = CGRect(x: 0, y: y, width: width, height: 0)
                }
                y += section.headerFrame.size.height
                
                var items = section.items
                if items.count > itemCount {
                    sections.removeLast(sections.count - sectionCount)
                }
                for (index, item) in items.enumerated() {
                    let path = IndexPath(row: index, section:section.index)
                    let rowHeight = delegate.tableView(self, heightForRowAt: path)
                    item.frame = CGRect(x: 0, y: y, width: width, height: rowHeight)
                    y += rowHeight
                }
                if items.count < itemCount {
                    while items.count < itemCount {
                        let path = IndexPath(row: items.count, section:section.index)
                        let rowHeight = delegate.tableView(self, heightForRowAt: path)
                        items.append(MessageTableViewItemLayout(frame: CGRect(x: 0, y: y, width: width, height: rowHeight), indexPath: path))
                        y += rowHeight
                    }
                }
                
                if dataSource.tableView(self, hasFooterInSection: section.index) {
                    section.hasFooter = true
                    section.footerFrame = CGRect(x: 0, y: y, width: width, height: delegate.tableView(self, heightForFooterInSection: section.index))
                } else {
                    section.hasFooter = false
                    section.footerFrame = CGRect(x: 0, y: y, width: width, height: 0)
                }
                y += section.footerFrame.size.height

                section.sectionRect = CGRect(x: 0, y: sectionBeginY, width: width, height: y - sectionBeginY)
                section.items = items
            }
        }
        self.contentSize = CGSize(width: 0, height: y)
    }
    
    open private(set) var numberOfSections: Int = 0
    
    open func numberOfRows(inSection section: Int) -> Int {
        return 0
    }
    
    
//    open func register(_ nib: UINib?, forCellReuseIdentifier identifier: String)
//
//    @available(iOS 6.0, *)
//    open func register(_ cellClass: Swift.AnyClass?, forCellReuseIdentifier identifier: String)
    
//    open func rect(forSection section: Int) -> CGRect // includes header, footer and all rows
//
//    open func rectForHeader(inSection section: Int) -> CGRect
//
//    open func rectForFooter(inSection section: Int) -> CGRect
//
//    open func rectForRow(at indexPath: IndexPath) -> CGRect
//
//
//    open func indexPathForRow(at point: CGPoint) -> IndexPath? // returns nil if point is outside of any row in the table
//
//    open func indexPath(for cell: UITableViewCell) -> IndexPath? // returns nil if cell is not visible
//
//    open func indexPathsForRows(in rect: CGRect) -> [IndexPath]? // returns nil if rect not valid
//
//
//    open func cellForRow(at indexPath: IndexPath) -> UITableViewCell? // returns nil if cell is not visible or index path is out of range
//
//    open var visibleCells: [UITableViewCell] { get }
//
//    open var indexPathsForVisibleRows: [IndexPath]? { get }
//    @available(iOS 6.0, *)
//    open func headerView(forSection section: Int) -> UITableViewHeaderFooterView?
//
//    @available(iOS 6.0, *)
//    open func footerView(forSection section: Int) -> UITableViewHeaderFooterView?
//
//
//    open func scrollToRow(at indexPath: IndexPath, at scrollPosition: UITableViewScrollPosition, animated: Bool)
//    open func beginUpdates()
//
//    open func endUpdates()
//
//
//    open func insertSections(_ sections: IndexSet, with animation: UITableViewRowAnimation)
//
//    open func deleteSections(_ sections: IndexSet, with animation: UITableViewRowAnimation)
//
//    @available(iOS 3.0, *)
//    open func reloadSections(_ sections: IndexSet, with animation: UITableViewRowAnimation)
//
//    @available(iOS 5.0, *)
//    open func moveSection(_ section: Int, toSection newSection: Int)
//
//
//    open func insertRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation)
//
//    open func deleteRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation)
//
//    @available(iOS 3.0, *)
//    open func reloadRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation)
//
//    @available(iOS 5.0, *)
//    open func moveRow(at indexPath: IndexPath, to newIndexPath: IndexPath)
    
    deinit {
        RunLoopManager.manager.removeDisplayLinkListener(self, context: messageTableViewContext)
    }
    
}



