//
//  DetallesPeliculaViewController.swift
//  MobileAPICollection
//
//  Created by Hector Guadalupe Climaco Flores on 23/03/22.
//

import UIKit
//import FirebaseAuth
import FirebaseFirestore

class DetallesPeliculaViewController: UIViewController {
    
    
    @IBOutlet weak var imgPosterImagen: UIImageView!
    
    @IBOutlet weak var lblIdiomaPelicula: UILabel!
    @IBOutlet weak var lblDescripcionPelicula: UILabel!
    @IBOutlet weak var lblNombrePelicula: UILabel!
    @IBOutlet weak var lblFechaEstreno: UILabel!
    
    @IBOutlet weak var btnFavoritos: UIButton!
    
    
    var pelicula:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if
            let nombrePelicula = pelicula?.title,
            let descripcionPelicula = pelicula?.overview,
            let idiomaPelicula = pelicula?.original_language,
            let imagenPoster = pelicula?.poster_path,
            let fechaEstreno = pelicula?.release_date
        {
            lblNombrePelicula.text = nombrePelicula
            lblDescripcionPelicula.text = "descripcion \n\(descripcionPelicula)"
            lblIdiomaPelicula.text = "idioma: \(idiomaPelicula)"
            lblFechaEstreno.text = "estreno: \(fechaEstreno)"
        
            let linkDefault = "https://image.tmdb.org/t/p/w500/"
            let completeLink = linkDefault + imagenPoster
            imgPosterImagen.downloaded(from: completeLink)
            
        }
        
    }
    
    let dataBase = Firestore.firestore()
    
    
    @IBAction func btnActionFavoritos(_ sender: Any) {

        let idPelicula = pelicula?.id
        guard let nombrePelicula = pelicula?.title else { return }
        
        dataBase.collection("Pelicula Favoritas").document(nombrePelicula).setData([
            "ID": idPelicula ?? "",
            "nombrePelicula": nombrePelicula
        ])
        
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
