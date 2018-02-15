//
//  SetNotesViewController.swift
//  Falta Muito?
//
//  Created by Jose Neves on 09/02/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import UIKit

class SetNotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var maxTextField: UITextField!
    @IBOutlet weak var noteTableView: UITableView!
    
    private var notes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.noteTableView.register(UINib(nibName: "NoteTableCell", bundle: nil), forCellReuseIdentifier: "noteTableCell")
        
        self.addDelegate()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if (self.notes.count > 0) {
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
        
        if (noteName != "") {
            self.notes.append(noteName)
            self.noteTableView.reloadData()
        }
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteTableCell", for: indexPath) as! NoteTableViewCell
        cell.evaluationLabel.text = self.notes[indexPath.section]
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
        
    }
    
    private func addDelegate() -> Void {
        self.noteTableView.delegate = self
        self.noteTableView.dataSource = self
    }
}
