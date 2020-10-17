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
    @IBOutlet weak var profissionalLabel: UILabel!
    @IBOutlet weak var descriptionJobLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var imageArray:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fixLoyout()
        completeInformations()
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(AnswerViewController.dismissKeyboard)))
    }
    
    @objc func dismissKeyboard() {
          self.view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAround() {
          let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AnswerViewController.dismissKeyboard))
          tap.cancelsTouchesInView = false
          view.addGestureRecognizer(tap)
    }
    
    func completeInformations() {
        profissionalLabel.text = OrcamentoManager.sharedInstance.selectedOrcamento?.profissao
        descriptionJobLabel.text = OrcamentoManager.sharedInstance.selectedOrcamento?.descricao
        streetLabel.text = "\(OrcamentoManager.sharedInstance.selectedOrcamento?.endereco?.logradouro ?? ""), \(OrcamentoManager.sharedInstance.selectedOrcamento?.endereco?.numero ?? 0) - \(OrcamentoManager.sharedInstance.selectedOrcamento?.endereco?.cidade ?? "")/\(OrcamentoManager.sharedInstance.selectedOrcamento?.endereco?.uf ?? "")"
        if let links = OrcamentoManager.sharedInstance.selectedOrcamento?.linkPhotos {
            for link in links {
                downloadImage(from: link)
            }
        }
        if let horario = OrcamentoManager.sharedInstance.selectedOrcamento?.agendaArray?[0] {
            print(horario.horaFinal)
            if let horaInicio = horario.horaInicio {
                if let horaFinal = horario.horaFinal {
                    timeLabel.text = "\(horario.diaSemana ?? ""),\(horaInicio.hour ?? ""):\(horaInicio.minute ?? "") - \(horaFinal.hour ?? ""):\(horaFinal.minute ?? "") "
                }
            }
        }
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            if error != nil {
                print("Erro ao baixar imagem:\(error?.localizedDescription ?? "")")
            }
            guard let data = data, error == nil else {print("download error"); return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.imageArray.insert(UIImage(data: data)!, at: 0)
                self?.collectionView.reloadData()
            }
        }
    }
        
    func fixLoyout() {
        borderView.clipsToBounds = false
        borderView.backgroundColor = UIColor.white
        borderView.layer.shadowColor = UIColor.black.cgColor
        borderView.layer.shadowOpacity = 0.24
        borderView.layer.shadowOffset = .zero
        borderView.layer.shadowRadius = 3
        borderView.layer.cornerRadius = 10
    }
    
    func goesToOrcamentoRespondidoScreen() {
        let newVC = self.storyboard?.instantiateViewController(withIdentifier: "orcamentoRespondido")
        self.definesPresentationContext = true
        newVC?.modalPresentationStyle = .overCurrentContext
        self.present(newVC!, animated: true, completion: nil)
    }
    
    func constructStruct() -> OrcamentoAnswerStruct {
        let valor:Double = Double(textField.text ?? "0")!
        let teste = OrcamentoAnswerStruct.init(agendaId: Double(OrcamentoManager.sharedInstance.selectedOrcamento?.agendaId ?? 0), orcamentoId: Double(OrcamentoManager.sharedInstance.selectedOrcamento?.id ?? 0), valor: valor, observacao: OrcamentoManager.sharedInstance.selectedOrcamento?.descricao ?? "")
        return teste
    }
    
    func awnserOrcamento() {
        if ProfissionalManager.sharedInstance.profissional.email != nil, ProfissionalManager.sharedInstance.profissional.password != nil, OrcamentoManager.sharedInstance.selectedOrcamento?.id != nil {
            ProviderSomei.answerRequest(structToSend: constructStruct(), id: String((OrcamentoManager.sharedInstance.selectedOrcamento?.id)!), email: ProfissionalManager.sharedInstance.profissional.email!, password: ProfissionalManager.sharedInstance.profissional.password!){success in
                if success == true{
                    DispatchQueue.main.async {
                        self.goesToOrcamentoRespondidoScreen()
                    }
                }else{
                    DispatchQueue.main.async {
                        self.errorPopUp()
                    }
                }
            }
        }else{
            DispatchQueue.main.async {
                self.errorPopUp()
            }
        }
    }
    
    func errorPopUp() {
        let alert = UIAlertController(title: "Algo deu errado", message: "Por favor tente novamento mais tarde", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    func wrongData() {
        let alert = UIAlertController(title: "Ops! Falta inserir o valor", message: "Campo valor vazio", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok!", style: .default, handler: { action in
        })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if textField.text?.count != 0 {
            awnserOrcamento()
        }else{
            wrongData()
        }
    }
}
extension AnswerViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ComentsViewController
        
        
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
         1
    }
}

