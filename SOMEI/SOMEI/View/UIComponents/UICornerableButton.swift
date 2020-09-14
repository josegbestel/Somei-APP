//
//  File.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 21/03/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import Foundation
import UIKit

class UICornerableButton: UIButton {

        @IBInspectable var borderWidth: CGFloat {
            set {
                layer.borderWidth = newValue
            }
            get {
                return layer.borderWidth
            }
        }

        @IBInspectable var cornerRadius: CGFloat {
            set {
                layer.cornerRadius = newValue
            }
            get {
                return layer.cornerRadius
            }
        }
    
        @IBInspectable var borderColor: UIColor {
            get {
                return UIColor(cgColor: self.layer.borderColor!)
            }
            set {
                self.layer.borderColor = newValue.cgColor
            }
        }
}
