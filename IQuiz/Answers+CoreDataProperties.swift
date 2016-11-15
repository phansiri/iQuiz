//
//  Answers+CoreDataProperties.swift
//  IQuiz
//
//  Created by Litthideth Phansiri on 11/15/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Answers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Answers> {
        return NSFetchRequest<Answers>(entityName: "Answers");
    }

    @NSManaged public var answer: String?
    @NSManaged public var toQuestion: Question?

}
