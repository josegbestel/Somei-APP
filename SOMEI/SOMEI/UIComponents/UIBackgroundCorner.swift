//
//  UIBackgroundCorner.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 15/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import Foundation
import UIKit

class UIBackgroundCorner: UILabel {
    @IBInspectable var cornerRadius:CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
     }
}
