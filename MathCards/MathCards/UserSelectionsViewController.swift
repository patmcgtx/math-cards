//
//  SetupViewController.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/10/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit

//
// This controller lets the user select which kinds of math
// questions she wants to see.
//
class UserSelectionsViewController: UITableViewController {

    // MARK: Outlets
    
    @IBOutlet weak var firstNumberMinTextField: NumericTextField!
    @IBOutlet weak var firstNumberMaxTextField: NumericTextField!
    @IBOutlet weak var secondNumberMinTextField: NumericTextField!
    @IBOutlet weak var secondNumberMaxTextField: NumericTextField!
    
    @IBOutlet weak var numCardsTextField: PositiveNumericTextField!
    @IBOutlet weak var numMinutesTextField: PositiveNumericTextField!
    
    @IBOutlet weak var additionButton: ToggleButton!
    @IBOutlet weak var subtractionButton: ToggleButton!
    @IBOutlet weak var multiplicationButton: ToggleButton!
    @IBOutlet weak var divisionButton: ToggleButton!
    @IBOutlet weak var unlockMathOpsButton: UIButton!
        
    @IBOutlet weak var mathOpsLabel: UILabel!
    
    @IBOutlet weak var startButton: UIButton!
    
    
    // MARK: Public properties
    
    var userSelections = UserSelections()
    var numericTextFieldDelegate: UserSelectionsTextFieldDelegate?
    
    
    // MARK: Lifecycle
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Load saved user selections
        
        self.userSelections = PersistentUserSelections.sharedInstance.load()
        
        // Set up the text field delegates
        
        self.numericTextFieldDelegate = UserSelectionsTextFieldDelegate(userSelections: self.userSelections)
        
        self.firstNumberMinTextField.delegate = self.numericTextFieldDelegate
        self.firstNumberMaxTextField.delegate = self.numericTextFieldDelegate
        
        self.secondNumberMinTextField.delegate = self.numericTextFieldDelegate
        self.secondNumberMaxTextField.delegate = self.numericTextFieldDelegate
        
        self.numMinutesTextField.delegate = self.numericTextFieldDelegate
        self.numCardsTextField.delegate = self.numericTextFieldDelegate
        
