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
    
    fileprivate let secsToShowAnswerFeedback = 1.0
    
    fileprivate var firstMin: Int = 1
    fileprivate var firstMax: Int = 1
    fileprivate var secondMin: Int = 1
    fileprivate var secondMax: Int = 1
    
    fileprivate var currentQuestion: MathQuestion!
    fileprivate var numAnswered: Int = 0
    fileprivate var numCorrect: Int = 0
    
    fileprivate var runCardsDelegate : RunCardsTextFieldDelegate?
    
    //private let answerTextFieldDelegate: MathAnswerTextFieldDelegate = MathAnswerTextFieldDelegate()

    
    // MARK: Public properties

    weak var userSelectons: UserSelections?
    var answerColor: UIColor = UIColor.black
    var answerCorrectionColor: UIColor = UIColor.red
    
    
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
        
        self.timer.isHidden = true
        self.stopButton.isHidden = false
        
        // Stylize some visuals
        
        self.cardView.layer.cornerRadius = 5
        self.cardView.layer.borderColor = UIColor.black.cgColor
        self.cardView.layer.borderWidth = 2.0

        self.backgroundImage.image = UIImage(named: "bg\(Int.random(1..<4))")
        self.answerColor = self.answerField.textColor!
        
        self.answerField.maxNumDigits = 6
        self.answerField.delegate = self
        
        self.runCardsDelegate = RunCardsTextFieldDelegate(runCardsVC: self)
        self.answerField.delegate = self.runCardsDelegate
    }
    
    
    override func viewWillAppear(_ animated: Bool) {

        self.answerField.becomeFirstResponder()

        self.generateRandomMathProblem()
        
        self.cardCount.reset(self.userSelectons?.cardLimit)
        
        if let timeLimit = self.userSelectons?.minuteLimit {
            if ( timeLimit > 0 ) {
                // Use the user-selected time limit if applicable
                self.timer.isHidden = false
                self.timer.setCountdown(minutes: timeLimit)
            }
            else {
                // Otherwise, hide the timer but silently treack the time
                // anyways for reporting.
                self.timer.isHidden = true
                self.timer.setCountdown(minutes: 1000) // Just a really long time
            }
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        
        // Reset the data in case this view is reused
        self.numAnswered = 0
        self.numCorrect = 0
        self.firstMin = 1
        self.firstMax = 1
        self.secondMin = 1
        self.secondMax = 1
        self.userSelectons = nil
        
        // Reset the view too where applicable
        self.timer.isHidden = true
        self.stopButton.isHidden = false
        
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
    
    @IBAction func answerSubmitted(_ sender: AnyObject) {
        
        if let submittedAnswer = Int(self.answerField.text!) {
            
            // An answer has been submitted.
            // Give feedback, update stats, show next question.
            
            self.numAnswered += 1
            
            let expected = self.currentQuestion.expectedAnswer
            
            if submittedAnswer == expected {
                self.answerCorrectImage.isHidden = false
                self.numCorrect += 1
            }
            else {
                self.answerField.text = String(expected)
                self.answerField.textColor = self.answerCorrectionColor
            }
            
            let delay = self.secsToShowAnswerFeedback * Double(NSEC_PER_SEC)
            let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
            
            DispatchQueue.main.asyncAfter(deadline: time) {
                self.answerCorrectImage.isHidden = true
                self.answerField.textColor = self.answerColor
                self.generateRandomMathProblem()
                self.answerField.text = nil
                self.cardCount.increment()
                self.answerField.becomeFirstResponder()
            }
        }
        
    }
    
    
    @IBAction func dismiss(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func showResults(_ sender: AnyObject) {
        
        // Done with the cards.  Clean up the view and report the results.
        
        self.stopButton.isHidden = true
        self.timer.isHidden = true
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

        self.resultsView.isHidden = false
        self.answerField.resignFirstResponder()
    }
    
    
    @IBAction func invertAnswer(_ sender: AnyObject) {
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
