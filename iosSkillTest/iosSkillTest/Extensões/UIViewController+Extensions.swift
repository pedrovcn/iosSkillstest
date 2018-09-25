//
//  UIViewController+Extensions.swift
//  iosSkillTest
//
//  Created by Pedro Nascimento on 24/09/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func alertaSimples(titulo: String?, mensagem: String?, handler: ((UIAlertAction) -> Void)?) {
        let alerta = UIAlertController.init(title: titulo, message: mensagem, preferredStyle: .alert)
        let acaoOk =  UIAlertAction.init(title: "OK", style: .default, handler: handler)
        
        alerta.addAction(acaoOk)
        self.show(alerta, sender: self)
    }
}
