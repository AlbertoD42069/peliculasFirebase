//
//  JSONMobileAPICollection.swift
//  MobileAPICollection
//
//  Created by Hector Guadalupe Climaco Flores on 22/03/22.
//

import Foundation
import UIKit

struct MoviesPResponse: Decodable{
    //var page:Int
    var results:[Movie]
}

struct Movie: Decodable{
    var title:String?
    var release_date:String?
    var poster_path:String
    var overview:String?
    var original_language:String?
}
