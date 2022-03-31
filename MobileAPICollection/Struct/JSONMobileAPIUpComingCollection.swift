//
//  JSONMobileAPIUpComingCollection.swift
//  MobileAPICollection
//
//  Created by Hector Guadalupe Climaco Flores on 23/03/22.
//

import Foundation
import UIKit

struct MoviesUpComingResponse: Decodable{
    //var page:Int
    var results:[MovieUpComing]
}

struct MovieUpComing: Decodable{
    var title:String?
    var release_date:String?
    var poster_path:String
    var overview:String?
    var original_language:String?
}
