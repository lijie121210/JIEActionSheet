# JIEActionSheet
An simple extension of UIActionSheet, written in Swift. So that it can use closure grammar.

All of the proxy events, can be completed in their respective callback, in addition to `actionSheetCancel: `. Please teach me if you know why.

## Requirements

ARC. Swift

## Usage

Find  `JIEActionSheet.swift`  in the JIEActionSheetDemo.
Add it into your project.
Then, you can do whatever you want.

You can do like this:

```objc
        var sheet = UIActionSheet().actionSheet("t", cancelTitle: "c", destructiveTitle: "d", otherButtonTitles: ["a","b"])
            { (shee, index) -> Void in
                
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
```


## Acknowledgement:

Thanks ryanmaxwell : https://github.com/ryanmaxwell/UIActionSheet-Blocks


And I am still a student, please pull requests for any optimizing and issues.
