//
//  Album.swift
//  iosSkillTest
//
//  Created by Pedro Nascimento on 24/09/2018.
//  Copyright © 2018 Pedro Nascimento. All rights reserved.
//

import Foundation
import ObjectMapper

class Album : Mappable {

    var albumId : Int!
    var id : Int!
    var thumbnailUrl : String!
    var title : String!
    var url : String!

    required init?(map: Map) { }
    
    func mapping(map: Map) {
        albumId <- map["albumId"]
        id <- map["id"]
        thumbnailUrl <- map["thumbnailUrl"]
        title <- map["title"]
        url <- map["url"]
    }
    
}
