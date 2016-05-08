//
//  AboutViewController.swift
//  MathCards
//
//  Created by Patrick McGonigle on 11/15/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit

class AboutViewController : UITableViewController {

    private var appVersion: String = ""
    private var lastSelectedCell: UITableViewCell?
    private let tableCellTagToURL = [
        101: "https://itunes.apple.com/us/app/continuous-math-cards/id932437763?ls=1&mt=8",
        102: "http://www.roundtripsoftware.com",
        111: "http://www.roundtripsoftware.com/help/mathcards/",
        112: "support@roundtripsoftware.com",
        121: "https://twitter.com/roundtripsw",
        122: "https://www.facebook.com/roundtripsw"
    ]
    
    @IBOutlet weak var appNameCell: UITableViewCell!
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {

        let shortVersion = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
        self.appNameCell.textLabel!.text = "\(appName) v\(shortVersion)"

    }
    
    
    // MARK: Actions
    
    @IBAction func done(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: Table view stuff
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, canPerformAction action: Selector, forRowAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        
        //return true
        return action == #selector(NSObject.copy(_:))
        
    }
    
    override func tableView(tableView: UITableView, shouldShowMenuForRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.lastSelectedCell = tableView.cellForRowAtIndexPath(indexPath)
        
        if tableView.canPerformAction(#selector(NSObject.copy(_:)), withSender: nil) {
            self.becomeFirstResponder()
            let theMenu = UIMenuController.sharedMenuController()
            theMenu.setTargetRect(self.lastSelectedCell!.frame, inView: self.view)
            theMenu.setMenuVisible(true, animated: true)
        }
        
    }
    
    override func copy(sender: AnyObject?) {
        
        if let tag = self.lastSelectedCell?.tag {
            if let urlToCopyToClipboard = self.tableCellTagToURL[tag] {
                let pasteboard = UIPasteboard.generalPasteboard()
                pasteboard.string = urlToCopyToClipboard as String
            }
        }
    }
    
}
