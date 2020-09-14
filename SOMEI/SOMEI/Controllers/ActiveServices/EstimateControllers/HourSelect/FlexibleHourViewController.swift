//
//  FlexibleHourViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 11/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class FlexibleHourViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var horariosTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        horariosTextField.isUserInteractionEnabled = false
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func newHourButton(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let newNavigation = storyBoard.instantiateViewController(withIdentifier: "SelectMultiHourViewController")
        self.present(newNavigation, animated: true, completion: nil)
        
    }
    
}
extension FlexibleHourViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrcamentoManager.sharedInstance.agendaArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! SelectHourTableViewCell
        let day = OrcamentoManager.sharedInstance.agendaArray[indexPath.row]
        
//        cell.hourSelected.text = "\(Int(day.horaInicio?.hour ?? 00)):\(Int(day.horaInicio?.minute ?? 00)) - \(Int(day.horaFinal?.hour ?? 00)):\(Int(day.horaFinal?.minute ?? 00))"
        cell.hourSelected.text = "\((day.horaInicio?.hour ?? "")):\((day.horaInicio?.minute ?? ""))"
        cell.selectedDay.text = "\(day.diaSemana ?? "")"
        return cell
    }
}
extension FlexibleHourViewController: UITableViewDelegate {
    
}
