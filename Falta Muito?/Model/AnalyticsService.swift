//
//  AnalyticsService.swift
//  Falta Muito?
//
//  Created by Jose Neves on 16/04/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

class AnalyticsService {
    func addTrackerToScreen(screenName: String) {
        let tracker = GAI.sharedInstance().defaultTracker
        tracker?.set(kGAIScreenName, value: screenName)
        tracker?.send((GAIDictionaryBuilder.createScreenView().build() as NSDictionary) as? [AnyHashable: Any])
    }
}
