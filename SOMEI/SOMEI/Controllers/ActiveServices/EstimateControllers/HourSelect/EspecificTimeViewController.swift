//
//  especificTimeViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 11/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit
import YYCalendar

class EspecificTimeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var textFieldHour: UITextField!
    @IBOutlet weak var textFieldMinute: UITextField!
    
    var agenda:Agenda = Agenda(horaInicio: nil, horaFinal: nil, diaSemana: nil, dinamica: nil, id: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        agenda.dinamica = false
        dateTextField.delegate = self
        textFieldHour.delegate = self
        textFieldMinute.delegate = self
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(EspecificTimeViewController.dismissKeyboard)))
    }
    
    //MARK: Função de controle do teclado
       func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EspecificTimeViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
      }
    
      @objc func dismissKeyboard() {
            self.view.endEditing(true)
      }
    
    @objc func dissmisKeyboardAndSaveDate(){
        self.view.endEditing(true)
        shoulSaveData()
    }
    
    @IBAction func dateActionCalendar() {
        DispatchQueue.main.async {
            let calendar = YYCalendar(normalCalendarLangType: .ENG, date: "14/11/2020", format: "dd/mm/yyyy") { date in
                self.dateTextField.text = date
                self.agenda.diaSemana = date
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
    
    func informationError() {
        let alert = UIAlertController(title: "Ops! Tivemos um problema", message: "Por favor verifique os dados informados e tente novamente", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Deixa Comigo!", style: .default, handler: { action in
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    func saveAgendaSuccess() -> Bool {
        if agenda.diaSemana != nil {
            if agenda.dinamica != nil {
                if agenda.horaFinal != nil {
                    if agenda.horaInicio != nil {
                        OrcamentoManager.sharedInstance.agendaArray.insert(agenda, at: 0)
                        return true
                    }
                }
            }
        }
        return false
    }
    
    func shoulSaveData() {
        print(dateTextField.text?.count)
        print(textFieldHour.text?.count)
        print(textFieldMinute.text?.count)
        if dateTextField.text?.count == 10,textFieldHour.text?.count == 5, textFieldMinute.text?.count == 5 {
            if !saveAgendaSuccess() {
                informationError()
            }
        }else{
            informationError()
        }
    }

    @IBAction func minuteEndEdition(_ sender: Any) {
        if textFieldMinute.text!.count > 0, textFieldHour.text!.count > 0 {
            agenda.diaSemana = dateTextField.text!
            agenda.horaInicio = separeString(horario: textFieldHour.text!)
            agenda.horaFinal = separeString(horario: textFieldMinute.text!)
            shoulSaveData()
        }else{
            informationError()
        }
    }
    
    //MARK:UITextFieldDelegate
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == textFieldHour || textField == textFieldMinute {
            
            var appendString = ""
            if range.length == 0 {
                switch range.location {
                case 2:
                    appendString = ":"
                case 5:
                    dissmisKeyboardAndSaveDate()
                default:
                    break
                }
            }

            textField.text?.append(appendString)
        }else{
            //"dd/mm/yyyy"
            if textField == dateTextField {
                var appendString = ""
                if range.length == 0 {
                    switch range.location {
                    case 2:
                        appendString = "/"
                    case 5:
                        appendString = "/"
                    case 10:
                        dissmisKeyboardAndSaveDate()
                    default:
                        break
                    }
                }

                textField.text?.append(appendString)
            }
        }
        return true
    }

}
