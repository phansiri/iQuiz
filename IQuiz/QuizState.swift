//
//  QuizState.swift
//  IQuiz
//
//  Created by Litthideth Phansiri on 11/10/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//

import UIKit

class QuizState: NSObject {
    var questionCounter: Int!
    var questionAnsweredCorrectly: Int!
    var maxQuestion: Int!
    var answerPressed: Int = -1
    var isCorrect: Bool = false
}
