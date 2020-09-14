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
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var containerViewEspecifico: UIView!
    @IBOutlet weak var containerViewDinamico: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ComplementEstimateViewController.dismissKeyboard)))
        if OrcamentoManager.sharedInstance.selectedProfission != nil {
           professionalLabel.text = OrcamentoManager.sharedInstance.selectedProfission
        }
    }
    
    func hideKeyboardWhenTappedAround() {
         let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ComplementEstimateViewController.dismissKeyboard))
         tap.cancelsTouchesInView = false
         view.addGestureRecognizer(tap)
     }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func indexChanged(_ sender: Any) {
       switch segmentedControl.selectedSegmentIndex {
            case 0:
                containerViewEspecifico.isHidden = true
                containerViewDinamico.isHidden = false
            case 1:
                containerViewEspecifico.isHidden = false
                containerViewDinamico.isHidden = true
            default:
                break;
            }
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
