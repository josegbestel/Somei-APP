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
        
    }
    
    func configureViewLaout() {
        borderView.clipsToBounds = false
        borderView.backgroundColor = UIColor.white
        borderView.layer.shadowColor = UIColor.black.cgColor
        borderView.layer.shadowOpacity = 2.14
        borderView.layer.shadowOffset = .zero
        borderView.layer.shadowRadius = 3
        borderView.layer.cornerRadius = 10
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerDespesaButton(_ sender: Any) {
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginCadastroViewControlller")
        self.definesPresentationContext = true
        newVC?.modalPresentationStyle = .overCurrentContext
        self.present(newVC!, animated: true, completion: nil)
    }

}
extension CreditAndDebitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! CreditAndDebitTableViewCell
        cell.nomeLabel.text = "NOME"
        cell.dataLabel.text = "Data"
        cell.valorLabel.text = "VALOR"
        cell.valorLabel.backgroundColor = UIColor.init(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        cell.valorLabel.cornerRadius = 8
        return cell
    }
}
extension CreditAndDebitViewController: UITableViewDelegate {
    
}
