//
//  DetallesPeliculaViewController.swift
//  MobileAPICollection
//
//  Created by Hector Guadalupe Climaco Flores on 23/03/22.
//

import UIKit

class DetallesPeliculaViewController: UIViewController {
    
    
    @IBOutlet weak var imgPosterImagen: UIImageView!
    
    @IBOutlet weak var lblIdiomaPelicula: UILabel!
    @IBOutlet weak var lblDescripcionPelicula: UILabel!
    @IBOutlet weak var lblNombrePelicula: UILabel!
    
    var moviePopulares:Movie?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if
            let nombrePelicula = moviePopulares?.title,
            let descripcionPelicula = moviePopulares?.overview,
            let idiomaPelicula = moviePopulares?.original_language
            //let imagenPoster = moviePopulares?.poster_path
        {
            lblNombrePelicula.text = nombrePelicula
            lblDescripcionPelicula.text = descripcionPelicula
            lblIdiomaPelicula.text = idiomaPelicula
        
            imagenPoster.imageView?.contentMode = .scaleAspectFill
            let linkDefault = "https://image.tmdb.org/t/p/w500/"
            let completeLink = linkDefault + moviePopulares[indexPath].poster_path
            imagenPoster.imageView?.downloaded(from: completeLink)
            imagenPoster.imageView?.clipsToBounds = true
            
        }
        // Do any additional setup after loading the view.
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
