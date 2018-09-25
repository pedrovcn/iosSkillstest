//
//  EntrarViewController.swift
//  iosSkillTest
//
//  Created by Pedro Nascimento on 24/09/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import UIKit

class EntrarViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func entrar() {
        if formularioValido() {
            self.performSegue(withIdentifier: "entrar", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "novo_usuario" {
            let vc = segue.destination as! RegistroViewController
            vc.usuarioLogado = false
        }
    }
    
    func formularioValido() -> Bool {
        if emailTextField.isEmpty() {
            alertaSimples(titulo: "Atenção", mensagem: "Preencha o e-mail")
            return false
        }

        if senhaTextField.isEmpty() {
            alertaSimples(titulo: "Atenção", mensagem: "Preencha a senha")
            return false
        }
        
        return true
    }

}
