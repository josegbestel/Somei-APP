//
//  SelectMultiHourViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 11/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class SelectMultiHourViewController: ViewController, UITextFieldDelegate {

    @IBOutlet weak var daySegmentedControl: UISegmentedControl!
    @IBOutlet weak var firstHourTextField: UITextField!
    @IBOutlet weak var secondHourTextField: UITextField!
    
    var agendaDay:Agenda = Agenda(horaInicio: nil, horaFinal: nil, diaSemana: nil, dinamica: nil, id: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstHourTextField.delegate = self
        secondHourTextField.delegate = self
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SelectMultiHourViewController.dismissKeyboard)))
    }
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)

//       if let firstVC = presentingViewController as? FlexibleHourViewController {
//           DispatchQueue.main.async {
//               firstVC.tableView.reloadData()
//           }
//       }
     }
    
    @IBAction func selctDay(_ sender: Any) {
        switch daySegmentedControl.selectedSegmentIndex {
        case 0:
            print("Domingo")
            agendaDay.diaSemana = "DOM"
        case 1:
            print("Segunda")
            agendaDay.diaSemana = "SEG"
        case 2:
            print("Terça")
            agendaDay.diaSemana = "TER"
        case 3:
            print("Quarta")
            agendaDay.diaSemana = "QUA"
        case 4:
            print("Quinta")
            agendaDay.diaSemana = "QUI"
        case 5:
            print("Sexta")
            agendaDay.diaSemana = "SEX"
        case 6:
            print("Sabado")
            agendaDay.diaSemana = "SAB"
        default:
            break;
        }
    }
    func showEmptyInformation() {
        func showEmptyText() {
           let alert = UIAlertController(title: "", message: "Campo vazio!", preferredStyle: .alert)
           let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
           })
           alert.addAction(ok)
           self.present(alert, animated: true)
       }
    }
    
    //MARK: Função de controle do teclado
       func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SelectMultiHourViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
      }
      @objc func dismissKeyboard() {
            self.view.endEditing(true)
      }
    
    func separeString(horario:String) -> HourStruct {
        let newHour = String(horario.prefix(2))
        let newMinute = String(horario.suffix(2))
//        let hour = HourStruct(hour: Double(newHour),minute: Double(newMinute))
        let hour = HourStruct(hour: newHour, minute: newMinute)
        return hour
    }
    
    @IBAction func okButton(_ sender: Any) {
        if firstHourTextField.text != "", secondHourTextField.text != "" {
            agendaDay.horaInicio = separeString(horario:firstHourTextField.text ?? "00")
            agendaDay.horaFinal = separeString(horario:secondHourTextField.text ?? "00")
            agendaDay.dinamica = true
            OrcamentoManager.sharedInstance.agendaArray.insert(agendaDay, at: 0)
            print(OrcamentoManager.sharedInstance.agendaArray.count)
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newNavigation = storyBoard.instantiateViewController(withIdentifier: "HourTimeViewController")
            self.present(newNavigation, animated: true, completion: nil)
        }else {
            showEmptyInformation()
        }
    }
 
    //MARK:UITextFieldDelegate
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var appendString = ""
        if range.length == 0 {
            switch range.location {
            case 2:
                appendString = ":"
            default:
                break
            }
        }

        textField.text?.append(appendString)

        return true
    }
}
