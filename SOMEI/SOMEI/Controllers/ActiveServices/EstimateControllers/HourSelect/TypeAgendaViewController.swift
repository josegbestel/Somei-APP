//
//  TypeAgendaViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 15/10/20.
//  Copyright © 2020 José Guilherme Bestel. All rights reserved.
//

import UIKit

class TypeAgendaViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var containerViewEspecifico: UIView!
    @IBOutlet weak var containerViewDinamico: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerViewEspecifico.isHidden = false
        containerViewDinamico.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
        if let firstVC = presentingViewController as? HourTimeViewController {
             DispatchQueue.main.async {
                 firstVC.tableView.reloadData()
             }
         }
     }
    
    @IBAction func selectTypeAgenda(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
         case 0:
            containerViewEspecifico.isHidden = false
            containerViewDinamico.isHidden = true
         case 1:
             containerViewEspecifico.isHidden = true
             containerViewDinamico.isHidden = false
         default:
             break;
         }
    }
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okbutton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
