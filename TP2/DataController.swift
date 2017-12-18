//
//  DataController.swift
//  TP2
//
//  Created by Sevigny on 2017-12-16.
//  Copyright © 2017 Sevigny. All rights reserved.
//

import UIKit

class DataController: NSObject {
    
    func createQuiz(category: Int, numberOfQuestions: Int, finished: ((isSuccess: Bool, quiz: Quiz) -> [Void])) {
        let url = (category > 0) ? NSURL(string: "https://opentdb.com/api.php?amount=" + String(numberOfQuestions) + "&category=" + String(category)) : NSURL(string: "https://opentdb.com/api.php?amount=" + String(numberOfQuestions))
        let session = NSURLSession.sharedSession()
        var questions: [Question] = []
        var quiz : Quiz = Quiz(questions: [])
        
        session.dataTaskWithURL(url!) { (data, response, error) in
            if let rep = response {
                //print("response : ", rep)
            }
            if let donnees = data {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(donnees, options: []) as! [String : AnyObject]
                    let results = json["results"]
                    
                    for index in 0...results!.count-1 {
                        let aObject = results![index] as! [String : AnyObject]
                        var questionText = aObject["question"]! as! String
                        var correctAnswerText = aObject["correct_answer"]! as! String
                        var incorrectAnswers = aObject["incorrect_answers"]! as! [String]
                        questionText = String(htmlEncodedString: questionText)!
                        correctAnswerText = String(htmlEncodedString: correctAnswerText)!
                        
                        for index2 in 0...incorrectAnswers.count-1 {
                            incorrectAnswers[index2] = String(htmlEncodedString: incorrectAnswers[index2])!
                        }
                        
                        let question = Question(question: questionText, correctAnswer: correctAnswerText, incorrectAnswers: incorrectAnswers)
                        print(index, " -- ", question.question, " -- ", question.correctAnswer)
                        questions.append(question)
                    }
                    quiz = Quiz(questions: questions)
                    finished(isSuccess: true, quiz: quiz)
                } catch {
                    print("error", error)
                    finished(isSuccess: false, quiz: quiz)
                }
            }
            }.resume()
    }
    
    func getTriviaCatagories(finished: ((isSuccess: Bool, categories: [Category]) -> [Void])) {
        let url = NSURL(string: "https://opentdb.com/api_category.php")
        let session = NSURLSession.sharedSession()
        var categories : [Category] = []
        //var pickerData : [String] = [String]()
        
        session.dataTaskWithURL(url!) { (data, response, error) in
            if let rep = response {
                //print("response : ", rep)
            }
            if let donnees = data {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(donnees, options: []) as! [String : AnyObject]
                    let results = json["trivia_categories"]
                    
                    categories.append(Category(id: 0, name: "Any"))
                    for index in 0...results!.count-1 {
                        let aObject = results![index] as! [String : AnyObject]
                        let category = Category(id: aObject["id"]! as! Int, name: aObject["name"]! as! String)
                        categories.append(category)
                    }
                    finished(isSuccess: true, categories: categories)
                } catch {
                    print("error", error)
                    finished(isSuccess: false, categories: categories)
                }
            }
            }.resume()
    }
    
    /*func toPickerData(categories: [Category]) -> [String] {
        var pickerData : [String] = [String]()
        pickerData.append("Any")
        
        for index in 0...categories.count-1 {
            pickerData.append(categories[index].name)
        }
        
        return pickerData
    }*/
}

extension String {
    init?(htmlEncodedString: String) {
        if let encodedData = htmlEncodedString.dataUsingEncoding(NSUTF8StringEncoding) {
            let attributedOptions : [String : AnyObject] = [
                NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
            ]
            
            do {
                if let attributedString = try? NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil) {
                    self.init(attributedString.string)
                } else {
                    print("error")
                    self.init(htmlEncodedString)
                }
            } catch {
                print("error : \(error)")
                self.init(htmlEncodedString)
            }
        } else {
            self.init(htmlEncodedString)
        }
    }
}
