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
    @IBOutlet weak var choiceDebitOrCredit: UISegmentedControl!
    
    var debitOrCreditVar:String = "Debito"
    var valorToLib:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NewDespesaViewController.dismissKeyboard)))
       
    }
    
    func inputInformationPopUp() {
        let alert = UIAlertController(title: "", message: "Por favor verifique os dados informados", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    @IBAction func debitAndCreditSelected(_ sender: Any) {
        switch choiceDebitOrCredit.selectedSegmentIndex {
         case 0:
            debitOrCreditVar = "Debito"
         case 1:
            debitOrCreditVar = "Credito"
         default:
            debitOrCreditVar = "Debito"
         }
    }
    
    func fixValueIfDebitOrCredit() {
        if debitOrCreditVar == "Credito" {
            var readValue = ""
            readValue.append("-")
            readValue.append("\(despesaValue.text ?? "0")")
            valorToLib = Double(readValue) ?? 0
        }else{
            valorToLib = Double(despesaValue.text ?? "0") ?? 0
        }
    }
    
    func dayOfVencimento() -> Int {
        
    }
    
    func mounthOfVencimento() -> Int {
        
    }
    
    func yearOfVencimento() -> Int {
        
    }
    
    func createStruct() -> PostingValueStruct {
        
        let vencimentoStruct:DtVencimentoStruct = DtVencimentoStruct.init(day: dayOfVencimento() ,mounth:mounthOfVencimento() ,year: yearOfVencimento())
        
        let value:PostingValueStruct = PostingValueStruct.init(valor:valorToLib, descricao:despesaDescription.text, fixa:false, dtVencimento:vencimentoStruct)
        
        return value
    }
    
    func completeSaveLib() {
        if ProfissionalManager.sharedInstance.profissional.email != nil, ProfissionalManager.sharedInstance.profissional.password != nil, ProfissionalManager.sharedInstance.profissional.id != nil {
            ProviderSomei.sendNewLancamento(lancamento: createStruct(), id: String(ProfissionalManager.sharedInstance.profissional.id!), email: ProfissionalManager.sharedInstance.profissional.email!, password: ProfissionalManager.sharedInstance.profissional.password!) {success in
                //complete flow
             }
        }
    }
    
    @objc func dismissKeyboard() {
          self.view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAround() {
          let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewDespesaViewController.dismissKeyboard))
          tap.cancelsTouchesInView = false
          view.addGestureRecognizer(tap)
    }
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dateSelectedButton(_ sender: Any) {
        DispatchQueue.main.async {
            let calendar = YYCalendar(normalCalendarLangType: .ENG, date: "05/11/2020", format: "dd/mm/yyyy") { date in
                self.dateSelected.text = date
            }
           calendar.show()
        }
    }
    @IBAction func saveButton(_ sender: Any) {
        if despesaValue.text?.count != 0,despesaDescription.text?.count != 0,dateSelected.text?.count != 0 {
            fixValueIfDebitOrCredit()
            completeSaveLib()
        }else{
            inputInformationPopUp()
        }
    }
    
}

