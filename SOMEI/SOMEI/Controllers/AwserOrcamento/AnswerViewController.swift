//
//  AnswerViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 12/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class AnswerViewController: ViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var borderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fixLoyout()
        // Do any additional setup after loading the view.
    }
        
    func fixLoyout() {
        
        borderView.clipsToBounds = true
        borderView.backgroundColor = UIColor.white
        borderView.layer.shadowColor = UIColor.black.cgColor
        borderView.layer.shadowOpacity = 0.24
        borderView.layer.shadowOffset = .zero
        borderView.layer.shadowRadius = 3
        borderView.layer.cornerRadius = 10
        
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
