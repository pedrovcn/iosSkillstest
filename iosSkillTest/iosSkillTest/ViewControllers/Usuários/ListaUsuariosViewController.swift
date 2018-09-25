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
        carregarUsuarios(filtrarPor: nil)
    }
    
    func carregarUsuarios(filtrarPor nome: String?) {
        if dataManager == nil {
            dataManager = DataManager()
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
        
        if let nome = nome {
            let atributo = "nome"
            fetchRequest.predicate = NSPredicate(format: "%K contains[c] %@", atributo, nome)
        }
        
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

extension ListaUsuariosViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ListaUsuariosViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            carregarUsuarios(filtrarPor: nil)
        } else {
            carregarUsuarios(filtrarPor: searchText)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return (searchBar.text?.count)! + text.count - range.length > 50 ? false : true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        carregarUsuarios(filtrarPor: nil)
        self.view.endEditing(true)
    }
}
