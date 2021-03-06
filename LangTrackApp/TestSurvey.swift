//
//  TestSurvey.swift
//  LangTrackApp
//
//  Created by Stephan Björck on 2020-01-31.
//  Copyright © 2020 Stephan Björck. All rights reserved.
//

/*import Foundation


class TestSurvey {
    
    static func getTempSurvey(number: String, responded: Bool) -> Survey{
        var tempQuestionList = [Question]()
        let q0 = Question()
        q0.type = Type.header.rawValue
        q0.id = "id"
        q0.previous = 0
        q0.index = 0
        q0.next = 1
        q0.title = "THE LANG-TRACK-APP\nHumanistlaboratoriet"
        q0.text = "Hej deltagare\n\nNu är det dags att svara på frågor om din språkinlärning!"
        q0.description = ""
        
        tempQuestionList.append(q0)
        
        let q1 = Question()
        q1.type = Type.likertScales.rawValue
        q1.id = "id"
        q1.previous = 0
        q1.index = 1
        q1.next = 2
        q1.title = "LikertScale titel"
        q1.text = "Här skrivs ett påstående som deltagaren graderar hur mycket det stämmer"
        q1.description = "Hur mycket stämmer följande påstående?\n1: stämmer inte alls\n5: stämmer helt"
        
        tempQuestionList.append(q1)
        
        let q2 = Question()
        q2.type = Type.fillInTheBlank.rawValue
        q2.id = "id"
        q2.previous = 1
        q2.index = 2
        q2.next = 3
        q2.title = "FillInTheBlank titel"
        q2.text = "Här är texten i FillInTheBlank"
        q2.description = ""
        
        tempQuestionList.append(q2)
        
        let q3 = Question()
        q3.type = Type.multipleChoice.rawValue
        q3.id = "id"
        q3.previous = 2
        q3.index = 3
        q3.next = 4
        q3.title = "MultipleChoise titel"
        q3.text = "Här är texten i MultipleChoise"
        q3.description = ""
        
        tempQuestionList.append(q3)
        
        let q4 = Question()
        q4.type = Type.singleMultipleAnswers.rawValue
        q4.id = "id"
        q4.previous = 3
        q4.index = 4
        q4.next = 5
        q4.title = "SingleMultipleAnswer titel"
        q4.text = "Här är texten i SingleMultipleAnswer"
        q4.description = ""
        
        tempQuestionList.append(q4)
        
        let q5 = Question()
        q5.type = Type.openEndedTextResponses.rawValue
        q5.id = "id"
        q5.previous = 4
        q5.index = 5
        q5.next = 6
        q5.title = "OpenEndedTextResponses titel"
        q5.text = "Här är texten i OpenEndedTextResponses"
        q5.description = ""
        
        tempQuestionList.append(q5)
        
        let q6 = Question()
        q6.type = Type.footer.rawValue
        q6.id = "id"
        q6.previous = 5
        q6.index = 6
        q6.next = 0
        q6.title = "Tack för dina svar."
        q6.text = "Om du är nöjd med dina svar välj 'Skicka in'\nannars kan du stega bak för att redigera."
        q6.description = ""
        
        tempQuestionList.append(q6)

        tempQuestionList = tempQuestionList.sorted(by: { $0.index < $1.index})
        var tempSurvey = Survey()
        tempSurvey.questions = tempQuestionList
        tempSurvey.date = Int64(Date().timeIntervalSince1970)
        tempSurvey.responded = responded
        tempSurvey.title = "Testsurvey \(number)"

        return tempSurvey
    }
    
    static func getTempSurveyWithOneQuestion(number: String, responded: Bool) -> Survey{
        var tempQuestionList = [Question]()
        let q0 = Question()
        q0.type = Type.header.rawValue
        q0.id = "id"
        q0.previous = 0
        q0.index = 0
        q0.next = 1
        q0.title = "THE LANG-TRACK-APP\nHumanistlaboratoriet"
        q0.text = "Hej deltagare\n\nNu är det dags att svara på frågor om din språkinlärning!\nDetta är en survey med endast en fråga"
        q0.description = ""
        
        tempQuestionList.append(q0)
        
        let q1 = Question()
        q1.type = Type.likertScales.rawValue
        q1.id = "id"
        q1.previous = 0
        q1.index = 1
        q1.next = 2
        q1.title = "LikertScale titel"
        q1.text = "Här skrivs ett påstående som deltagaren graderar hur mycket det stämmer"
        q1.description = "Hur mycket stämmer följande påstående?\n1: stämmer inte alls\n5: stämmer helt"
        
        tempQuestionList.append(q1)
        
        let q6 = Question()
        q6.type = Type.footer.rawValue
        q6.id = "id"
        q6.previous = 1
        q6.index = 2
        q6.next = 0
        q6.title = "Tack för dina svar."
        q6.text = "Om du är nöjd med dina svar välj 'Skicka in'\nannars kan du stega bak för att redigera."
        q6.description = ""
        
        tempQuestionList.append(q6)

        tempQuestionList = tempQuestionList.sorted(by: { $0.index < $1.index})
        var tempSurvey = Survey()
        tempSurvey.questions = tempQuestionList
        tempSurvey.date = Int64(Date().timeIntervalSince1970)
        tempSurvey.responded = responded
        tempSurvey.title = "Testsurvey \(number)"

        return tempSurvey
    }
    
    static func getTempSurveyWithThreeMixedQuestion(number: String, responded: Bool) -> Survey{
        var tempQuestionList = [Question]()
        let q0 = Question()
        q0.type = Type.header.rawValue
        q0.id = "id"
        q0.previous = 0
        q0.index = 0
        q0.next = 1
        q0.title = "THE LANG-TRACK-APP\nHumanistlaboratoriet"
        q0.text = "Hej deltagare\n\nNu är det dags att svara på frågor om din språkinlärning!\nDetta är en survey med två likert och en open ended"
        q0.description = ""
        
        tempQuestionList.append(q0)
        
        let q1 = Question()
        q1.type = Type.likertScales.rawValue
        q1.id = "id"
        q1.previous = 0
        q1.index = 1
        q1.next = 2
        q1.title = "LikertScale titel"
        q1.text = "Här är texten i LikertScale 1"
        q1.description = "Hur mycket stämmer följande påstående?\n1: stämmer inte alls\n5: stämmer helt"
        
        tempQuestionList.append(q1)
        
        let q2 = Question()
        q2.type = Type.likertScales.rawValue
        q2.id = "id"
        q2.previous = 1
        q2.index = 2
        q2.next = 3
        q2.title = "LikertScale titel"
        q2.text = "Här är texten i LikertScale 2"
        q2.description = ""
        
        tempQuestionList.append(q2)
        
        let q3 = Question()
        q3.type = Type.openEndedTextResponses.rawValue
        q3.id = "id"
        q3.previous = 2
        q3.index = 3
        q3.next = 4
        q3.title = "OpenEndedTextResponses titel"
        q3.text = "Här är texten i OpenEndedTextResponses"
        q3.description = ""
        
        tempQuestionList.append(q3)
        
        let q6 = Question()
        q6.type = Type.footer.rawValue
        q6.id = "id"
        q6.previous = 3
        q6.index = 4
        q6.next = 5
        q6.title = "Tack för dina svar."
        q6.text = "Om du är nöjd med dina svar välj 'Skicka in'\nannars kan du stega bak för att redigera."
        q6.description = ""
        
        tempQuestionList.append(q6)

        tempQuestionList = tempQuestionList.sorted(by: { $0.index < $1.index})
        var tempSurvey = Survey()
        tempSurvey.questions = tempQuestionList
        tempSurvey.date = Int64(Date().timeIntervalSince1970)
        tempSurvey.responded = responded
        tempSurvey.title = "Testsurvey \(number)"

        return tempSurvey
    }
}

*/
