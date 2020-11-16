//
//  FinancialReportingViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 04/10/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit

class FinancialReportingViewController: UIViewController {

    //Actual Mouth reporting
    @IBOutlet weak var actualMouthView: UIView!
    @IBOutlet weak var saldoAtualNumber: UILabel!
    @IBOutlet weak var metaMensalNumber: UILabel!
    @IBOutlet weak var previsaoMensal: UILabel!
    //profit margin
    @IBOutlet weak var profitMargin: UIView!
    @IBOutlet weak var percentlabel: UILabel!
    //Bank deposit
    @IBOutlet weak var bankDepositView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var NoDepositsLabel: UILabel!
    //Credit and debit
    @IBOutlet weak var creditAndDebitView: UIView!
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var debitLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayoutView()
        completeInformation()
    }
    
    func completeInformation() {
        completeInformationMouthsResults()
        completeProfitMargin()
        completeBankDeposit()
        completeCreditAndDebit()
    }
    
    func completeCreditAndDebit() {
        creditLabel.text = "R$ \(FinancialManager.sharedInstance.calculateCredit())"
        debitLabel.text = "R$ \(FinancialManager.sharedInstance.calculateDedit())"
    }
    
    func completeBankDeposit() {
        NoDepositsLabel.isHidden = true
        let lastDeposit = FinancialManager.sharedInstance.lastDeposit()
        if lastDeposit.historico?.last != nil {
            dateLabel.text = lastDeposit.historico?.last?.dia
        }else{
            dateLabel.isHidden = true
        }
        if lastDeposit.historico?.last != nil {
            priceLabel.text = "R$\(lastDeposit.historico?.last?.valor ?? 0)"
        }else{
            priceLabel.isHidden = true
        }
        
        if priceLabel.isHidden == true, dateLabel.isHidden == true {
            NoDepositsLabel.isHidden = false
            NoDepositsLabel.text = "Sem novos depositos, Saldo disponivel: R$ \(FinancialManager.sharedInstance.depositosBancarios.saldoDisponivel ?? 0)"
        }
    }
    
    func completeProfitMargin() {
        let percent = (FinancialManager.sharedInstance.margemDeLucro.porcentagem ?? 0) * 100
        percentlabel.text = "\(percent)%"
    }
    
    func completeInformationMouthsResults() {
        metaMensalNumber.text = "R$ \(FinancialManager.sharedInstance.mouthsResults.metaMensal ?? 0)"
        saldoAtualNumber.text = "R$ \(FinancialManager.sharedInstance.mouthsResults.saldoAtual ?? 0)"
        previsaoMensal.text = "R$ \(FinancialManager.sharedInstance.mouthsResults.valorPrevisao ?? 0)"
    }
    
    func configureLayoutView() {
        //Actual Mouth reporting view
        actualMouthView.clipsToBounds = false
        actualMouthView.backgroundColor = UIColor.white
        actualMouthView.layer.shadowColor = UIColor.black.cgColor
        actualMouthView.layer.shadowOpacity = 0.14
        actualMouthView.layer.shadowOffset = .zero
        actualMouthView.layer.shadowRadius = 3
        actualMouthView.layer.cornerRadius = 10
        let tapMouthView = UITapGestureRecognizer(target: self, action: #selector(self.handleTapMouthReport(_:)))
        actualMouthView.addGestureRecognizer(tapMouthView)
        //profit margin view
        profitMargin.clipsToBounds = false
        profitMargin.backgroundColor = UIColor.white
        profitMargin.layer.shadowColor = UIColor.black.cgColor
        profitMargin.layer.shadowOpacity = 0.14
        profitMargin.layer.shadowOffset = .zero
        profitMargin.layer.shadowRadius = 3
        profitMargin.layer.cornerRadius = 10
        //Bank deposit View
        bankDepositView.clipsToBounds = false
        bankDepositView.backgroundColor = UIColor.white
        bankDepositView.layer.shadowColor = UIColor.black.cgColor
        bankDepositView.layer.shadowOpacity = 0.14
        bankDepositView.layer.shadowOffset = .zero
        bankDepositView.layer.shadowRadius = 3
        bankDepositView.layer.cornerRadius = 10
        let tapBankDepositView = UITapGestureRecognizer(target: self, action: #selector(self.handleTapBankDeposits(_:)))
        bankDepositView.addGestureRecognizer(tapBankDepositView)
        //Credit And Debit view
        creditAndDebitView.clipsToBounds = false
        creditAndDebitView.backgroundColor = UIColor.white
        creditAndDebitView.layer.shadowColor = UIColor.black.cgColor
        creditAndDebitView.layer.shadowOpacity = 0.14
        creditAndDebitView.layer.shadowOffset = .zero
        creditAndDebitView.layer.shadowRadius = 3
        creditAndDebitView.layer.cornerRadius = 10
        let tapCreditAndDebitView = UITapGestureRecognizer(target: self, action: #selector(self.handleTapCreditAndDebit(_:)))
        creditAndDebitView.addGestureRecognizer(tapCreditAndDebitView)
    }
    
    @objc func handleTapBankDeposits(_ sender: UITapGestureRecognizer? = nil) {
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "BankDepositsViewController")
        self.definesPresentationContext = true
        newVC?.modalPresentationStyle = .overCurrentContext
        self.present(newVC!, animated: true, completion: nil)
    }
    
    @objc func handleTapCreditAndDebit(_ sender: UITapGestureRecognizer? = nil) {
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "CreditAndDebitViewController")
        self.definesPresentationContext = true
        newVC?.modalPresentationStyle = .overCurrentContext
        self.present(newVC!, animated: true, completion: nil)
    }
    
    @objc func handleTapMouthReport(_ sender: UITapGestureRecognizer? = nil) {
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "MouthResultViewController")
        self.definesPresentationContext = true
        newVC?.modalPresentationStyle = .overCurrentContext
        self.present(newVC!, animated: true, completion: nil)
    }

}
