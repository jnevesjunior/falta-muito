//
//  CoursePresenter.swift
//  Falta Muito?
//
//  Created by Jose Neves on 01/04/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

class CoursePresenter {
    
    init() {
        func saveCourse(course: [String: Any], period: Period) -> Course {
            var courseArray = course
            courseArray["period"] = period
            
            return Course().createEntity(array: courseArray as [String : AnyObject])!
        }
    }
}
