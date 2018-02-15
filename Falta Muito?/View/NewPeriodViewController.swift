//
//  NewPeriodViewController.swift
//  Falta Muito?
//
//  Created by Jose Neves on 07/02/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import UIKit

class NewPeriodViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var coursesTextField: UITextField!
    @IBOutlet weak var averageTextField: UITextField!
    @IBOutlet weak var maxTextField: UITextField!
    
    private var periodPresenter: PeriodPresenter!
    private var period: Period!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.periodPresenter = PeriodPresenter()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "coursesID":
            let viewController = segue.destination as! SetCoursesViewController
            viewController.setPeriod(period: self.period)
        default:
            break
        }
    }
    
    @IBAction func nextScreenAction(_ sender: Any) {
        if (!self.isValidData()) {
            return
        }
        
        let name = self.nameTextField.text ?? ""
        let courses = Int(self.coursesTextField.text ?? "") ?? 0
        let averageNote = Double(self.averageTextField.text ?? "") ?? 0
        let maxNote = Double(self.averageTextField.text ?? "") ?? 0
        
        self.period = self.periodPresenter.savePeriod(name: name, courses: courses, averageNote: averageNote, maxNote: maxNote)
        self.performSegue(withIdentifier: "coursesID", sender: nil)
    }
    
    private func isValidData() -> Bool {
        let name = self.nameTextField.text ?? ""
        let courses = Int(self.coursesTextField.text ?? "") ?? 0
        let average = Int(self.averageTextField.text ?? "") ?? 0
        let max = Int(self.maxTextField.text ?? "") ?? 0
        
        if (name == "" || courses < 1 || average < 1 || max < 1) {
            self.alertUser(title: "Ops...", message: "Preencha todos os campos!")
            return false
        }
        
        if (max < average) {
            self.alertUser(title: "Ops...", message: "Geralmente a média é menos que a nota máxima, não?")
            return false
        }
        
        return true
    }
    
    private func alertUser(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            
        self.present(alert, animated: true, completion: nil)
    }
}
