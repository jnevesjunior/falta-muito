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
    
    private var period = [String: Any]()
    private var courses = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addDelegate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "noteTemplateID":
            let viewController = segue.destination as! SetNoteTemplateViewController
            viewController.setPeriod(period: self.period)
            viewController.setCourses(courses: self.courses)
        default:
            break
        }
    }
    
    @IBAction func nextScreenAction(_ sender: Any) {
        self.performSegue(withIdentifier: "noteTemplateID", sender: nil)
    }
    
    func setPeriod(period: [String: Any]) -> Void {
        self.period = period
        
        if let courses = period["courses"] as? Int {
            for i in 0..<courses {
                self.courses.insert("Matéria \(i + 1)", at: Int(i))
            }
        }
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath)
        cell.textLabel?.text = self.courses[indexPath.section]
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.selectionStyle = .none
        
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
        let alert = UIAlertController(title: self.courses[indexPath.section], message: "Dê um nome para essa matéria", preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "Salvar", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            let courseName = textField.text ?? ""
            
            if (courseName != "") {
                self.courses[indexPath.section] = courseName
                self.courseTableView.reloadData()
            }
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Digite o nome da matéria"
        }
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func addDelegate() -> Void {
        self.courseTableView.delegate = self
        self.courseTableView.dataSource = self
    }
}
