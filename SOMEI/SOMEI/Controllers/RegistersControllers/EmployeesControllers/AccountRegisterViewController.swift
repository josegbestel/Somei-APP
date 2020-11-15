//
//  AccountRegisterViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 08/11/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit

class AccountRegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var agenciaTf: UITextField!
    @IBOutlet weak var contaCorrenteTf: UITextField!
    @IBOutlet weak var typeAccountPickerView: UIPickerView!
    @IBOutlet weak var segmentedTypeAccount: UISegmentedControl!
    
    var pickerData: [String] = []
    var numberAccountType = "1"
    var typeAccount = "POUPANCA"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AccountRegisterViewController.dismissKeyboard)))
        self.typeAccountPickerView.delegate = self
        self.typeAccountPickerView.dataSource = self
        putDatasInArray()
        
    }
    
    @IBAction func typeAccount(_ sender: Any) {
        switch segmentedTypeAccount.selectedSegmentIndex {
         case 0:
            typeAccount = "POUPANCA"
         case 1:
            typeAccount = "CORRENTE"
         default:
            typeAccount = "POUPANCA"
         }
    }
    //MARK: Função de controle do teclado
    func hideKeyboardWhenTappedAround() {
          let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AccountRegisterViewController.dismissKeyboard))
          tap.cancelsTouchesInView = false
          view.addGestureRecognizer(tap)
    }
    
    func failurePopUp() {
        let alert = UIAlertController(title: "", message: "Por favor verifique os dados informados", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    @objc func dismissKeyboard() {
         self.view.endEditing(true)
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func returnDigt() -> String {
        let stringDigt = contaCorrenteTf.text!
        let cleanStr =  stringDigt.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range:nil)
        let count = cleanStr.count
        let account:String = String(cleanStr.dropFirst(count-1))
        return account
    }
    
    func returnConta() -> String {
        let stringDigt = contaCorrenteTf.text!
        let cleanStr =  stringDigt.replacingOccurrences(of: "-", with: "", options: NSString.CompareOptions.literal, range:nil)
        let digit:String = String(cleanStr.dropLast())
        return digit
    }
    
    func createStruct() -> AccountStruct {
        let account:AccountStruct = AccountStruct.init(nBanco:numberAccountType, nAgencia:agenciaTf.text!, nConta:returnConta(), nComplementarConta:returnDigt(), tipoConta:typeAccount)
        return account
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if agenciaTf.hasText,contaCorrenteTf.hasText {
            ProfissionalManager.sharedInstance.profissional.account = createStruct()
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newNavigation = storyBoard.instantiateViewController(withIdentifier: "ConfirmDatasEmployeeViewController")
            self.present(newNavigation, animated: true, completion: nil)
        }else {
            failurePopUp()
        }
    }
    
    override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
    
     }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberAccountType = pickerData[row]
    }
    
    func putDatasInArray() {
        pickerData = [
            "1","237",
            "335",
            "260",
            "290",
            "323",
            "237",
            "637",
            "77",
            "341",
            "104",
            "33",
            "212",
            "756",
            "655",
            "655",
            "41",
            "389",
            "422",
            "70",
            "136",
            "741",
            "739",
            "743",
            "100",
            "96",
            "747",
            "748",
            "752",
            "91",
            "399",
            "108",
            "757",
            "102",
            "348",
            "340",
            "84",
            "180",
            "66",
            "15",
            "143",
            "62",
            "74",
            "99",
            "25",
            "75",
            "40",
            "190",
            "63",
            "191",
            "64",
            "97",
            "16",
            "12",
            "3",
            "60",
            "37",
            "159",
            "172",
            "85",
            "114",
            "36",
            "394",
            "4",
            "320",
            "189",
            "105",
            "76",
            "82",
            "286",
            "93",
            "273",
            "157",
            "183",
            "14",
            "130",
            "127",
            "79",
            "81",
            "118",
            "133",
            "121",
            "83",
            "138",
            "24",
            "95",
            "94",
            "276",
            "137",
            "92",
            "47",
            "144",
            "126",
            "301",
            "173",
            "119",
            "254",
            "268",
            "107",
            "412",
            "124",
            "149",
            "197",
            "142",
            "389",
            "184",
            "634",
            "545",
            "132",
            "298",
            "129",
            "128",
            "194",
            "310",
            "163",
            "280",
            "146",
            "279",
            "182",
            "278",
            "271",
            "21",
            "246",
            "751",
            "208",
            "746",
            "241",
            "612",
            "604",
            "505",
            "196",
            "300",
            "477",
            "266",
            "122",
            "376",
            "473",
            "745",
            "120",
            "265",
            "7",
            "188",
            "134",
            "641",
            "29",
            "243",
            "78",
            "111",
            "17",
            "174",
            "495",
            "125",
            "488",
            "65",
            "492",
            "250",
            "145",
            "494",
            "253",
            "269",
            "213",
            "139",
            "18",
            "630",
            "224",
            "600",
            "623",
            "204",
            "479",
            "456",
            "464",
            "613",
            "652",
            "653",
            "69",
            "370",
            "249",
            "318",
            "626",
            "270",
            "366",
            "113",
            "131",
            "11",
            "611",
            "755",
            "89",
            "643",
            "140",
            "707",
            "288",
            "101",
            "487",
            "233",
            "177",
            "633",
            "218",
            "292",
            "169",
            "293",
            "285",
            "80",
            "753",
            "222",
            "754",
            "98",
            "610",
            "712",
            "10",
            "283",
            "217",
            "117",
            "336",
            "654",
        ]
    }
    
}
