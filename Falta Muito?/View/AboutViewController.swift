//
//  AboutViewController.swift
//  Falta Muito?
//
//  Created by Jose Neves on 13/04/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var appLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String {
            self.appLabel.text = "\(appName) © \(Calendar.current.component(.year, from: Date()))"
        }
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            self.versionLabel.text = "Versão: \(version)"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AnalyticsService().addTrackerToScreen(screenName: "About")
    }
}