        // Notifications
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UserSelectionsViewController.needMathOps), name: notificationMathOpsEmpty, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UserSelectionsViewController.haveMathOps), name: notificationMathOpsNotEmpty, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UserSelectionsViewController.saveUserSelections), name: notificationAppGoingToBackground, object: nil)
        
        // Text input validation rules
        
        self.firstNumberMinTextField.ceilingTextField = self.firstNumberMaxTextField
        self.firstNumberMinTextField.maxNumDigits = 3
        self.firstNumberMinTextField.allowsEmptyValue = false
        
        self.firstNumberMaxTextField.floorTextField = self.firstNumberMinTextField
        self.firstNumberMaxTextField.maxNumDigits = 3
        self.firstNumberMaxTextField.allowsEmptyValue = false
        
        self.secondNumberMinTextField.ceilingTextField = self.secondNumberMaxTextField
        self.secondNumberMinTextField.maxNumDigits = 3
        self.secondNumberMinTextField.allowsEmptyValue = false
        
        self.secondNumberMaxTextField.floorTextField = self.secondNumberMinTextField
        self.secondNumberMaxTextField.maxNumDigits = 3
        self.secondNumberMaxTextField.allowsEmptyValue = false
        
        self.numCardsTextField.maxNumDigits = 2
        self.numCardsTextField.allowsEmptyValue = true
        self.numCardsTextField.floorValue = 0
        
        self.numMinutesTextField.maxNumDigits = 2
        self.numMinutesTextField.allowsEmptyValue = true
        self.numMinutesTextField.floorValue = 0
        
        // Pre-select math operators
        
        self.additionButton.activated = self.userSelections.mathOperations.contains(MathOperation.Addition)
        self.subtractionButton.activated = self.userSelections.mathOperations.contains(MathOperation.Subtraction)
        self.multiplicationButton.activated = self.userSelections.mathOperations.contains(MathOperation.Multiplication)
        self.divisionButton.activated = self.userSelections.mathOperations.contains(MathOperation.Division)
        
        if self.userSelections.mathOperations.isEmpty {
            self.needMathOps()
        }
        
        // Pre-populate other user options
        
        self.firstNumberMinTextField.intValue = self.userSelections.firstNumberMin
        self.firstNumberMaxTextField.intValue = self.userSelections.firstNumberMax
        self.secondNumberMinTextField.intValue = self.userSelections.secondNumberMin
        self.secondNumberMaxTextField.intValue = self.userSelections.secondNumberMax
        self.numCardsTextField.intValue = self.userSelections.cardLimit
        self.numMinutesTextField.intValue = self.userSelections.minuteLimit

        //
        // Handle freemium restrictions
        //
        
        /*
        if InAppPurchaseHelper.sharedInstance.areAllMathEndingsPurchased {
            self.unlockMathOpsButton.hidden = true
        }
        else {
            self.additionButton.enabled = false
            self.subtractionButton.enabled = false
            self.multiplicationButton.enabled = false
            self.divisionButton.enabled = false
        }
*/
        
        // Display the background image
        
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "bg0"))
        self.tableView.backgroundView?.contentMode = UIViewContentMode.ScaleAspectFill
        
        // Stylize the start button
        
        self.startButton.layer.borderColor = UIColor.blackColor().CGColor
        self.startButton.layer.cornerRadius = 5
        self.startButton.layer.borderWidth = 2.0
        self.startButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.startButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Disabled)
        
        // Hide the keyboard as applicable
        
        self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.Interactive
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(UserSelectionsViewController.hideKeyboard))
        self.view.addGestureRecognizer(tapRecognizer)
        
        //self.tableView.backgroundView = nil
        //self.tableView.backgroundColor = UIColor.clearColor()
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        self.saveUserSelections()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: Actions
    
    @IBAction func toggleAddition(sender: ToggleButton) {
        self.userSelections.mathOperation(.Addition, shouldBeIncluded:sender.toggle())
    }
    
    
    @IBAction func toggleSubtraction(sender: ToggleButton) {
        self.userSelections.mathOperation(.Subtraction, shouldBeIncluded:sender.toggle())
    }
    
    
    @IBAction func toggleMultiplication(sender: ToggleButton) {
        self.userSelections.mathOperation(.Multiplication, shouldBeIncluded:sender.toggle())
    }
    
    
    @IBAction func toggleDivision(sender: ToggleButton) {
        self.userSelections.mathOperation(.Division, shouldBeIncluded:sender.toggle())
    }

    
    // MARK: Table view delagate
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
        forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = UIColor.clearColor()
    }
    
    
    // MARK: Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "userSelectionsToShowCards") {
            let destController = segue.destinationViewController as! RunCardsViewController
            destController.userSelectons = self.userSelections
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        var retval = true
        
        if (identifier == "userSelectionsToShowCards") {
            // Prevent advancing if no math operations are selected
            // TODO: Show a message about why you can't start up yet
            retval = !self.userSelections.mathOperations.isEmpty
        }
        
        return retval
    }

    
    // MARK: Internal helpers
    
    func hideKeyboard() {
        self.view.endEditing(false)
    }
    
    
    func haveMathOps() {
        self.startButton.enabled = true
        self.startButton.layer.borderColor = UIColor.blackColor().CGColor
        self.mathOpsLabel.textColor = UIColor.blackColor()
    }
        

    func needMathOps() {
        self.startButton.enabled = false
        self.startButton.layer.borderColor = UIColor.grayColor().CGColor
        self.mathOpsLabel.textColor = UIColor.redColor()
    }
    
    func saveUserSelections() {
        PersistentUserSelections.sharedInstance.save(self.userSelections)
    }
    
}
