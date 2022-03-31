//
//  ViewController.swift
//  MobileAPICollection
//
//  Created by Hector Guadalupe Climaco Flores on 22/03/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var TablaPeliculas: UITableView!

    var MoviePopular: [Movie] = []
    var MovieUpComing: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*executeJsonPopulares {self.TablaPeliculas.reloadData()}
        executeJsonUpComing {self.TablaPeliculas.reloadData()}*/
        
        let JSONPopular = ExecuteJSON()
        JSONPopular.executeJSON(url: Urls.linkPopular) { moviePopular in
            self.MoviePopular = moviePopular
            self.TablaPeliculas.reloadData()
        }
        
        let JSONUpComing = ExecuteJSON()
        JSONUpComing.executeJSON(url: Urls.linkUpComing) { movieUpComing in
            self.MovieUpComing = movieUpComing
            self.TablaPeliculas.reloadData()
        }
        TablaPeliculas.delegate = self
        TablaPeliculas.dataSource = self
        
        let celdaPopulares = UINib(nibName: "PopularesTableViewCell", bundle: nil)
        let celdaUpComing = UINib(nibName: "UpComingTableViewCell", bundle: nil)
        let celdaDetalles = UINib(nibName: "DetallesPeliculaViewController", bundle: nil)
        
        TablaPeliculas.register(celdaPopulares, forCellReuseIdentifier: "CellPopulares")
        TablaPeliculas.register(celdaUpComing, forCellReuseIdentifier: "CellUpComing")
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoviePopular.count
        return MovieUpComing.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        if indexPath.section == 0{
            let celdaPopulares = TablaPeliculas.dequeueReusableCell(withIdentifier: "CellPopulares", for: indexPath) as! PopularesTableViewCell
            
            celdaPopulares.lblNombrePelicula.text = "nombre: \(MoviePopular[indexPath.row].title!.capitalized)"
            celdaPopulares.lblDescripcion.text = "descripcion: \(MoviePopular[indexPath.row].overview!.capitalized)"
            celdaPopulares.lblCalificacion.text = "Idioma: \(MoviePopular[indexPath.row].original_language!.capitalized)"
            
            
            celdaPopulares.imageView?.contentMode = .scaleAspectFill
            let linkDefault = "https://image.tmdb.org/t/p/w500/"
            let completeLink = linkDefault + MoviePopular[indexPath.row].poster_path
            celdaPopulares.imageView?.downloaded(from: completeLink)
            celdaPopulares.imageView?.clipsToBounds = true
            
            
            return celdaPopulares
        }
        //return UITableViewCell()
/*=======================================================================================================*/
        let CeldaUpComing = TablaPeliculas.dequeueReusableCell(withIdentifier: "CellUpComing", for: indexPath) as! UpComingTableViewCell
        CeldaUpComing.lblNombrePelicula.text = "nombre: \(MovieUpComing[indexPath.row].title!.capitalized)"
        CeldaUpComing.lblFechaEstreno.text = "Fecha estreno: \(MovieUpComing[indexPath.row].release_date!.capitalized)"
        
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
        /*estructura de control para las secciones de la tabla*/
        if section == 0{
            return "Populares"
        }
        return "Proximamente"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detallesPopulares = DetallesPeliculaPopularesViewController()
        let itemPopulares = MoviePopular[indexPath.row]
        detallesPopulares.moviePopulares = itemPopulares
        navigationController?.pushViewController(detallesPopulares, animated: true)
        
    }
    /*func executeJsonPopulares(completed: @escaping () -> () ){
        
        let URL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=c89f997b9f805d783c81fc1e854ed7d1")
        URLSession.shared.dataTask(with: URL!){(data,response,error) in
            
            if error == nil {
                do {
                    let response:MoviesPopularsResponse = try JSONDecoder().decode(MoviesPopularsResponse.self, from: data!)
                    DispatchQueue.main.async {
                        self.ResultPopulares = response.results
                        self.TablaPeliculas.reloadData()
                        completed()
                    }
                }catch{
                    print("json error")
                }
            }
        }.resume()
    }
    
    func executeJsonUpComing(completeds: @escaping () -> () ){
        let URL = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=c89f997b9f805d783c81fc1e854ed7d1")
        URLSession.shared.dataTask(with: URL!){(data,response,error) in
            if error == nil {
                do {
                    let response:MoviesUpComingResponse = try JSONDecoder().decode(MoviesUpComingResponse.self, from: data!)
                    DispatchQueue.main.async {
                        self.ResultUpComing = response.results
                        self.TablaPeliculas.reloadData()
                        completeds()
                    }
                }catch {
                    print("json error")
                }
            }
        }.resume()
    }*/
}
