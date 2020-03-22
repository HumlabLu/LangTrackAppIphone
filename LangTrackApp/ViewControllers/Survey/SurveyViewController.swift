//
//  SurveyViewController.swift
//  LangTrackApp
//
//  Created by Stephan Björck on 2020-01-30.
//  Copyright © 2020 Stephan Björck. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController {
    @IBOutlet weak var surveyContainer: UIView!
    
    var answer = [Int:Answer]()
    var theAssignment: Assignment? = nil
    var currentPage = Question()
    var theUser: User?
    
    var header: HeaderViewController?
    var likertScale: LikertScaleViewController?
    var fillInTheBlank: FillInTheBlankViewController?
    var multipleChoice: MultipleChoiceViewController?
    var singleMultipleAnswers: SingleMultipleAnswersViewController?
    var openEndedTextResponses: OpenEndedTextResponsesViewController?
    var footer: FooterViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        header = storyboard.instantiateViewController(withIdentifier: "header") as? HeaderViewController
        header?.setListener(listener: self)
        header?.theUser = self.theUser
        
        likertScale = storyboard.instantiateViewController(withIdentifier: "likertScale") as? LikertScaleViewController
        likertScale?.setListener(listener: self)
        
        fillInTheBlank = storyboard.instantiateViewController(withIdentifier: "fillInTheBlank") as? FillInTheBlankViewController
        fillInTheBlank?.setListener(listener: self)
        
        multipleChoice = storyboard.instantiateViewController(withIdentifier: "multipleChoice") as? MultipleChoiceViewController
        multipleChoice?.setListener(listener: self)
        
        singleMultipleAnswers = storyboard.instantiateViewController(withIdentifier: "singleMultipleAnswer") as? SingleMultipleAnswersViewController
        singleMultipleAnswers?.setListener(listener: self)
        
        openEndedTextResponses = storyboard.instantiateViewController(withIdentifier: "openEndedTextResponses") as? OpenEndedTextResponsesViewController
        openEndedTextResponses?.setListener(listener: self)
        
        footer = storyboard.instantiateViewController(withIdentifier: "footer") as? FooterViewController
        footer?.setListener(listener: self)
        
        //to convert to json
        //print(theSurvey!.convertToString!)
        
        if theAssignment?.survey.questions.first != nil{
            showPage(newPage: theAssignment!.survey.questions.first!)
        }
         #warning ("TODO popup if error")
    }
    

    func showPage(newPage : Question)
    {
        var theQuestion = Question()
        for ques in theAssignment!.survey.questions {
            if ques.index == newPage.index{
                theQuestion = ques
            }
        }
        // STÄDA BORT CURRENT
        if(currentPage.type == Type.header.rawValue)
        {
            header!.willMove(toParent: nil)
            header!.view.removeFromSuperview()
            header!.removeFromParent()
        }
        if(currentPage.type == Type.likertScales.rawValue)
        {
            likertScale!.willMove(toParent: nil)
            likertScale!.view.removeFromSuperview()
            likertScale!.removeFromParent()
        }
        if(currentPage.type == Type.fillInTheBlank.rawValue)
        {
            fillInTheBlank!.willMove(toParent: nil)
            fillInTheBlank!.view.removeFromSuperview()
            fillInTheBlank!.removeFromParent()
        }
        if(currentPage.type == Type.multipleChoice.rawValue)
        {
            multipleChoice!.willMove(toParent: nil)
            multipleChoice!.view.removeFromSuperview()
            multipleChoice!.removeFromParent()
        }
        if(currentPage.type == Type.singleMultipleAnswers.rawValue)
        {
            singleMultipleAnswers!.willMove(toParent: nil)
            singleMultipleAnswers!.view.removeFromSuperview()
            singleMultipleAnswers!.removeFromParent()
        }
        if(currentPage.type == Type.openEndedTextResponses.rawValue)
        {
            openEndedTextResponses!.willMove(toParent: nil)
            openEndedTextResponses!.view.removeFromSuperview()
            openEndedTextResponses!.removeFromParent()
        }
        if(currentPage.type == Type.footer.rawValue)
        {
            footer!.willMove(toParent: nil)
            footer!.view.removeFromSuperview()
            footer!.removeFromParent()
        }
        currentPage = newPage
        
        
        if(currentPage.type == Type.header.rawValue)
        {
            self.addChild(header!)
            surveyContainer.addSubview(header!.view)
            header!.view.frame = surveyContainer.bounds
            header!.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            header!.didMove(toParent: self)
            header!.setInfo(question: theQuestion)
        }
        if(currentPage.type == Type.likertScales.rawValue)
        {
            self.addChild(likertScale!)
            surveyContainer.addSubview(likertScale!.view)
            likertScale!.view.frame = surveyContainer.bounds
            likertScale!.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            likertScale!.didMove(toParent: self)
            if let theAnswer = answer.first(where: { $0.value.index == currentPage.index}){
                likertScale!.theAnswer = theAnswer.value
            }
            //likertScale!.theAnswer = theAssignment!.dataset?.answers.first(where: {$0.index == currentPage.index})
            likertScale!.setInfo(question: theQuestion)
        }
        if(currentPage.type == Type.fillInTheBlank.rawValue)
        {
            self.addChild(fillInTheBlank!)
            surveyContainer.addSubview(fillInTheBlank!.view)
            fillInTheBlank!.view.frame = surveyContainer.bounds
            fillInTheBlank!.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            fillInTheBlank!.didMove(toParent: self)
            if let theAnswer = answer.first(where: { $0.value.index == currentPage.index}){
                fillInTheBlank!.theAnswer = theAnswer.value
            }
            //fillInTheBlank!.theAnswer = theAssignment!.dataset?.answers.first(where: {$0.index == currentPage.index})
            fillInTheBlank!.setInfo(question: theQuestion)
        }
        if(currentPage.type == Type.multipleChoice.rawValue)
        {
            self.addChild(multipleChoice!)
            surveyContainer.addSubview(multipleChoice!.view)
            multipleChoice!.view.frame = surveyContainer.bounds
            multipleChoice!.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            multipleChoice!.didMove(toParent: self)
            if let theAnswer = answer.first(where: { $0.value.index == currentPage.index}){
                multipleChoice!.theAnswer = theAnswer.value
            }
            //multipleChoice!.theAnswer = theAssignment!.dataset?.answers.first(where: {$0.index == currentPage.index})
            multipleChoice!.setInfo(question: theQuestion)
        }
        if(currentPage.type == Type.singleMultipleAnswers.rawValue)
        {
            self.addChild(singleMultipleAnswers!)
            surveyContainer.addSubview(singleMultipleAnswers!.view)
            singleMultipleAnswers!.view.frame = surveyContainer.bounds
            singleMultipleAnswers!.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            singleMultipleAnswers!.didMove(toParent: self)
            if let theAnswer = answer.first(where: { $0.value.index == currentPage.index}){
                singleMultipleAnswers!.theAnswer = theAnswer.value
            }
            singleMultipleAnswers!.setInfo(question: theQuestion)
        }
        if(currentPage.type == Type.openEndedTextResponses.rawValue)
        {
            self.addChild(openEndedTextResponses!)
            surveyContainer.addSubview(openEndedTextResponses!.view)
            openEndedTextResponses!.view.frame = surveyContainer.bounds
            openEndedTextResponses!.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            openEndedTextResponses!.didMove(toParent: self)
            if let theAnswer = answer.first(where: { $0.value.index == currentPage.index}){
                openEndedTextResponses!.theAnswer = theAnswer.value
            }
            //openEndedTextResponses!.theAnswer = theAssignment!.dataset?.answers.first(where: {$0.index == currentPage.index})
            openEndedTextResponses!.setInfo(question: theQuestion)
        }
        if(currentPage.type == Type.footer.rawValue)
        {
            self.addChild(footer!)
            surveyContainer.addSubview(footer!.view)
            footer!.view.frame = surveyContainer.bounds
            footer!.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            footer!.didMove(toParent: self)
            footer!.setInfo(question: theQuestion)
        }
    }
    
    func checkNext(current: Question){
        print("current.index: \(current.index)")
        if current.index + 1 < theAssignment!.survey.questions.count{
            let next = theAssignment!.survey.questions[current.index + 1]
            if next.includeIf != nil{
                let includeIfIndexQuestion = theAssignment!.survey.questions[next.includeIf!.ifIndex]
                print("includeIfIndexQuestion.index: \(includeIfIndexQuestion.index)")
                if next.includeIf!.ifIndex == includeIfIndexQuestion.index{
                    if let answer = self.answer[includeIfIndexQuestion.index]{
                        switch includeIfIndexQuestion.type {
                        case "single":
                            if next.includeIf?.ifValue ?? -99 == answer.singleMultipleAnswer{
                                next.previous = currentPage.index
                                showPage(newPage: next)
                                print("answer included in single - show next")
                            }else{
                                // dont show next - check following question
                                checkNext(current: next)
                                print("answer not included in single - check next")
                            }
                        case "blanks":
                            if next.includeIf?.ifValue ?? -99 == answer.fillBlankAnswer{
                                next.previous = currentPage.index
                                showPage(newPage: next)
                                print("answer included in blanks - show next")
                            }else{
                                // dont show next - check following question
                                checkNext(current: next)
                                print("answer not included in blanks - check next")
                            }
                        case "multi":
                            if (answer.multipleChoiceAnswer ?? []).contains(next.includeIf?.ifValue ?? -99){
                                next.previous = currentPage.index
                                showPage(newPage: next)
                                print("answer included in multi - show next")
                            }else{
                                // dont show next - check following question
                                checkNext(current: next)
                                print("answer not included in multi - check next")
                            }
                        default:
                            next.previous = currentPage.index
                            showPage(newPage: next)
                            print("no answer-type match, show next")
                        }
                    }else{
                        //current answer does not includ a answer - show next
                        next.previous = currentPage.index
                        showPage(newPage: next)
                        print("current answer does not include a answer - show next")
                    }
                }else{
                    //next includeIf:ifIndex is not current index - show next
                    next.previous = currentPage.index
                    showPage(newPage: next)
                    print("next includeIf:ifIndex is not current index - show next")
                }
            }else{
                //next does not hanve includeIf - show next
                next.previous = currentPage.index
                showPage(newPage: next)
                print("next does not have includeIf - show next")
            }
        }else if current.index + 1 == theAssignment!.survey.questions.count{
            //next is last (footer) - dont check, show direct
            theAssignment!.survey.questions[current.index + 1].previous = currentPage.index
            showPage(newPage: theAssignment!.survey.questions[current.index + 1])
            print("next is last (footer) - dont check, show direct")
        }
    }
}

