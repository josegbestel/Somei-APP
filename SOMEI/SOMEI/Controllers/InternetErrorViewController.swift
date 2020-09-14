//
//  InternetErrorViewController.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 27/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit

class InternetErrorViewController: UIViewController {

    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContainerCornerRadious()
        showNavigationBar()
        setupLayout()
        // Do any additional setup after loading the view.
    }
    func setupLayout(){
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = self.view.bounds
        blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backgroundView.addSubview(blurredEffectView)
     }
        
    //MARK: private methodos
        private func setupContainerCornerRadious() {
            if #available(iOS 11.0, *) {
                containerView.clipsToBounds = true
                containerView.layer.cornerRadius = 24
                containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            } else {
                let rectShape = CAShapeLayer()
                rectShape.bounds = containerView.frame
                rectShape.position = containerView.center
                rectShape.path = UIBezierPath(roundedRect: containerView.bounds, byRoundingCorners: [.topLeft , .topRight ], cornerRadii: CGSize(width: 24, height: 24)).cgPath
                containerView.layer.mask = rectShape
            }
        }
       
        private func showNavigationBar() {
              if #available(iOS 11.0, *),
                  UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 24 {
                  navigationController?.setNavigationBarHidden(true, animated: false)
              }

              navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
              navigationController?.navigationBar.shadowImage = UIImage()
              navigationController?.navigationBar.isTranslucent = true
              navigationController?.navigationBar.barTintColor = .clear
          }

    @IBAction func tryAgainButton(_ sender: Any) {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func tryLater(_ sender: Any) {
        DispatchQueue.main.async {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let newNavigation = storyBoard.instantiateViewController(withIdentifier: "HomeViewController")
            self.present(newNavigation, animated: true, completion: nil)
            //TODO:error flow
        }
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
