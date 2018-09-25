//
//  RegistroViewController.swift
//  iosSkillTest
//
//  Created by Pedro Nascimento on 24/09/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import UIKit

class RegistroViewController: UIViewController {

    var usuarioLogado = true
    var usuario: NSObject?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let usuario = self.usuario {
//            nomeTextField.text = usuario.nome
//            senhaTextField.text = usuario.senha
//            emailTextField.text = usuario.email
            emailTextField.isEnabled = false
        }
    }
    
    @IBAction func closeRegister(_ sender: Any) {
        if usuarioLogado {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func formularioValido() -> Bool {
        if emailTextField.isEmpty() {
            alertaSimples(titulo: "Atenção", mensagem: "Preencha o e-mail")
            return false
        }
        
        if senhaTextField.isEmpty() {
            alertaSimples(titulo: "Atenção", mensagem: "Preencha o nome")
            return false
        }
        
        if senhaTextField.isEmpty() {
            alertaSimples(titulo: "Atenção", mensagem: "Preencha a senha")
            return false
        }
        
        return true
    }

}
