//
//  SetCoursesViewController.swift
//  Falta Muito?
//
//  Created by Jose Neves on 08/02/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import UIKit

class SetCoursesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var courseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addDelegate()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath)
        cell.textLabel?.text = "Matéria \(indexPath.section + 1)"
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let closeAction = UIContextualAction(style: .destructive, title:  "❌", handler: { (ac: UIContextualAction, view: UIView, success) in
            success(true)
        })
        closeAction.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        
        return UISwipeActionsConfiguration(actions: [closeAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "courseID", sender: nil)
    }
    
    private func addDelegate() -> Void {
        self.courseTableView.delegate = self
        self.courseTableView.dataSource = self
    }
}
