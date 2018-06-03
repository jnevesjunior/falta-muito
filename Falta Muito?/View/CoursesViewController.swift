//
//  CoursesViewController.swift
//  Falta Muito?
//
//  Created by Jose Neves on 02/04/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var courseTableView: UITableView!
   
    private let refreshControl = UIRefreshControl()
    private var courses = [Course]()
    private var coursePresenter: CoursePresenter!
    private var period: Period!
    private var selectedCourse: Course!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.coursePresenter = CoursePresenter()
        
        self.courseTableView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(self.refreshData(_:)), for: .valueChanged)
        
        self.courseTableView.register(UINib(nibName: "CourseTableCell", bundle: nil), forCellReuseIdentifier: "courseTableCell")
        
        self.addDelegate()
        self.getCourses()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AnalyticsService().addTrackerToScreen(screenName: "Courses")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "noteID":
            if let course = self.selectedCourse {
                let viewController = segue.destination as! CourseDetailViewController
                viewController.setCourse(course: course)
            }
        default:
            break
        }
    }
    
    @objc private func refreshData(_ sender: Any) {
        self.getCourses()
        self.refreshControl.endRefreshing()
    }
    
    func setPeriod(period: Period) {
        self.period = period
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.courses.count
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
        let course = self.courses[indexPath.section]

        let cell = tableView.dequeueReusableCell(withIdentifier: "courseTableCell", for: indexPath) as! CourseTableViewCell
        cell.nameLabel.text = course.name

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCourse = self.courses[indexPath.section]
        self.performSegue(withIdentifier: "noteID", sender: nil)
    }
    
    private func addDelegate() {
        self.courseTableView.delegate = self
        self.courseTableView.dataSource = self
    }
    
    private func getCourses() {
        self.coursePresenter.getCourses(period: self.period) { (courses) in
            self.courses = courses
            self.courseTableView.reloadData()
        }
    }
}
