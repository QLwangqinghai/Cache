//
//  AppDelegate.swift
//  MyTableView
//
//  Created by wangqinghai on 2018/5/25.
//  Copyright © 2018年 wangqinghai. All rights reserved.
//

import UIKit

public protocol UIScrollViewDelegate : NSObjectProtocol {
    
    
    @available(iOS 2.0, *)
    optional public func scrollViewDidScroll(_ scrollView: UIScrollView) // any offset changes
    
    @available(iOS 3.2, *)
    optional public func scrollViewDidZoom(_ scrollView: UIScrollView) // any zoom scale changes
    
    
    // called on start of dragging (may require some time and or distance to move)
    @available(iOS 2.0, *)
    optional public func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    
    // called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest
    @available(iOS 5.0, *)
    optional public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    
    // called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
    @available(iOS 2.0, *)
    optional public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    
    
    @available(iOS 2.0, *)
    optional public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) // called on finger up as we are moving
    
    @available(iOS 2.0, *)
    optional public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) // called when scroll view grinds to a halt
    
    
    @available(iOS 2.0, *)
    optional public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) // called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
    
    
    @available(iOS 2.0, *)
    optional public func viewForZooming(in scrollView: UIScrollView) -> UIView? // return a view that will be scaled. if delegate returns nil, nothing happens
    
    @available(iOS 3.2, *)
    optional public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) // called before the scroll view begins zooming its content
    
    @available(iOS 2.0, *)
    optional public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) // scale between minimum and maximum. called after any 'bounce' animations
    
    
    @available(iOS 2.0, *)
    optional public func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool // return a yes if you want to scroll to the top. if not defined, assumes YES
    
    @available(iOS 2.0, *)
    optional public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) // called when scrolling animation finished. may be called immediately if already at top
    
    
    /* Also see -[UIScrollView adjustedContentInsetDidChange]
     */
    @available(iOS 11.0, *)
    optional public func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView)
}


public protocol UITableViewDataSource : NSObjectProtocol {
    
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
    
    @available(iOS 2.0, *)
    optional public func numberOfSections(in tableView: UITableView) -> Int // Default is 1 if not implemented
    
    
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? // fixed font style. use custom view (UILabel) if you want something different
    
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
    
    
    // Editing
    
    // Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    
    
    // Moving/reordering
    
    // Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    
    
    // Index
    
    @available(iOS 2.0, *)
    optional public func sectionIndexTitles(for tableView: UITableView) -> [String]? // return list of section titles to display in section index view (e.g. "ABCD...Z#")
    
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int // tell table which section corresponds to section title/index (e.g. "B",1))
    
    
    // Data manipulation - insert and delete support
    
    // After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
    // Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    
    
    // Data manipulation - reorder / moving support
    
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
}

public protocol UITableViewDelegate : UIScrollViewDelegate {
    
    
    // Display customization
    
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    
    @available(iOS 6.0, *)
    optional public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    
    @available(iOS 6.0, *)
    optional public func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int)
    
    @available(iOS 6.0, *)
    optional public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
    
    @available(iOS 6.0, *)
    optional public func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int)
    
    @available(iOS 6.0, *)
    optional public func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int)
    
    
    // Variable height support
    
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    
    
    // Use the estimatedHeight methods to quickly calcuate guessed values which will allow for fast load times of the table.
    // If these methods are implemented, the above -tableView:heightForXXX calls will be deferred until views are ready to be displayed, so more expensive logic can be placed there.
    @available(iOS 7.0, *)
    optional public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    
    @available(iOS 7.0, *)
    optional public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat
    
    @available(iOS 7.0, *)
    optional public func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat
    
    
    // Section header & footer information. Views are preferred over title should you decide to provide both
    
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? // custom view for header. will be adjusted to default or specified header height
    
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? // custom view for footer. will be adjusted to default or specified footer height
    
    
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath)
    
    
    // Selection
    
    // -tableView:shouldHighlightRowAtIndexPath: is called when a touch comes down on a row.
    // Returning NO to that message halts the selection process and does not cause the currently selected row to lose its selected look while the touch is down.
    @available(iOS 6.0, *)
    optional public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
    
    @available(iOS 6.0, *)
    optional public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath)
    
    @available(iOS 6.0, *)
    optional public func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath)
    
    
    // Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
    
    @available(iOS 3.0, *)
    optional public func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath?
    
    // Called after the user changes the selection.
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    
    @available(iOS 3.0, *)
    optional public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    
    
    // Editing
    
    // Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle
    
    @available(iOS 3.0, *)
    optional public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
    
    
    // Use -tableView:trailingSwipeActionsConfigurationForRowAtIndexPath: instead of this method, which will be deprecated in a future release.
    // This method supersedes -tableView:titleForDeleteConfirmationButtonForRowAtIndexPath: if return value is non-nil
    @available(iOS 8.0, *)
    optional public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    
    
    // Swipe actions
    // These methods supersede -editActionsForRowAtIndexPath: if implemented
    // return nil to get the default swipe actions
    @available(iOS 11.0, *)
    optional public func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    
    @available(iOS 11.0, *)
    optional public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    
    
    // Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool
    
    
    // The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath)
    
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?)
    
    
    // Moving/reordering
    
    // Allows customization of the target row for a particular row as it is being moved/reordered
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath
    
    
    // Indentation
    
    @available(iOS 2.0, *)
    optional public func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int // return 'depth' of row for hierarchies
    
    
    // Copy/Paste.  All three methods must be implemented by the delegate.
    
    @available(iOS 5.0, *)
    optional public func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool
    
    @available(iOS 5.0, *)
    optional public func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool
    
    @available(iOS 5.0, *)
    optional public func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?)
    
    
    // Focus
    
    @available(iOS 9.0, *)
    optional public func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool
    
    @available(iOS 9.0, *)
    optional public func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool
    
    @available(iOS 9.0, *)
    optional public func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator)
    
    @available(iOS 9.0, *)
    optional public func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath?
    
    
    // Spring Loading
    
    // Allows opting-out of spring loading for an particular row.
    // If you want the interaction effect on a different subview of the spring loaded cell, modify the context.targetView property. The default is the cell.
    // If this method is not implemented, the default is YES except when the row is part of a drag session.
    @available(iOS 11.0, *)
    optional public func tableView(_ tableView: UITableView, shouldSpringLoadRowAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool
}
