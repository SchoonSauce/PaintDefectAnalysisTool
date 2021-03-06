//
//  Sample.swift
//  CSE435Project
//
//  Created by adam on 11/19/15.
//  Copyright © 2015 Adam Schoonmaker. All rights reserved.
//

import UIKit
import CoreData

enum SampleSide: Int16 {
    case Left = 1, Top, Right
    
    func toString() -> String {
        switch self {
        case .Left:
            return "Left"
        case .Top:
            return "Top"
        case .Right:
            return "Right"
        }
    }
}

class Sample: NSManagedObject {
    
    static let entityDescriptionName = "Sample"
    
    @NSManaged var leftSideDone: Bool
    @NSManaged var rightSideDone: Bool
    @NSManaged var model: ModelType?
    @NSManaged private var defects: NSOrderedSet
    
    func addDefect(defect: Defect) {
        let defectsSet = mutableOrderedSetValueForKey("defects")
        defectsSet.addObject(defect)
    }
    
    func removeDefect(defect: Defect) {
        let defectsSet = mutableOrderedSetValueForKey("defects")
        defectsSet.removeObject(defect)
    }
    
    func getDefectsArray() -> [Defect] {
        return defects.array as! [Defect]
    }
    
    func getDefectsArrayForSampleSide(sampleSide: SampleSide) -> [Defect] {
        return self.getDefectsArray().filter() { $0.drawingSide == sampleSide }
    }
    
    class func createInManagedObjectContext() -> Sample {
        let sample = NSEntityDescription.insertNewObjectForEntityForName(Sample.entityDescriptionName, inManagedObjectContext: CoreDataStack.sharedStack.managedObjectContext) as! Sample
        CoreDataStack.sharedStack.saveContext()
        return sample
    }
}
