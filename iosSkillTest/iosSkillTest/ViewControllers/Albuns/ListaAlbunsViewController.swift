//
//  ListaAlbunsTableViewController.swift
//  iosSkillTest
//
//  Created by Pedro Nascimento on 24/09/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import UIKit
import Moya
import Kingfisher
import ObjectMapper

class ListaAlbunsTableViewController: UITableViewController {

    var albuns: Array<Album> = []
    var provider: MoyaProvider<AlbumService>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAlbuns()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albuns.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as AlbumTableViewCell
        
        let album = albuns[indexPath.row]
        
        cell.titleLabel.text = album.title
        
        let thumbnailUrl = URL(string: album.thumbnailUrl)
        cell.thumbnailImageView.kf.indicatorType = .activity
        cell.thumbnailImageView.kf.setImage(with: thumbnailUrl!)
        
        return cell
    }
    
    func getAlbuns() {
        if provider == nil {
            provider = MoyaProvider<AlbumService>()
        }
        
        provider.request(.getAlbuns) { result in
            switch result {
            case let .success(response):
                do {
                    self.albuns = []
                    
                    for album in Mapper<Album>().mapArray(JSONArray: try response.mapJSON() as! Array) {
                        self.albuns.append(album)
                    }
                        
                    self.tableView.reloadData()
                    
                } catch {
                    self.alertaSimples(titulo: "Erro", mensagem: "Ocorreu um erro no processamento da requisição.")
                }
            case .failure:
                self.alertaSimples(titulo: "Erro", mensagem: "Não foi possível enviar a requisicão.")
            }
        }
    }

}
