//
//  AboutViewController.swift
//  MathCards
//
//  Created by Patrick McGonigle on 11/15/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit

class AboutViewController : UITableViewController {

    fileprivate var appVersion: String = ""
    fileprivate var lastSelectedCell: UITableViewCell?
    fileprivate let tableCellTagToURL = [
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

        let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let buildNum = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        self.appNameCell.textLabel!.text = "\(appName) v\(appVersion) #\(buildNum)"

    }
    
    
    // MARK: Actions
    
    @IBAction func done(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Table view stuff
    
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        
        //return true
        return action == #selector(copy(_:))
        
    }
    
    override func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.lastSelectedCell = tableView.cellForRow(at: indexPath)
        
        if tableView.canPerformAction(#selector(copy(_:)), withSender: nil) {
            self.becomeFirstResponder()
            let theMenu = UIMenuController.shared
            theMenu.setTargetRect(self.lastSelectedCell!.frame, in: self.view)
            theMenu.setMenuVisible(true, animated: true)
        }
        
    }
    
    override func copy(_ sender: Any?) {
        
        if let tag = self.lastSelectedCell?.tag {
            if let urlToCopyToClipboard = self.tableCellTagToURL[tag] {
                let pasteboard = UIPasteboard.general
                pasteboard.string = urlToCopyToClipboard as String
            }
        }
    }
    
}
