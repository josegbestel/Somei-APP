//
//  CreditAndDebitViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 04/10/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit

class CreditAndDebitViewController: ViewController {

    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var creditNumberLabel: UILabel!
    @IBOutlet weak var debitNumberView: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewLaout()
        if ProfissionalManager.sharedInstance.profissional.email != nil, ProfissionalManager.sharedInstance.profissional.password != nil, ProfissionalManager.sharedInstance.profissional.id != nil {
            ProviderSomei.requestMouthExtract(id: String(ProfissionalManager.sharedInstance.profissional.id!), email: ProfissionalManager.sharedInstance.profissional.email!, password: ProfissionalManager.sharedInstance.profissional.password!) {success in
                DispatchQueue.main.async {
                    self.completeInformation()
                }
             }
        }
    }
    
    func completeInformation() {
        tableView.reloadData()
        debitNumberView.text = "R$ \(calculateDebit())"
        creditNumberLabel.text = "R$ \(calculateCredit())"
    }
    
    func calculateDebit() -> Double {
        var valor:Double = 0
        for extract in FinancialManager.sharedInstance.extractRequestArray {
            if extract.valor ?? 0 > 0 {
                valor += extract.valor ?? 0
            }
        }
        return valor
    }
    
    func calculateCredit() -> Double {
        var valor:Double = 0
        for extract in FinancialManager.sharedInstance.extractRequestArray {
            if extract.valor ?? 0 < 0 {
                valor += extract.valor ?? 0
            }
        }
        return valor
    }
    
    func configureViewLaout() {
        borderView.clipsToBounds = false
        borderView.backgroundColor = UIColor.white
        borderView.layer.shadowColor = UIColor.black.cgColor
        borderView.layer.shadowOpacity = 2.14
        borderView.layer.shadowOffset = .zero
        borderView.layer.shadowRadius = 0.5
        borderView.layer.cornerRadius = 10
    }
    
    func setColor(valor:Double) -> UIColor {
        if valor > 0 {
            return UIColor.init(red: 93.0/255.0, green: 199.0/255.0, blue: 112.0/255.0, alpha: 1.0)
        }
        if valor < 0 {
            return UIColor.init(red: 218.0/255.0, green: 95.0/255.0, blue: 82.0/255.0, alpha: 1.0)
        }
        return UIColor.init(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerDespesaButton(_ sender: Any) {
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "NewDespesaViewController")
        self.definesPresentationContext = true
        newVC?.modalPresentationStyle = .overCurrentContext
        self.present(newVC!, animated: true, completion: nil)
    }

}
extension CreditAndDebitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FinancialManager.sharedInstance.extractRequestArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! CreditAndDebitTableViewCell
        let value = FinancialManager.sharedInstance.extractRequestArray[indexPath.row]
        
        cell.nomeLabel.text = value.descricao
        cell.dataLabel.text = "\(value.dtVencimento?.day ?? 0)/\(value.dtVencimento?.mounth ?? 0)/\(value.dtVencimento?.year ?? 0)"
        cell.valorLabel.text = "R$ \(value.valor ?? 0)"
        cell.valorLabel.backgroundColor = setColor(valor: value.valor ?? 0 )
        cell.valorLabel.cornerRadius = 8
        
        return cell
    }
}
extension CreditAndDebitViewController: UITableViewDelegate {
    
}
