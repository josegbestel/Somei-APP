//
//  FinishRegisterViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 08/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class FinishRegisterViewController: UIViewController {
    
    let semaphore = DispatchSemaphore(value: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func inicioButton(_ sender: Any) {
       let storyBoard = UIStoryboard(name: "Main", bundle: nil)
       let newNavigation = storyBoard.instantiateViewController(withIdentifier: "perfilHomeEmployee")
       self.present(newNavigation, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
