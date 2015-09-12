//
//  JIEActionSheet.swift
//  JIEActionSheetDemo
//
//  Created by Lijie on 15/9/12.
//  Copyright (c) 2015年 HuatengIOT. All rights reserved.
//

import UIKit

extension UIActionSheet: UIActionSheetDelegate {
    
    private struct Sheet {
        static var sheet: UIActionSheet?
        init(_ sheet: UIActionSheet?) {
            Sheet.sheet = sheet
        }
    }
    // 添加的方法
    
    internal func actionSheet(title: String?, cancelTitle: String?, destructiveTitle: String?, actionBlock: ((UIActionSheet, Int) -> Void)?) -> UIActionSheet {
        
        var sheet = UIActionSheet(title: title, delegate: nil, cancelButtonTitle: cancelTitle, destructiveButtonTitle: destructiveTitle)
        
        Sheet(sheet)
        
        Sheet.sheet!.delegate = ActionSheetDelegateHandler.shareActionSheetDelegateHandler()
        
        if let block = actionBlock { self.actionBlock = block }
        
        return Sheet.sheet!
    }
    
    internal func actionSheet(title: String?, cancelTitle: String?, destructiveTitle: String?, otherButtonTitles:[String]?, actionBlock: ((UIActionSheet, Int) -> Void)?) -> UIActionSheet {
        
        var sheet = UIActionSheet(title: title, delegate: nil, cancelButtonTitle: cancelTitle, destructiveButtonTitle: destructiveTitle)
        
        if let titles = otherButtonTitles {
            for tit in titles {
                sheet.addButtonWithTitle(tit)
            }
        }
        
        Sheet(sheet)
        
        Sheet.sheet!.delegate = ActionSheetDelegateHandler.shareActionSheetDelegateHandler()
        
        if let block = actionBlock { self.actionBlock = block }
        
        return Sheet.sheet!
    }
    internal func showInCanvas(canvas:AnyObject!) {
        if let view: AnyObject = canvas {
            
            if view.isKindOfClass(UIToolbar.self) {
                Sheet.sheet!.showFromToolbar(view as! UIToolbar)
            }
            
            if view.isKindOfClass(UIBarButtonItem.self) {
                Sheet.sheet!.showFromBarButtonItem(view as! UIBarButtonItem, animated: true)
            }
            
            if view.isKindOfClass(UITabBar.self) {
                Sheet.sheet!.showFromTabBar(view as! UITabBar)
            }
            
            if view.isKindOfClass(UIView.self) {
                Sheet.sheet!.showInView(view as! UIView)
            }
        }
    }
    
    // MARK: - Properties and Methon
    
    var actionBlock: ((UIActionSheet, Int) -> Void)? {
        get {
            return ActionSheetDelegateHandler.shareActionSheetDelegateHandler().actionClosure
        }
        set {
            ActionSheetDelegateHandler.shareActionSheetDelegateHandler().actionClosure = newValue
        }
    }
    var willDismissBlock: ((UIActionSheet, Int) -> Void)? {
        get {
            return ActionSheetDelegateHandler.shareActionSheetDelegateHandler().willDismissClosure
        }
        set {
            ActionSheetDelegateHandler.shareActionSheetDelegateHandler().willDismissClosure = newValue
        }
    }
    var didDismissBlock: ((UIActionSheet, Int) -> Void)? {
        get {
            return ActionSheetDelegateHandler.shareActionSheetDelegateHandler().didDismissClosure
        }
        set {
            ActionSheetDelegateHandler.shareActionSheetDelegateHandler().didDismissClosure = newValue
        }
    }
    var willPresentBlock: ((UIActionSheet) -> Void)? {
        get {
            return ActionSheetDelegateHandler.shareActionSheetDelegateHandler().willPresentClosure
        }
        set {
            ActionSheetDelegateHandler.shareActionSheetDelegateHandler().willPresentClosure = newValue
        }
    }
    var didPresentBlock: ((UIActionSheet) -> Void)? {
        get {
            return ActionSheetDelegateHandler.shareActionSheetDelegateHandler().didPresentClosure
        }
        set {
            ActionSheetDelegateHandler.shareActionSheetDelegateHandler().didPresentClosure = newValue
        }
    }
    var cancelBlock: ((UIActionSheet) -> Void)? {
        get {
            return ActionSheetDelegateHandler.shareActionSheetDelegateHandler().cancelClosure
        }
        set {
            ActionSheetDelegateHandler.shareActionSheetDelegateHandler().cancelClosure = newValue
        }
    }
}

class ActionSheetDelegateHandler: NSObject, UIActionSheetDelegate {
    
    // MARK: - Single instance
    
    class func shareActionSheetDelegateHandler() -> ActionSheetDelegateHandler{
        struct Singleton{
            static var predicate:dispatch_once_t = 0
            static var instance:ActionSheetDelegateHandler? = nil
        }
        dispatch_once(&Singleton.predicate,{
            Singleton.instance = ActionSheetDelegateHandler()
            }
        )
        return Singleton.instance!
    }
    
    var actionClosure: ((UIActionSheet, Int) -> Void)?
    var willDismissClosure: ((UIActionSheet, Int) -> Void)?
    var didDismissClosure: ((UIActionSheet, Int) -> Void)?
    var cancelClosure: ((UIActionSheet) -> Void)?
    var willPresentClosure: ((UIActionSheet) -> Void)?
    var didPresentClosure: ((UIActionSheet) -> Void)?
    
    
    // MARK: - action Sheet Delegate
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if let closure = self.actionClosure {
            closure(actionSheet, buttonIndex)
        }
    }
    
    func willPresentActionSheet(actionSheet: UIActionSheet) {
        if let closure = self.willPresentClosure {
            closure(actionSheet)
        }
    }
    func didPresentActionSheet(actionSheet: UIActionSheet) {
        if let closure = self.didPresentClosure {
            closure(actionSheet)
        }
    }
    func actionSheet(actionSheet: UIActionSheet, willDismissWithButtonIndex buttonIndex: Int) {
        if let closure = self.willDismissClosure {
            closure(actionSheet, buttonIndex)
        }
    }
    func actionSheet(actionSheet: UIActionSheet, didDismissWithButtonIndex buttonIndex: Int) {
        if let closure = self.didDismissClosure {
            closure(actionSheet, buttonIndex)
        }
    }
    func actionSheetCancel(actionSheet: UIActionSheet) {
        if let closure = self.cancelClosure {
            closure(actionSheet)
        }
    }
}