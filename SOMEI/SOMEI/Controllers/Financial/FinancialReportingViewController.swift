//
//  FinancialReportingViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 04/10/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit

class FinancialReportingViewController: ViewController {

    //Actual Mouth reporting
    @IBOutlet weak var actualMouthView: UIView!
    @IBOutlet weak var saldoAtualNumber: UILabel!
    @IBOutlet weak var metaMensalNumber: UILabel!
    @IBOutlet weak var previsaoMensal: UILabel!
    //profit margin
    @IBOutlet weak var profitMargin: UIView!
    @IBOutlet weak var percentlabel: UILabel!
    //Bank deposit
    @IBOutlet weak var BankDepositView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayoutView()
        
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
        //profit margin view
        profitMargin.clipsToBounds = false
        profitMargin.backgroundColor = UIColor.white
        profitMargin.layer.shadowColor = UIColor.black.cgColor
        profitMargin.layer.shadowOpacity = 0.14
        profitMargin.layer.shadowOffset = .zero
        profitMargin.layer.shadowRadius = 3
        profitMargin.layer.cornerRadius = 10
        //Bank deposit View
        BankDepositView.clipsToBounds = false
        BankDepositView.backgroundColor = UIColor.white
        BankDepositView.layer.shadowColor = UIColor.black.cgColor
        BankDepositView.layer.shadowOpacity = 0.14
        BankDepositView.layer.shadowOffset = .zero
        BankDepositView.layer.shadowRadius = 3
        BankDepositView.layer.cornerRadius = 10
    }
    
    

}
