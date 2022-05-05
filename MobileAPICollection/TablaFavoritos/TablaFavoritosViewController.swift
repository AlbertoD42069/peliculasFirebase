//
//  TablaFavoritosViewController.swift
//  MobileAPICollection
//
//  Created by Hector Guadalupe Climaco Flores on 04/04/22.
//

import UIKit
import FirebaseFirestore
/*
 para implementar el protocolo en un delegado se debe de implementar el protocolo por lo general se implementa los protocolos en una extencion de la clase
 */
class TablaFavoritosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var TablaFavoritos: UITableView!
    
    let userData = UserData.shared
    //instancia de la clase que consu
    let repositoryMovies = MoviesRepository()
    let db = Firestore.firestore()
    
    
    var peiluculasFavoritas:[Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let JSONPopular = ServiceManager()
        JSONPopular.execute(url: Urls.linkPopular) { movieFavoritos in
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
    //
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

/*
 5// implementacion de protocolo en una extension de una clase
*/
extension TablaFavoritosViewController: RepositoryDelegateProtocol {
/*
como hemos implementado el protocolo se debe de implementar tambien sus funciones.
*/
    func didUpdateData() {
        /*
         se esta asignando a que el array de peliculas use las funciones de los protocolos
         */
        self.peiluculasFavoritas = repositoryMovies.getPopulates()
        self.peiluculasFavoritas = repositoryMovies.getPopulates()
        
        /*
         en los protocolos siempre se debe de hacer un <reloadData()>
         */
        self.TablaFavoritos.reloadData()
    }
    
    func didSearchMovie(movie: Movie) {
        dump(movie)
    }
    
}
