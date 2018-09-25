//
//  UITextField+Extensions.swift
//  iosSkillTest
//
//  Created by Pedro Nascimento on 24/09/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func isEmpty() -> Bool {
        if self.text?.count == 0 {
            return true
        }
        
        return false
    }
    
}
