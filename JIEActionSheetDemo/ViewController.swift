//
//  ViewController.swift
//  JIEActionSheetDemo
//
//  Created by Lijie on 15/9/12.
//  Copyright (c) 2015年 HuatengIOT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showActionSheet(sender: AnyObject) {
        
        var sheet = UIActionSheet().actionSheet("t", cancelTitle: "c", destructiveTitle: "d", otherButtonTitles: ["a","b"]) { (shee, index) -> Void in
            println(index)
        }
        
        sheet.willDismissBlock = { (actionSheet, index) -> Void in
            println("willDismissBlock")
        }
        sheet.didDismissBlock = { (actionSheet, index) -> Void in
            println("didDismissBlock")
        }
        sheet.willPresentBlock = { (actionSheet) -> Void in
            println("willPresentBlock")
        }
        sheet.didPresentBlock = { (actionSheet) -> Void in
            println("didPresentBlock")
        }
        sheet.cancelBlock = { (actionSheet) -> Void in
            println("cancelBlock")
        }
        
        sheet.showInCanvas(view)
    }

}

