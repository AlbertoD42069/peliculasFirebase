//
//  TablaPrincipalPeliculasViewController.swift
//  MobileAPICollection
//
//  Created by Hector Guadalupe Climaco Flores on 05/04/22.
//

import UIKit

class TablaPrincipalPeliculasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var TablaPeliculas: UITableView!
    
    let userData = UserData.shared
    let repositoryMovies = MoviesRepository()
    var moviePopulares:[Movie]=[]
    var MovieUpComing: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        TablaPeliculas.delegate = self
        TablaPeliculas.dataSource = self
        
        let celdaPopulares = UINib(nibName: "PopularesTableViewCell", bundle: nil)
        let celdaUpComing = UINib(nibName: "UpComingTableViewCell", bundle: nil)
        
        TablaPeliculas.register(celdaPopulares, forCellReuseIdentifier: "CellPopulares")
        TablaPeliculas.register(celdaUpComing, forCellReuseIdentifier: "CellUpComing")
        
        repositoryMovies.delegate = self
        repositoryMovies.getData()
        
        let favorites = FavoritesManager()

        favorites.getFavorites {favorites in
            dump(favorites)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return moviePopulares.count
        }else {
            return MovieUpComing.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let celdaPopulares = TablaPeliculas.dequeueReusableCell(withIdentifier: "CellPopulares", for: indexPath) as! PopularesTableViewCell
            
            celdaPopulares.lblNombrePelicula.text = "nombre: \(moviePopulares[indexPath.row].title.capitalized)"
            //celdaPopulares.lblDescripcion.text = "descripcion: \(moviePopulares[indexPath.row].overview!.capitalized)"
            celdaPopulares.lblCalificacion.text = "Idioma: \(moviePopulares[indexPath.row].original_language.capitalized)"
            
            
            celdaPopulares.imageView?.contentMode = .scaleAspectFill
            let linkDefault = "https://image.tmdb.org/t/p/w500/"
            let completeLink = linkDefault + moviePopulares[indexPath.row].poster_path
            celdaPopulares.imageView?.downloaded(from: completeLink)
            celdaPopulares.imageView?.clipsToBounds = true
            
            
            return celdaPopulares
        }
        //return UITableViewCell()
/*=======================================================================================================*/
        let CeldaUpComing = TablaPeliculas.dequeueReusableCell(withIdentifier: "CellUpComing", for: indexPath) as! UpComingTableViewCell
        CeldaUpComing.lblNombrePelicula.text = "nombre: \(MovieUpComing[indexPath.row].title.capitalized)"
        CeldaUpComing.lblFechaEstreno.text = "Fecha estreno: \(MovieUpComing[indexPath.row].release_date.capitalized)"
        
        CeldaUpComing.imageView?.contentMode = .scaleAspectFill
        let linkDefault = "https://image.tmdb.org/t/p/w500/"
        let completeLink = linkDefault + MovieUpComing[indexPath.row].poster_path
        CeldaUpComing.imageView?.downloaded(from: completeLink)
        CeldaUpComing.imageView?.clipsToBounds = true
        
        return CeldaUpComing
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Popular"
        }
        return "Proximamente"
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            let pantalla = DetallesPeliculaViewController()
            let arreglo = moviePopulares[indexPath.row]
            pantalla.pelicula = arreglo
            navigationController?.pushViewController(pantalla, animated: true)
        }else {
            let pantalla = DetallesPeliculaViewController()
            let arreglo = moviePopulares[indexPath.row]
            pantalla.pelicula = arreglo
            navigationController?.pushViewController(pantalla, animated: true)
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TablaPrincipalPeliculasViewController: RepositoryDelegateProtocol {
    
    func didUpdateData() {
        self.moviePopulares = repositoryMovies.getPopulates()
        self.moviePopulares = repositoryMovies.getPopulates()
        self.TablaPeliculas.reloadData()
    }
    
    func didSearchMovie(movie: Movie) {
        dump(movie)
    }
    
}
