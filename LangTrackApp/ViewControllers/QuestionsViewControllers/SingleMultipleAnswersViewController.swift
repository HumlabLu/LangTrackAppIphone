//
//  SingleMultipleAnswersViewController.swift
//  LangTrackApp
//
//  Created by Stephan Björck on 2020-01-30.
//  Copyright © 2020 Stephan Björck. All rights reserved.
//

import UIKit

class SingleMultipleAnswersViewController: UIViewController {

    @IBOutlet weak var containerBackground: UIView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: NextButton!
    @IBOutlet weak var singleMultipleTextLabel: UILabel!
    @IBOutlet weak var answersContainer: UIView!
    @IBOutlet weak var answersContainerHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var answersContainerWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var theIcon: UIImageView!
    var listener: QuestionListener?
    var theQuestion = Question()
    var theAnswer: Answer? 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previousButton.layer.cornerRadius = 8
        nextButton.layer.cornerRadius = 8
        theIcon.clipsToBounds = false
        theIcon.setSmallViewShadow()
    }
    
    func setInfo(question: Question){
        self.theQuestion = question
        singleMultipleTextLabel.text = theQuestion.text
        nextButton.setEnabled(enabled: false)
        fillAnswers()
    }
    
    func setListener(listener: QuestionListener) {
        self.listener = listener
    }
    
    func markSelectedAnswer(selected: Int){
        for v in answersContainer.subviews{
            if v is VKCheckbox{
                let check = v as! VKCheckbox
                if check.tag != selected{
                    check.setOn(false, animated: true)
                }
            }
        }
    }
    
    func getSelected() -> Int?{
        for v in answersContainer.subviews{
            if v is VKCheckbox{
                if (v as! VKCheckbox).isOn{
                    return v.tag
                }
            }
        }
        return nil
    }
    
    func saveAnswer(){
        let answer = getSelected()
        if answer != nil{
            listener?.setSingleMultipleAnswer(selected: answer!)
        }
    }
    
    func emptyAnswers(){
        for v in answersContainer.subviews{
            v.removeFromSuperview()
        }
    }
    
    func fillAnswers(){
        emptyAnswers()
        if theQuestion.singleMultipleAnswers != nil{
            let spacer = 10
            let size = 29
            var maxIntrinsicWidth: CGFloat = 100
            for (i, answer) in theQuestion.singleMultipleAnswers!.enumerated() {
                let check = VKCheckbox(frame: CGRect(x: 0, y: ((size + spacer) * i), width: size, height: size))
                //check.bgColorSelected = .white
                check.bgColorSelected = UIColor(named: "lta_blue") ?? .black
                check.color = .white
                check.borderWidth = 1.5
                check.line = .thin
                check.cornerRadius = check.frame.width / 2
                check.tag = i
                if theAnswer != nil {
                    if theAnswer?.index == theQuestion.index{
                        if theAnswer!.singleMultipleAnswer != nil{
                            if check.tag == theAnswer!.singleMultipleAnswer!{
                                check.setOn(true)
                                nextButton.setEnabled(enabled: true)
                            }
                        }
                    }
                }
                check.checkboxValueChangedBlock = {
                    tag, ison in
                    if ison{
                        self.markSelectedAnswer(selected: tag)
                        self.nextButton.setEnabled(enabled: true)
                    }
                }
                let containerWidth = Int(containerBackground.frame.width * 0.92) - size - spacer
                let text = UILabel(frame: CGRect(x: size + spacer, y: ((size + spacer) * i), width: containerWidth, height: size))
                text.text = answer
                text.textAlignment = .left
                text.font = text.font.withSize(18)
                text.contentMode = .center
                text.numberOfLines = 0
                if text.intrinsicContentSize.width > maxIntrinsicWidth{
                    maxIntrinsicWidth = text.intrinsicContentSize.width
                }
                answersContainer.addSubview(check)
                answersContainer.addSubview(text)
                answersContainerHeightConstraint.constant = CGFloat((size + spacer) * (i+1))
            }
            if (maxIntrinsicWidth + CGFloat(size + spacer)) < containerBackground.frame.width{
                answersContainerWidthConstraint.constant = maxIntrinsicWidth + CGFloat(size + spacer)
            }else{
                answersContainerWidthConstraint.constant = containerBackground.frame.width
            }
        }
    }
    
    @IBAction func previousButtonPressed(_ sender: Any) {
        saveAnswer()
        listener?.previousQuestion(current: theQuestion)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        saveAnswer()
        listener?.nextQuestion(current: theQuestion)
    }
    
}
