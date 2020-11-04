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
    //Credit and debit
    @IBOutlet weak var creditAndDebitView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayoutView()
        completeInformation()
    }
    
    func completeInformation() {
        completeInformationMouthsResults()
        completeProfitMargin()
        completeBankDeposit()
    }
    
    func completeBankDeposit() {
        let lastDeposit = FinancialManager.sharedInstance.lastDeposit()
        if let lastDeposit = lastDeposit {
            if let day = lastDeposit.dtVencimento?.day, let mounth = lastDeposit.dtVencimento?.mounth, let year = lastDeposit.dtVencimento?.year {
                dateLabel.text = "\(day)/\(mounth)/\(year)"
            }else{
                dateLabel.isHidden = true
            }
            if let valor = lastDeposit.valor {
                priceLabel.text = "R$\(valor)"
            }else{
                priceLabel.isHidden = true
            }
        }else{
            bankDepositView.isHidden = true
        }
    }
    
    func completeProfitMargin() {
        if let percent = FinancialManager.sharedInstance.calculatePercentProfitMargin() {
            percentlabel.text = "\(percent)%"
        }
    }
    
    func completeInformationMouthsResults() {
        metaMensalNumber.text = "R$ \(ProfissionalManager.sharedInstance.profissional.metaMensal ?? 0)"
        saldoAtualNumber.text = "R$ \(FinancialManager.sharedInstance.calculateSaldo())"
        previsaoMensal.text = "R$ \(FinancialManager.sharedInstance.calculatePrevisao())"
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
