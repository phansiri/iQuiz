//
//  Subject.swift
//  IQuiz
//
//  Created by Litthideth Phansiri on 11/10/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//

import UIKit
import Alamofire

class Subject: NSObject {
    var title: String!
    var desc: String!
    var imageFile: String!
    var question: [Question] = []
}

