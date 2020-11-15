//
//  BankDepositsViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 04/11/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit

class BankDepositsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saldoDisponivelNumberLabel: UILabel!
    @IBOutlet weak var aLiberarSaldoNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        completeInfos()
    }
    
    func completeInfos() {
        saldoDisponivelNumberLabel.text = "R$ \(FinancialManager.sharedInstance.depositosBancarios.saldoDisponivel ?? 0)"
        aLiberarSaldoNumber.text = "R$ \(FinancialManager.sharedInstance.depositosBancarios.saldoALiberar ?? 0)"
    }
    
    func updateTableView() {
        ProviderSomei.requestReportValues(id: String(ProfissionalManager.sharedInstance.profissional.id!), email: ProfissionalManager.sharedInstance.profissional.email!, password: ProfissionalManager.sharedInstance.profissional.password!) {success in
            if success == true {
                self.tableView.reloadData()
            }
         }
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func errorPopUP() {
        let alert = UIAlertController(title: "Algo deu errado", message: "Por favor tente novamente mais tarde", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    @IBAction func resgatarSaldoButton(_ sender: Any) {
        ProviderSomei.transferBankMoney(valor: "\(FinancialManager.sharedInstance.depositosBancarios.saldoDisponivel ?? 0)" ,idProfissional:"\(ProfissionalManager.sharedInstance.profissional.id ?? 0)", email:"\(ProfissionalManager.sharedInstance.profissional.email ?? "")", password:"\(ProfissionalManager.sharedInstance.profissional.password ?? "")" ) {success in
            if success != true {
                DispatchQueue.main.async {
                    self.errorPopUP()
                }
                }else{
                    DispatchQueue.main.async {
                        self.updateTableView()
                    }
                }
            }
        }
    
}
extension BankDepositsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FinancialManager.sharedInstance.depositosBancarios.historico?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! DepositsTableViewCell
        let value = FinancialManager.sharedInstance.depositosBancarios.historico?[indexPath.row]
        
        if let day = value?.dia {
            cell.dateLabel.text = day
        }else{
            cell.dateLabel.isHidden = true
        }
        cell.valueLabel.text = "\(value?.valor ?? 0)"
        
        return cell
    }
}
extension BankDepositsViewController: UITableViewDelegate {
    
}
