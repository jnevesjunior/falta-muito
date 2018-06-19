//
//  CourseDetailViewController.swift
//  Falta Muito?
//
//  Created by Jose Neves on 04/04/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import UIKit
import UICircularProgressRing

class CourseDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var noteDetailTableView: UITableView!
    @IBOutlet weak var weightCircularProgress: UICircularProgressRingView!
    
    private let refreshControl = UIRefreshControl()
    private var course: Course!
    private var notePresenter: NotePresenter!
    private var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.notePresenter = NotePresenter()
        
        self.noteDetailTableView.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(self.refreshData(_:)), for: .valueChanged)
        
        self.noteDetailTableView.register(UINib(nibName: "NoteDetailTableCell", bundle: nil), forCellReuseIdentifier: "noteDetailTableCell")
        
        self.weightCircularProgress.maxValue = CGFloat((self.course.period?.maxNote)!)
        
        self.addDelegate()
        self.getNotes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AnalyticsService().addTrackerToScreen(screenName: "Course Detail")
    }
    
    @objc private func refreshData(_ sender: Any) {
        self.refreshControl.endRefreshing()
    }
    
    func setCourse(course: Course) {
        self.course = course
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.notes.count
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
        let note = self.notes[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteDetailTableCell", for: indexPath) as! NoteDetailTableViewCell
        cell.nameLabel.text = note.noteTemplate?.name
        cell.noteProgressView.setProgress(self.notePresenter.getProgress(note: note), animated: true)
        cell.isWarningMode(isWarningMode: note.value < (note.noteTemplate?.weight)!)
        cell.valueLabel.text = String(format: "%.2f", note.value)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = self.notes[indexPath.section]
        let alert = UIAlertController(title: note.noteTemplate?.name, message: "Quanto você tirou nessa avaliação?", preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "Salvar", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            let noteValue = Double(textField.text ?? "") ?? 0
            
            if (noteValue <= Double((self.course.period?.maxNote)!)) {
                self.notes[indexPath.section].value = noteValue
                self.calcWeight()
                self.noteDetailTableView.reloadData()
                CoreDataService().saveData()
            }
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "Digite a sua nota"
            textField.keyboardType = .decimalPad
            textField.text = "\(note.value)"
        }
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func addDelegate() {
        self.noteDetailTableView.delegate = self
        self.noteDetailTableView.dataSource = self
    }
    
    private func getNotes() {
        self.notePresenter.getNotes(course: self.course) { (notes) in
            self.notes = notes
            self.calcWeight()
            self.noteDetailTableView.reloadData()
        }
    }
    
    private func calcWeight() {
        self.setWeight(weight: self.notePresenter.calcWeight(notes: self.notes))
    }
    
    private func setWeight(weight: Double) {
        self.weightCircularProgress.setProgress(to: CGFloat(weight), duration: 1.0)
        
        if (weight < (self.course.period?.averageNote)!) {
            self.weightCircularProgress.innerRingColor = UIColor.red
        } else {
            self.weightCircularProgress.innerRingColor = UIColor(red: 1.0, green: 0.75, blue: 0.27, alpha: 1.0)
        }
    }
}
