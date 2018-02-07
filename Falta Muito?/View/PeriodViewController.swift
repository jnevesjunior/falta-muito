//
//  PeriodViewController.swift
//  Falta Muito?
//
//  Created by Jose Neves on 24/01/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import UIKit

class PeriodViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var periodTableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    private var periodPresenter: PeriodPresenter!
    
    private var periods = [Period]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.periodPresenter = PeriodPresenter()
        
        self.periodTableView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(self.refreshData(_:)), for: .valueChanged)
        
        self.periodTableView.register(UINib(nibName: "PeriodTableCell", bundle: nil), forCellReuseIdentifier: "periodTableCell")
        
        self.addDelegate()
        self.getPeriods()
    }
    
    @IBAction func createAction(_ sender: Any) {
        self.performSegue(withIdentifier: "createPeriodID", sender: nil)
    }
    
    @objc private func refreshData(_ sender: Any) {
        self.getPeriods()
        self.refreshControl.endRefreshing()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.periods.count
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
        let period = self.periods[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "periodTableCell", for: indexPath) as! PeriodTableViewCell
        cell.nameLabel.text = period.name
        
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
        self.periodTableView.delegate = self
        self.periodTableView.dataSource = self
    }
    
    private func getPeriods() -> Void {
        self.periodPresenter.getPeriods() { (periods) in
            self.periods = periods
            self.periodTableView.reloadData()
        }
    }
}
