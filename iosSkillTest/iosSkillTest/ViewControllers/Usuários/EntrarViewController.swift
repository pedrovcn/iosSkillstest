//
//  EntrarViewController.swift
//  iosSkillTest
//
//  Created by Pedro Nascimento on 24/09/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import UIKit
import CoreData

class EntrarViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    
    var dataManager: DataManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(ocultarTeclado))
        self.view.addGestureRecognizer(tap)
    }
    
    @IBAction func entrar() {
        if formularioValido() {
            buscarUsuario()
        }
    }
    
    func formularioValido() -> Bool {
        if emailTextField.vazio() {
            alertaSimples(titulo: "Atenção!", mensagem: "Preencha o e-mail.", handler: nil)
            return false
        }
        
        if let email = emailTextField.text {
            if !email.emailValido() {
                alertaSimples(titulo: "Atenção!", mensagem: "Preencha com um e-mail válido.", handler: nil)
                return false
            }
        }

        if senhaTextField.vazio() {
            alertaSimples(titulo: "Atenção!", mensagem: "Preencha a senha.", handler: nil)
            return false
        }
        
        return true
    }

    func buscarUsuario() {
        if dataManager == nil {
            dataManager = DataManager()
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
        
        let atributo = "email"
        
        fetchRequest.predicate = NSPredicate(format: "%K == %@", atributo, emailTextField.text ?? "")
        
        let context = dataManager.persistentContainer.viewContext
        do {
            let results = try context.fetch(fetchRequest)
            let usuarios = results as? [NSManagedObject]
            
            if let usuario = usuarios?.first {
                let senha = usuario.value(forKey: "senha") as! String
                
                if senha == self.senhaTextField.text {
                    self.performSegue(withIdentifier: "entrar", sender: self)
                } else {
                    alertaSimples(titulo: "Atenção!", mensagem: "Senha incorreta.", handler: nil)
                }
            } else {
                alertaSimples(titulo: "Atenção!", mensagem: "Usuário não encontrado.", handler: nil)
            }
            
        } catch let error as NSError {
            alertaSimples(titulo: "Ops!", mensagem: "Ocorreu um erro ao buscar as informações.", handler: nil)
            print("Erro ao buscar: \(error), \(error.userInfo)")
        }
    }
    
    @objc func ocultarTeclado() {
        self.view.endEditing(true)
    }
}
