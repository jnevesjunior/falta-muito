//
//  SetNoteTemplateViewController.swift
//  Falta Muito?
//
//  Created by Jose Neves on 10/04/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import UIKit

class SetNoteTemplateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var noteTemplateTableView: UITableView!
    
    private var period = [String: Any]()
    private var courses = [String]()
    private var periodPresenter: PeriodPresenter!
    private var coursePresenter: CoursePresenter!
    private var notePresenter: NotePresenter!
    private var noteTemplatePresenter: NoteTemplatePresenter!
    private var noteTemplates = [NoteTemplate]()
    private var selectedNoteTemplates = [NoteTemplate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.periodPresenter = PeriodPresenter()
        self.coursePresenter = CoursePresenter()
        self.notePresenter = NotePresenter()
        self.noteTemplatePresenter = NoteTemplatePresenter()
        
        self.noteTemplateTableView.register(UINib(nibName: "NoteTemplateTableCell", bundle: nil), forCellReuseIdentifier: "noteTemplateTableCell")
        
        self.getNoteTemplates()
        self.addDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AnalyticsService().addTrackerToScreen(screenName: "Set Note Template")
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if (self.selectedNoteTemplates.count > 0) {
            let periodEntity = self.periodPresenter.savePeriod(period: self.period)
            let courses = self.coursePresenter.saveCourses(courses: self.courses, period: periodEntity)
            _ = self.notePresenter.saveNotes(noteTemplates: self.selectedNoteTemplates, courses: courses)
            
            self.performSegue(withIdentifier: "homeID", sender: nil)
        }
        else {
            let alert = UIAlertController(title: "Ops...", message: "Acho que você tem pelo menos uma avaliação, não?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func setPeriod(period: [String: Any]) -> Void {
        self.period = period
    }
    
    func setCourses(courses: [String]) -> Void {
        self.courses = courses
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let lines = self.noteTemplates.count
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
        
        self.noteTemplateTableView.backgroundView = backgroundView
        
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
        let noteTemplate = self.noteTemplates[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteTemplateTableCell", for: indexPath) as! NoteTemplateTableViewCell
        cell.nameLabel.text = noteTemplate.name
        cell.maxLabel.text = String(noteTemplate.max)
        cell.weightLabel.text = String(noteTemplate.weight)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedNoteTemplates.append(self.noteTemplates[indexPath.section])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let index = self.selectedNoteTemplates.index(of: self.noteTemplates[indexPath.section]) {
            self.selectedNoteTemplates.remove(at: index)
        }
    }
    
    private func getNoteTemplates() {
        self.noteTemplatePresenter.getNotesTemplates() { (noteTemplates) in
            self.noteTemplates = noteTemplates
            self.noteTemplateTableView.reloadData()
        }
    }
    
    private func addDelegate() -> Void {
        self.noteTemplateTableView.delegate = self
        self.noteTemplateTableView.dataSource = self
    }
}
