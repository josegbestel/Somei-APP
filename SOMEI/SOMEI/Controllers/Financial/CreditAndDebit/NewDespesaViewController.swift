//
//  NewDespesaViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 04/10/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit
import YYCalendar

class NewDespesaViewController: UIViewController {

    @IBOutlet weak var despesaValue: UITextField!
    @IBOutlet weak var despesaDescription: UITextField!
    @IBOutlet weak var dateSelected: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NewDespesaViewController.dismissKeyboard)))
       
    }
    
    @objc func dismissKeyboard() {
          self.view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAround() {
          let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewDespesaViewController.dismissKeyboard))
          tap.cancelsTouchesInView = false
          view.addGestureRecognizer(tap)
    }

    @IBAction func dateSelectedButton(_ sender: Any) {
        DispatchQueue.main.async {
            let calendar = YYCalendar(normalCalendarLangType: .ENG, date: "05/11/2020", format: "dd/mm/yyyy") { date in
                self.dateSelected.text = date
            }
           calendar.show()
        }
    }
    
}

