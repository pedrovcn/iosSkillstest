//
//  String+Extensions.swift
//  iosSkillTest
//
//  Created by Pedro Nascimento on 25/09/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import Foundation

extension String {
    func emailValido() -> Bool {
       return range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
              options: String.CompareOptions.regularExpression,
              range: nil, locale: nil) != nil
    }
}
