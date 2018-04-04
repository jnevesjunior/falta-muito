//
//  CourseDetailViewController.swift
//  Falta Muito?
//
//  Created by Jose Neves on 04/04/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import UIKit

class CourseDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var noteDetailTableView: UITableView!
    
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
        
        self.addDelegate()
        self.getNotes()
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
        cell.nameLabel.text = note.name
        
        return cell
    }
    
    private func addDelegate() {
        self.noteDetailTableView.delegate = self
        self.noteDetailTableView.dataSource = self
    }
    
    private func getNotes() {
        self.notePresenter.getNotes(course: self.course) { (notes) in
            self.notes = notes
            self.noteDetailTableView.reloadData()
        }
    }
}
