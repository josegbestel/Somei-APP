//
//  HourTimeViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 11/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class HourTimeViewController: UIViewController {

    @IBOutlet weak var professionalLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if OrcamentoManager.sharedInstance.selectedProfission != nil {
           professionalLabel.text = OrcamentoManager.sharedInstance.selectedProfission
        }
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func newHour(_ sender: Any) {

    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButton(_ sender: Any) {
        OrcamentoManager.sharedInstance.completeOrcamento(){(error) -> Void in
            if error == true {
                DispatchQueue.main.async {
                     let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                     let newNavigation = storyBoard.instantiateViewController(withIdentifier: "OrcamentoConslusion")
                     self.present(newNavigation, animated: true, completion: nil)
                }
            }else {
                //TODO:error flow
            }
        }
    }
}
extension HourTimeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrcamentoManager.sharedInstance.agendaArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! requestedServicesTableViewCell
        let orcamento = OrcamentoManager.sharedInstance.servicesRequestArray[indexPath.row]
        
        cell.clipsToBounds = true
        cell.borderView.backgroundColor = UIColor.white
        cell.borderView.layer.shadowColor = UIColor.black.cgColor
        cell.borderView.layer.shadowOpacity = 0.24
        cell.borderView.layer.shadowOffset = .zero
        cell.borderView.layer.shadowRadius = 3
        cell.borderView.layer.cornerRadius = 10
        
        cell.dateLabel.isHidden = true
        cell.descriptionLabel.text = orcamento.descricao
        cell.setStatus(status: orcamento.status ?? "")
        cell.professionalLabel.text = orcamento.profissao
        
        return cell
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       OrcamentoManager.sharedInstance.selectedOrcamentoToRequestService = OrcamentoManager.sharedInstance.servicesRequestArray[indexPath.row]
   }
}
extension HourTimeViewController: UITableViewDelegate {
    
}
