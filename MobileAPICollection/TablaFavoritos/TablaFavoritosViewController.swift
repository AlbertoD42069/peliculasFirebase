//
//  TablaFavoritosViewController.swift
//  MobileAPICollection
//
//  Created by Hector Guadalupe Climaco Flores on 04/04/22.
//

import UIKit
import FirebaseFirestore

class TablaFavoritosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TablaFavoritos: UITableView!
    
    
    let db = Firestore.firestore()
    
    
    var peiluculasFavoritas:[Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let JSONPopular = ExecuteJSON()
        JSONPopular.executeJSON(url: Urls.linkPopular) { movieFavoritos in
            self.peiluculasFavoritas = movieFavoritos
            self.TablaFavoritos.reloadData()
        }
        
        TablaFavoritos.delegate = self
        TablaFavoritos.dataSource = self
        
        let celdaFavoritos = UINib(nibName: "CeldaFavoritosTableViewCell", bundle: nil)
        TablaFavoritos.register(celdaFavoritos, forCellReuseIdentifier: "celdaFavorito")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celdaFavoritos = TablaFavoritos.dequeueReusableCell(withIdentifier: "celdaFavorito", for: indexPath) as! CeldaFavoritosTableViewCell
        
        //celdaFavoritos.lblPeliculaFavorita.text = peiluculasFavoritas[indexPath.row].title!.capitalized
        db.collection("Pelicula Favoritas").document().getDocument{
            (documentSnapshot,error) in
            if let documetn = documentSnapshot, error == nil {
                if let nombrePelicula = documetn.get("nombrePelicula") as? String {
                    celdaFavoritos.lblPeliculaFavorita.text = nombrePelicula
                }else {
                    celdaFavoritos.lblPeliculaFavorita.text = ""
                }
            }
        }
        
        
        
        
        
        
        
        
        
        
        return celdaFavoritos
    }

}
