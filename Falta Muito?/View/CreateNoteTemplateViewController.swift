//
//  CreateNoteTemplateViewController.swift
//  Falta Muito?
//
//  Created by Jose Neves on 09/02/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import UIKit

class CreateNoteTemplateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var maxTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var noteTableView: UITableView!
    
    private var period = [String: Any]()
    private var courses = [String]()
    private var notes = [[String: Any]]()
    private var periodPresenter: PeriodPresenter!
    private var coursePresenter: CoursePresenter!
    private var notePresenter: NotePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.periodPresenter = PeriodPresenter()
        self.coursePresenter = CoursePresenter()
        self.notePresenter = NotePresenter()
        self.noteTableView.register(UINib(nibName: "NoteTableCell", bundle: nil), forCellReuseIdentifier: "noteTableCell")
        
        self.addDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AnalyticsService().addTrackerToScreen(screenName: "Create Note Template")
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if (self.notes.count > 0) {
            let periodEntity = self.periodPresenter.savePeriod(period: self.period)
            let courses = self.coursePresenter.saveCourses(courses: self.courses, period: periodEntity)
//            _ = self.notePresenter.saveNotes(notes: self.notes, courses: courses)
            self.performSegue(withIdentifier: "homeID", sender: nil)
        }
        else {
            let alert = UIAlertController(title: "Ops...", message: "Acho que você tem pelo menos uma matéria, não?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func addNoteAction(_ sender: Any) {
        let noteName = self.nameTextField.text ?? ""
        let maxNote = Int(self.maxTextField.text ?? "") ?? 0
        let noteWeight = Int(self.weightTextField.text ?? "") ?? 0
        
        if (noteName != "" && maxNote > 0 && noteWeight > 0) {
            var noteArray = [String: Any]()
            noteArray["name"] = noteName
            noteArray["max"] = maxNote
            noteArray["weight"] = noteWeight
            
            self.notes.append(noteArray)
            self.noteTableView.reloadData()
        }
    }
    
    func setPeriod(period: [String: Any]) -> Void {
        self.period = period
    }
    
    func setCourses(courses: [String]) -> Void {
        self.courses = courses
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let lines = self.notes.count
        var backgroundView = UIView()
        
        if (lines == 0) {
            let message = UILabel()
            message.textColor = UIColor.darkGray
            message.text = """
            Clique em + para cadastrar como você é avaliado(a) ex:
            
            Avaliação Intermediária
            Avaliação Continuada
            Avaliação Semestral
            """
            message.textAlignment = .center
            message.numberOfLines = 7
            
            backgroundView = message
        }
        
        self.noteTableView.backgroundView = backgroundView
        
        return lines
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteTableCell", for: indexPath) as! NoteTableViewCell
        if let noteName = self.notes[indexPath.section]["name"] as? String {
            cell.evaluationLabel.text = noteName
        }
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let closeAction = UIContextualAction(style: .destructive, title:  "❌", handler: { (ac: UIContextualAction, view: UIView, success) in
            self.notes.remove(at: indexPath.section)
            self.noteTableView.reloadData()
            success(true)
        })
        closeAction.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        
        return UISwipeActionsConfiguration(actions: [closeAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    private func addDelegate() -> Void {
        self.noteTableView.delegate = self
        self.noteTableView.dataSource = self
    }
}
