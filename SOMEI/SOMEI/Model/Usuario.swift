//
//  Usuario.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 16/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import Foundation
import UIKit

class Usuario {
    
    var name: String?
    var age: Int?
    var phone:String?
    var email:String?
    var photo:UIImage?
    var password:String?
    var photoLink:URL?
    var id:Int?
      
    init(name:String?, age:Int?, phone:String?, email:String?, photo:UIImage?, password:String?, photoLink:URL?,id:Int?) {
        
        self.name = name
        self.age = age
        self.phone = phone
        self.email = email
        self.photo = photo
        self.photoLink = photoLink
        self.id = id
        self.password = password
       
    }
}
