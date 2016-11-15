//
//  Subject+CoreDataProperties.swift
//  IQuiz
//
//  Created by Litthideth Phansiri on 11/15/16.
//  Copyright © 2016 Lit Phansiri. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Subject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subject> {
        return NSFetchRequest<Subject>(entityName: "Subject");
    }

    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var imageFile: String?
    @NSManaged public var toQuestion: NSSet?

}

// MARK: Generated accessors for toQuestion
extension Subject {

    @objc(addToQuestionObject:)
    @NSManaged public func addToToQuestion(_ value: Question)

    @objc(removeToQuestionObject:)
    @NSManaged public func removeFromToQuestion(_ value: Question)

    @objc(addToQuestion:)
    @NSManaged public func addToToQuestion(_ values: NSSet)

    @objc(removeToQuestion:)
    @NSManaged public func removeFromToQuestion(_ values: NSSet)

}
