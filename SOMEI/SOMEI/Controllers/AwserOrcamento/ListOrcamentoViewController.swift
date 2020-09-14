//
//  ListOrcamentoViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 12/09/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class ListOrcamentoViewController: ViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        ProviderSomei.ServicosAtivos(email: ProfissionalManager.sharedInstance.profissional.email!, password: ProfissionalManager.sharedInstance.profissional.password!) {res,result in
//                print(res)
//                print("_________________")
//                print(result)
//         }
    }

}
extension ListOrcamentoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrcamentoManager.sharedInstance.agendaArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as! SelectHourTableViewCell
        let day = OrcamentoManager.sharedInstance.agendaArray[indexPath.row]
        
        cell.hourSelected.text = "\(String(describing: day.horaInicio?.hour)):\(String(describing: day.horaInicio?.minute)) - \(day.horaFinal?.hour):\(day.horaFinal?.minute)"
        cell.selectedDay.text = "\(day.diaSemana ?? "")"
        return cell
    }
}
extension ListOrcamentoViewController: UITableViewDelegate {
    
}
