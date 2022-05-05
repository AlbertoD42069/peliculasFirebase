//
//  ViewController.swift
//  MobileAPICollection
//
//  Created by Hector Guadalupe Climaco Flores on 22/03/22.
//

import UIKit
import FirebaseFirestore

class ViewController: UITabBarController{
    
    var db = Firestore.firestore()
    /*@IBOutlet weak var TablaPeliculas: UITableView!
    
    
    
    var MoviePopular: [Movie] = []
    var MovieUpComing: [Movie] = []*/
    
    override func viewDidLoad() {
        print("hola")
        super.viewDidLoad()
        
        let home = TablaPrincipalPeliculasViewController()
        let favoritos = TablaFavoritosViewController()
        let inicioSesion = IniciarSesionViewController()
        
        home.title = "Home"
        favoritos.title = "Favoritos"
        inicioSesion.title = "Sesion"
        
        self .setViewControllers([home,favoritos,inicioSesion], animated: true)
        guard let items = self.tabBar.items else {return}
        let imagenes =
        ["house.fill","star.fill","person.fill"]
        for x in 0...2 {
            items[x].image = UIImage(systemName: imagenes[x])
    
    
            let service = ServiceManager()
           
    
    
    
    
    }
        
        /*let JSONPopular = ExecuteJSON()
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
        
        */
    //}
    /*func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MoviePopular.count
        return MovieUpComing.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        if indexPath.section == 0{
            let celdaPopulares = TablaPeliculas.dequeueReusableCell(withIdentifier: "CellPopulares", for: indexPath) as! PopularesTableViewCell
            //este es un pinhi cambio
            celdaPopulares.lblNombrePelicula.text = "Nombre: \(MoviePopular[indexPath.row].title!.capitalized)"
            //celdaPopulares.lblDescripcion.text = "descripcion: \(MoviePopular[indexPath.row].overview!.capitalized)"
            celdaPopulares.lblCalificacion.text = "Fecha Estreno: \(MoviePopular[indexPath.row].release_date!.capitalized)"
            
            
            celdaPopulares.imageView?.contentMode = .scaleAspectFill
            let linkDefault = "https://image.tmdb.org/t/p/w500/"
            let completeLink = linkDefault + MoviePopular[indexPath.row].poster_path
            celdaPopulares.imageView?.downloaded(from: completeLink)
            celdaPopulares.imageView?.clipsToBounds = true
        //*************************************************************************
            celdaPopulares.favoritoPopularDelegate = self
            
        //*************************************************************************
            return celdaPopulares
        }
        //return UITableViewCell()
/*=======================================================================================================*/
        let CeldaUpComing = TablaPeliculas.dequeueReusableCell(withIdentifier: "CellUpComing", for: indexPath) as! UpComingTableViewCell
        CeldaUpComing.lblNombrePelicula.text = "Nombre: \(MovieUpComing[indexPath.row].title!.capitalized)"
        CeldaUpComing.lblFechaEstreno.text = "Fecha estreno: \(MovieUpComing[indexPath.row].release_date!.capitalized)"
        
        CeldaUpComing.imageView?.contentMode = .scaleAspectFill
        let linkDefault = "https://image.tmdb.org/t/p/w500/"
        let completeLink = linkDefault + MovieUpComing[indexPath.row].poster_path
        CeldaUpComing.imageView?.downloaded(from: completeLink)
        CeldaUpComing.imageView?.clipsToBounds = true
        
    //*****************************************************
        CeldaUpComing.favoritoUpComingDelegate = self
    //*****************************************************
        
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
        if (indexPath.section==0){
            let detallesPopulares = DetallesPeliculaViewController()
            let peliPopular = MoviePopular[indexPath.row]
            detallesPopulares.pelicula = peliPopular
            navigationController?.pushViewController(detallesPopulares, animated: true)
        }else {
            let detallesUpComing = DetallesPeliculaViewController()
            let peliUpComing = MovieUpComing[indexPath.row]
            detallesUpComing.pelicula = peliUpComing
            navigationController?.pushViewController(detallesUpComing, animated: true)
            
        }
    }
}

extension ViewController: FavoritoPopularProtocol, favoritoUpComingProtocol {
    func guardarUpComing(cell: UpComingTableViewCell) {
        if let indexPath = self.TablaPeliculas.indexPath(for: cell){
            let idPelicula = MovieUpComing[indexPath.row].id!
            let nombrePelicula = MovieUpComing[indexPath.row].title!
            cambiaColorCelda(indexCell: indexPath.row)
            //cambio de color
            db.collection("Pelicula Favoritas").document(nombrePelicula).setData([
                "ID": idPelicula,
                "nombrePelicula": nombrePelicula])
        }
            
    }
    
    func guardarPopularFavorito(cell: PopularesTableViewCell) {
        
        if  let indexPath = self.TablaPeliculas.indexPath(for: cell) {
            let idPelicula = MoviePopular[indexPath.row].id!
            let nombrePelicula = MoviePopular[indexPath.row].title!
            cambiaColorCelda(indexCell: indexPath.row)
            //cambiar de color
            
            db.collection("Pelicula Favoritas").document(nombrePelicula).setData([
                "ID": idPelicula,
                "nombrePelicula": nombrePelicula])
        }
   }
    
    func cambiaColorCelda(indexCell : Int) {
       /*
        let item = TablaPeliculas[indexPath.row]
        
        if item.select == true {
            celda.Check.backgroundColor = UIColor.green
        } else {
            celda.Check.backgroundColor = UIColor.white
        }*/
        //aqui debes cambiar de color la celda con el incide que regresa la funcion
    }
      */*/*/*/*/
          }
}
