//
//  especificTimeViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 11/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit
import YYCalendar

class EspecificTimeViewController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var textFieldHour: UITextField!
    @IBOutlet weak var textFieldMinute: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissKeyboard() {
         self.view.endEditing(true)
     }
    
    @IBAction func dateActionCalendar() {
        DispatchQueue.main.async {
            let calendar = YYCalendar(normalCalendarLangType: .ENG, date: "14/09/2020", format: "dd/mm/yyyy") { date in
                    self.dateTextField.text = date
                    OrcamentoManager.sharedInstance.agendaFixa.dinamica = false
                    OrcamentoManager.sharedInstance.agendaFixa.diaSemana = date
            }
           calendar.show()
        }
    }
    func separeString(horario:String) -> HourStruct {
        let newHour = String(horario.prefix(2))
        let newMinute = String(horario.suffix(2))
//        let hour = HourStruct(hour: Double(newHour),minute: Double(newMinute))
        let hour = HourStruct(hour: newHour, minute: newMinute)
        return hour
    }

    @IBAction func minuteEndEdition(_ sender: Any) {
         OrcamentoManager.sharedInstance.agendaFixa.horaInicio = separeString(horario: "\(textFieldHour.text ?? ""):\(textFieldMinute.text ?? "")")
//        OrcamentoManager.sharedInstance.day.hourBegin = "\(textFieldHour.text ?? ""):\(textFieldMinute.text ?? "")"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
