//
//  FlexibleHourViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 11/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class FlexibleHourViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var segmentedDayControl: UISegmentedControl!
    
    var agenda:Agenda = Agenda(horaInicio: nil, horaFinal: nil, diaSemana: nil, dinamica: nil, id: nil)
    
    @IBOutlet weak var tfFirstHour: UITextField!
    @IBOutlet weak var tfSecondHour: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfFirstHour.delegate = self
        tfSecondHour.delegate = self
        agenda.dinamica = true
        agenda.diaSemana = "DOM"
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FlexibleHourViewController.dismissKeyboard)))
    }
    
    @IBAction func seletedDayAction(_ sender: Any) {
        switch segmentedDayControl.selectedSegmentIndex {
       
         case 1:
            agenda.diaSemana = "SEG"
         case 2:
            agenda.diaSemana = "TER"
         case 3:
            agenda.diaSemana = "QUA"
         case 4:
            agenda.diaSemana = "QUI"
         case 5:
            agenda.diaSemana = "SEX"
         case 6:
            agenda.diaSemana = "SAB"
         case 0:
            agenda.diaSemana = "DOM"
         default:
            agenda.diaSemana = "DOM"
         }
    }
    
    func separeString(horario:String) -> HourStruct {
        let newHour = String(horario.prefix(2))
        let newMinute = String(horario.suffix(2))
        let hour = HourStruct(hour: newHour, minute: newMinute)
        return hour
    }
    
    //MARK: Função de controle do teclado
       func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FlexibleHourViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
      }
      @objc func dismissKeyboard() {
            self.view.endEditing(true)
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
    
    func popUpError() {
        let alert = UIAlertController(title: "Ops! Tivemos um problema", message: "Por favor verifique os dados informados e tente novamente", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Deixa Comigo!", style: .default, handler: { action in
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    @IBAction func tfFistHourSelected(_ sender: Any) {
        if tfFirstHour.text?.count != 0 {
            agenda.horaInicio = separeString(horario: tfFirstHour.text!)
        }
    }
    
    @IBAction func tfSecondHourSelected(_ sender: Any) {
        if tfSecondHour.text?.count != 0 {
            agenda.horaFinal = separeString(horario: tfSecondHour.text!)
            if !saveAgendaSuccess() {
                popUpError()
            }
        }
    }
    
    //MARK:UITextFieldDelegate
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var appendString = ""
        if range.length == 0 {
            switch range.location {
            case 2:
                appendString = ":"
            case 5:
                dismissKeyboard()
            default:
                break
            }
        }

        textField.text?.append(appendString)

        return true
    }
    
}

