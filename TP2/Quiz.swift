//
//  Quiz.swift
//  TP2
//
//  Created by Sevigny on 2017-12-16.
//  Copyright © 2017 Sevigny. All rights reserved.
//

struct Quiz {
    let questions: [Question]
    var numberCorrectAnswers: Int
    
    init(questions: [Question]) {
        self.questions = questions
        self.numberCorrectAnswers = 0
    }
}
