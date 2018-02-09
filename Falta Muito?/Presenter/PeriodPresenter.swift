//
//  PeriodPresenter.swift
//  Falta Muito?
//
//  Created by Jose Neves on 07/02/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import CoreData

class PeriodPresenter {
    
    private let coreDataService: CoreDataService
    
    init() {
        self.coreDataService = CoreDataService()
    }
    
    func getPeriods(periods: @escaping ([Period]) -> Void) -> Void {
        self.coreDataService.getDataByEntity(entityName: "Period") { (result) in
            if let resultPeriods = result as? [Period] {
                periods(resultPeriods)
            }
        }
    }
    
    func savePeriod(name: String, courses: Int, averageNote: Double, maxNote: Double) -> Period {
        var periodArray = [String: Any]()
        periodArray["name"] = name
        periodArray["courses"] = courses
        periodArray["averageNote"] = averageNote
        periodArray["maxNote"] = maxNote

        return Period().createEntity(array: periodArray as [String : AnyObject])!
    }
}
