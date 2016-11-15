//
//  Question+CoreDataProperties.swift
//  IQuiz
//
//  Created by Litthideth Phansiri on 11/15/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question");
    }

    @NSManaged public var text: String?
    @NSManaged public var answer: String?
    @NSManaged public var toSubject: Subject?
    @NSManaged public var toAnswers: NSSet?

}

// MARK: Generated accessors for toAnswers
extension Question {

    @objc(addToAnswersObject:)
    @NSManaged public func addToToAnswers(_ value: Answers)

    @objc(removeToAnswersObject:)
    @NSManaged public func removeFromToAnswers(_ value: Answers)

    @objc(addToAnswers:)
    @NSManaged public func addToToAnswers(_ values: NSSet)

    @objc(removeToAnswers:)
    @NSManaged public func removeFromToAnswers(_ values: NSSet)

}
