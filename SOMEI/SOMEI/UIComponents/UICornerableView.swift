//
//  UICornerableView.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 21/03/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import Foundation
import UIKit

class UICornerableView: UIView {
    @IBInspectable var cornerRadius:CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
     }    
}

