//
//  RunCardsViewController.swift
//  MathCards
//
//  Created by Patrick McGonigle on 10/11/14.
//  Copyright (c) 2014 Round Trip Software. All rights reserved.
//

import UIKit

//
// This controller shows a series of math questions and presents a report at the end
//
class RunCardsViewController : UIViewController, CountdownDelegate, UpCounterDelegate, UITextFieldDelegate {

    // MARK: Outlets
    
    @IBOutlet weak var upperNumLabel: UILabel!
    @IBOutlet weak var lowerNumLabel: UILabel!
    @IBOutlet weak var answerField: HiddenCursorNumericTextField!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var answerCorrectImage: UIImageView!
    @IBOutlet weak var cardCount: UpCounter!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var timer: CountdownTimer!
    @IBOutlet weak var resultsView: UIView!
    @IBOutlet weak var resultTotalsLabel: UILabel!
    @IBOutlet weak var resultPercentageLabel: UILabel!
    @IBOutlet weak var resultTotalTimeLabel: UILabel!
    @IBOutlet weak var resultAverageTimeLabel: UILabel!
    
    
    // MARK: Private properties
    
    private let secsToShowAnswerFeedback = 1.0
    
    private var firstMin: Int = 1
    private var firstMax: Int = 1
    private var secondMin: Int = 1
    private var secondMax: Int = 1
    
    private var currentQuestion: MathQuestion!
    private var numAnswered: Int = 0
    private var numCorrect: Int = 0
    
    private var runCardsDelegate : RunCardsTextFieldDelegate?
    
    //private let answerTextFieldDelegate: MathAnswerTextFieldDelegate = MathAnswerTextFieldDelegate()

    
    // MARK: Public properties

    weak var userSelectons: UserSelections?
    var answerColor: UIColor = UIColor.blackColor()
    var answerCorrectionColor: UIColor = UIColor.redColor()
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        
        if let userFirstMin = self.userSelectons?.firstNumberMin {
            if let userFirstMax = self.userSelectons?.firstNumberMax {
                self.firstMin = userFirstMin
                self.firstMax = userFirstMax
            }
        }

        if let userSecondMin = self.userSelectons?.secondNumberMin {
            if let userSecondMax = self.userSelectons?.secondNumberMax {
                self.secondMin = userSecondMin
                self.secondMax = userSecondMax
            }
        }

        self.timer.delegate = self
        self.cardCount.delegate = self
        
        self.timer.hidden = true
        self.stopButton.hidden = false
        
        // Stylize some visuals
        
        self.cardView.layer.cornerRadius = 5
        self.cardView.layer.borderColor = UIColor.blackColor().CGColor
        self.cardView.layer.borderWidth = 2.0

        self.backgroundImage.image = UIImage(named: "bg\(Int.random(1...3))")
        self.answerColor = self.answerField.textColor!
        
        self.answerField.maxNumDigits = 6
        self.answerField.delegate = self
        
        self.runCardsDelegate = RunCardsTextFieldDelegate(runCardsVC: self)
        self.answerField.delegate = self.runCardsDelegate
    }
    
    
    override func viewWillAppear(animated: Bool) {

        self.answerField.becomeFirstResponder()

        self.generateRandomMathProblem()
        
        self.cardCount.reset(self.userSelectons?.cardLimit)
        
        if let timeLimit = self.userSelectons?.minuteLimit {
            if ( timeLimit > 0 ) {
                // Use the user-selected time limit if applicable
                self.timer.hidden = false
                self.timer.setCountdown(minutes: timeLimit)
            }
            else {
                // Otherwise, hide the timer but silently treack the time
                // anyways for reporting.
                self.timer.hidden = true
                self.timer.setCountdown(minutes: 1000) // Just a really long time
            }
        }
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        
        // Reset the data in case this view is reused
        self.numAnswered = 0
        self.numCorrect = 0
        self.firstMin = 1
        self.firstMax = 1
        self.secondMin = 1
        self.secondMax = 1
        self.userSelectons = nil
        
        // Reset the view too where applicable
        self.timer.hidden = true
        self.stopButton.hidden = false
        
        // Just in case this is still going
        self.timer.stop()
    }
    
    
    // MARK: Internal
    
    func generateRandomMathProblem() {
        
        self.currentQuestion = MathQuestion.generateRandom(firstNumMin: self.firstMin, firstNumMax: self.firstMax,
            operations: self.userSelectons!.mathOperations,
            secondNumMin: self.secondMin, secondNumMax: self.secondMax);
        
        self.upperNumLabel.text = String(self.currentQuestion.firstNumber)
        
        if ( self.currentQuestion.secondNumber < 0 ) {
            // Use parens to clarify problems like 10 + -5
            self.lowerNumLabel.text = "\(self.currentQuestion.operation.rawValue)(\(self.currentQuestion.secondNumber))"
        }
        else {
            self.lowerNumLabel.text = "\(self.currentQuestion.operation.rawValue)\(self.currentQuestion.secondNumber)"
        }
    }
    
    
    // MARK: Actions
    
    @IBAction func answerSubmitted(sender: AnyObject) {
        
        if let submittedAnswer = Int(self.answerField.text!) {
            
            // An answer has been submitted.
            // Give feedback, update stats, show next question.
            
            self.numAnswered += 1
            
            let expected = self.currentQuestion.expectedAnswer
            
            if submittedAnswer == expected {
                self.answerCorrectImage.hidden = false
                self.numCorrect += 1
            }
            else {
                self.answerField.text = String(expected)
                self.answerField.textColor = self.answerCorrectionColor
            }
            
            let delay = self.secsToShowAnswerFeedback * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            
            dispatch_after(time, dispatch_get_main_queue()) {
                self.answerCorrectImage.hidden = true
                self.answerField.textColor = self.answerColor
                self.generateRandomMathProblem()
                self.answerField.text = nil
                self.cardCount.increment()
                self.answerField.becomeFirstResponder()
            }
        }
        
    }
    
    
    @IBAction func dismiss(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func showResults(sender: AnyObject) {
        
        // Done with the cards.  Clean up the view and report the results.
        
        self.stopButton.hidden = true
        self.timer.hidden = true
        self.timer.stop()
        
        self.resultTotalsLabel.text = "\(self.numCorrect) of \(self.numAnswered) correct"
        
        if ( self.numAnswered > 0 ) {
            let percentCorrect = Float(self.numCorrect) / Float(self.numAnswered) * 100.0
            self.resultPercentageLabel.text = String(format: "%.0f%%", percentCorrect)
        }
        else {
            self.resultPercentageLabel.text = ""
        }
        
        if let timeCountedDown = self.timer.timeCountedDownAsSeconds() {
            
            self.resultTotalTimeLabel.text = "Total time: \(self.timer.timeCountedDownAsString()!)"
            
            if ( self.numAnswered > 0 ) {
                let avgTime: Float = Float(timeCountedDown) / Float(self.numAnswered)
                self.resultAverageTimeLabel.text = String(format: "Average: %.1f sec", avgTime)
            }
            else {
                self.resultAverageTimeLabel.text = ""
            }
        }

        self.resultsView.hidden = false
        self.answerField.resignFirstResponder()
    }
    
    
    @IBAction func invertAnswer(sender: AnyObject) {
        self.answerField.invertValue()
    }
    
    
    // MARK: Delegates        
        
    
    func countdownDidFinish() {
        self.showResults(self)
    }

    
    func countUpDidFinish() {
        self.showResults(self)
    }
    
}
