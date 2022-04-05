//
//  PantallasTabBarController.swift
//  MobileAPICollection
//
//  Created by Hector Guadalupe Climaco Flores on 01/04/22.
//

import Foundation
import UIKit

class PantallasTabBarController: UITabBarController{
    
    override func viewDidLoad() {
        self.viewDidLoad()
    }
    
    func tabBar(){
        let home = ViewController()
        let favoritos = TablaFavoritosViewController()
        let inicioSesion = LoginViewController()
        
        home.title = "Home"
        favoritos.title = "Favoritos"
        inicioSesion.title = "Sesion"
        
        self .setViewControllers([home,favoritos,inicioSesion], animated: true)
        guard let items = self.tabBar.items else {return}
        let imagenes = ["home","favoritos","sesion"]
        
        for x in 1...2 {
            items[x].image = UIImage(systemName: imagenes[x])
        }

    }
}
