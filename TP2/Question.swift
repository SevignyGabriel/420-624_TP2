//
//  Question.swift
//  TP2
//
//  Created by Sevigny on 2017-12-16.
//  Copyright © 2017 Sevigny. All rights reserved.
//

import GameplayKit

struct Question {
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    var allAnswers: [String]
    
    init(question: String, correctAnswer: String, incorrectAnswers: [String]) {
        self.question = question
        self.correctAnswer = correctAnswer
        self.incorrectAnswers = incorrectAnswers
        var tmp : [String] = incorrectAnswers
        tmp.append(correctAnswer)
        self.allAnswers = tmp
        self.allAnswers = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(self.allAnswers) as! [String]
    }
}
