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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        CoreDataService().saveData()
    }
    
    @objc private func refreshData(_ sender: Any) {
        self.refreshControl.endRefreshing()
    }
    
    @objc func noteSliderValueChanged(_ sender: LargeSlider) {
        let value = round(sender.value * 20) / 20
        sender.setValue(value, animated: true)
        
        let note = self.notes[sender.tag]
        note.value = Double(value)
        
        self.calcWeight()
        sender.isWarningMode(isWarningMode: note.value < (note.noteTemplate?.weight)!)
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
        
        cell.noteSlider.tag = indexPath.section
        cell.noteSlider.isWarningMode(isWarningMode: note.value < (note.noteTemplate?.weight)!)
        cell.noteSlider.maximumValue = Float(note.noteTemplate?.max ?? 0)
        cell.noteSlider.setValue(self.notePresenter.getProgress(note: note), animated: true)
        cell.noteSlider.addTarget(self, action: #selector(self.noteSliderValueChanged(_:)), for: .valueChanged)
        
        return cell
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
