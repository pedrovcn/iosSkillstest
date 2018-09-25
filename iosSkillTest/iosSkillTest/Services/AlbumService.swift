//
//  AlbumService.swift
//  iosSkillTest
//
//  Created by Pedro Nascimento on 25/09/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import Moya

enum AlbumService {
    case getAlbuns
}

extension AlbumService: TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com/")!
    }
    
    var path: String {
        switch self {
        case .getAlbuns:
            return "photos"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAlbuns:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
}