//MARK:- QuestionListener
extension SurveyViewController: QuestionListener{
    func setOpenEndedAnswer(text: String) {
        answer[currentPage.index] = Answer(
            type: "open",
            index: currentPage.index,
            likertAnswer: nil,
            fillBlankAnswer: nil,
            multipleChoiceAnswer: nil,
            singleMultipleAnswer: nil,
            openEndedAnswer: text)
    }
    
    func setFillBlankAnswer(selected: Int) {
        answer[currentPage.index] = Answer(
            type: "blanks",
            index: currentPage.index,
            likertAnswer: nil,
            fillBlankAnswer: selected,
            multipleChoiceAnswer: nil,
            singleMultipleAnswer: nil,
            openEndedAnswer: nil)
    }
    
    func setLikertAnswer(selected: Int) {
        answer[currentPage.index] = Answer(
            type: "likert",
            index: currentPage.index,
            likertAnswer: selected,
            fillBlankAnswer: nil,
            multipleChoiceAnswer: nil,
            singleMultipleAnswer: nil,
            openEndedAnswer: nil)
    }
    
    func setMultipleAnswersAnswer(selected: [Int]) {
        answer[currentPage.index] = Answer(
            type: "multi",
            index: currentPage.index,
            likertAnswer: nil,
            fillBlankAnswer: nil,
            multipleChoiceAnswer: selected,
            singleMultipleAnswer: nil,
            openEndedAnswer: nil)
    }
    
    
    func setSingleMultipleAnswer(selected: Int) {
        answer[currentPage.index] = Answer(
            type: "single",
            index: currentPage.index,
            likertAnswer: nil,
            fillBlankAnswer: nil,
            multipleChoiceAnswer: nil,
            singleMultipleAnswer: selected,
            openEndedAnswer: nil)
    }
    
    
    func closeSurvey() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func sendInSurvey() {
        if !answer.isEmpty{
            //TODO: check what answer to include, if includeIf or skip was used...
            // then a answer could have been saved - user backed and used skip: the answer is still saved...
            //tip: loop backwards through questions according to previous
            //and only include the ones included
            
            //om inget är valt vsas alla...
            SurveyRepository.postAnswer(answerDict: answer)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func nextQuestion(current: Question) {
        if theAssignment != nil{
            theAssignment!.survey.questions.sort(by: {$0.index < $1.index})
            checkNext(current: current)
        }
    }
    
    func previousQuestion(current: Question) {
        if theAssignment != nil{
            for q in theAssignment!.survey.questions {
                if q.index == current.previous{
                    showPage(newPage: q)
                }
            }
        }
    }
}
