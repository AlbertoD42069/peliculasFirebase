//
//  ClaseSingleton.swift
//  MobileAPICollection
//
//  Created by Hector Guadalupe Climaco Flores on 05/04/22.
//

import Foundation

class UserData {
    
    static let shared = UserData()
    
    var userId:String?
    
    
    init(){}
    
    func isUserLogued() -> Bool {
        guard let id = userId else
        {
            return false
        }
        
        return true
        
    }
}
