//
//  RegistroViewController.swift
//  iosSkillTest
//
//  Created by Pedro Nascimento on 24/09/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import UIKit
import CoreData

class RegistroViewController: UIViewController {

    var usuarioLogado = true
    var usuario: NSManagedObject?
    var dataManager: DataManager!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var senhaTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(ocultarTeclado))
        self.view.addGestureRecognizer(tap)
        
        if usuario != nil {
            emailTextField.text = usuario?.value(forKey: "email") as? String
            nomeTextField.text = usuario?.value(forKey: "nome") as? String
            senhaTextField.text = usuario?.value(forKey: "senha") as? String
            emailTextField.isEnabled = false
        }
    }
    
    @IBAction func fecharRegistro(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func acaoSalvarUsuario(_ sender: Any) {
        ocultarTeclado()
        
        if formularioValido() {
            salvarUsuario() { (titulo, mensagem) in
                alertaSimples(titulo: titulo, mensagem: mensagem) { _ in
                    self.fecharRegistro(self)
                }
            }
        }
    }
    
    func formularioValido() -> Bool {
        if emailTextField.vazio() {
            alertaSimples(titulo: "Atenção", mensagem: "Preencha o e-mail.", handler: nil)
            return false
        }
        
        if let email = emailTextField.text {
            if !email.emailValido() {
                alertaSimples(titulo: "Atenção!", mensagem: "Preencha com um e-mail válido.", handler: nil)
                return false
            }
        }
        
        if nomeTextField.vazio() {
            alertaSimples(titulo: "Atenção", mensagem: "Preencha o nome.", handler: nil)
            return false
        }
        
        if senhaTextField.vazio() {
            alertaSimples(titulo: "Atenção", mensagem: "Preencha a senha.", handler: nil)
            return false
        }
        
        return true
    }
    
    func salvarUsuario(completion: (_ titulo: String, _ mensagem: String) -> Void) {
        if dataManager == nil {
            dataManager = DataManager()
        }
        
        let managedContext = dataManager.persistentContainer.viewContext
        
        var usuario: NSManagedObject!
        
        if self.usuario != nil {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
            let atributo = "email"
            fetchRequest.predicate = NSPredicate(format: "%K == %@", atributo, emailTextField.text ?? "")
            
            do {
                let results = try managedContext.fetch(fetchRequest)
                let usuarios = results as? [NSManagedObject]
                
                usuario = usuarios?.first
            } catch {
                alertaSimples(titulo: "Ops!", mensagem: "Usuário não encontrado", handler: nil)
            }
        } else {
            let entity = NSEntityDescription.entity(forEntityName: "Usuario", in: managedContext)!
            usuario = NSManagedObject(entity: entity, insertInto: managedContext)
        }
        
        usuario.setValue(nomeTextField.text, forKey: "nome")
        usuario.setValue(emailTextField.text, forKey: "email")
        usuario.setValue(senhaTextField.text, forKey: "senha")
        
        do {
            try managedContext.save()
            completion("Pronto!", "Usuário salvo com sucesso.")
        } catch let error as NSError {
            print("Erro ao salvar: \(error), \(error.userInfo)")
            completion("Ops!", "Ocorreu um erro ao salvar o usuário. Tente novamente mais tarde.")
        }
    }
    
    @objc func ocultarTeclado() {
        self.view.endEditing(true)
    }

}
