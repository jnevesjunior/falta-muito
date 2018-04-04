//
//  CoursePresenter.swift
//  Falta Muito?
//
//  Created by Jose Neves on 01/04/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import CoreData

class CoursePresenter {
    
    private let coreDataService: CoreDataService
    
    init() {
        self.coreDataService = CoreDataService()
    }
    
    func getCourses(period: Period, courses: @escaping ([Course]) -> Void) -> Void {
        self.coreDataService.getDataByEntity(entityName: "Course") { (coursesList) in
            let coursesFiltered = (coursesList as NSArray).filtered(using: NSPredicate(format: "period == %@", period))
            
            if let resultCourses = coursesFiltered as? [Course] {
                courses(resultCourses)
            }
        }
    }
    
    func saveCourses(courses: [String], period: Period) -> [Course] {
        var coursesObj = [Course]()
        
        for course in courses {
            var courseArray = [String: AnyObject]()
            courseArray["name"] = course as AnyObject
            courseArray["period"] = period
            
            coursesObj.append(Course().createEntity(array: courseArray)!)
        }
        return coursesObj
    }
}
