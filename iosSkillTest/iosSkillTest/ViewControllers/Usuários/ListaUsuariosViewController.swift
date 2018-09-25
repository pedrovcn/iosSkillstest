//
//  ListaUsuariosViewController.swift
//  iosSkillTest
//
//  Created by Pedro Nascimento on 24/09/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import UIKit
import CoreData

class ListaUsuariosViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var dataManager: DataManager!
    
    var usuarios: Array<NSManagedObject>!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        carregarUsuarios()
    }
    
    func carregarUsuarios() {
        if dataManager == nil {
            dataManager = DataManager()
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
        let context = dataManager.persistentContainer.viewContext
        do {
            let results = try context.fetch(fetchRequest)
            usuarios = results as? [NSManagedObject]
            tableView.reloadData()
            
        } catch let error as NSError {
            alertaSimples(titulo: "Ops!", mensagem: "Ocorreu um erro ao buscar as informações.", handler: nil)
            print("Erro ao buscar: \(error), \(error.userInfo)")
        }
    }

}

extension ListaUsuariosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usuarios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as UsuarioTableViewCell
        
        let usuario = usuarios[indexPath.row]
        
        cell.nomeLabel.text = usuario.value(forKey: "nome") as? String
        cell.emailLabel.text = usuario.value(forKey: "email") as? String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ListaUsuariosViewController: UITableViewDelegate {
    
}

extension ListaUsuariosViewController: UISearchBarDelegate {
    
}
