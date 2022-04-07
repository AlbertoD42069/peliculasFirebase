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
    
    let userData = UserData.shared
    let repositoryMovies = MoviesRepository()
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
        
        repositoryMovies.delegate = self
        repositoryMovies.getData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        repositoryMovies.searchMovie(id: "634649")
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celdaFavoritos = TablaFavoritos.dequeueReusableCell(withIdentifier: "celdaFavorito", for: indexPath) as! CeldaFavoritosTableViewCell
        
        
        return celdaFavoritos
    }
}
extension TablaFavoritosViewController: RepositoryDelegate {
    
    func didUpdateData() {
        self.peiluculasFavoritas = repositoryMovies.getPopulates()
        self.peiluculasFavoritas = repositoryMovies.getUpcomming()
        self.TablaFavoritos.reloadData()
    }
    
    func didSearchMovie(movie: Movie) {
        dump(movie)
    }
    
}
