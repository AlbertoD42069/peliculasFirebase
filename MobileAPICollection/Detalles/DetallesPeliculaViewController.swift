//
//  DetallesPeliculaViewController.swift
//  MobileAPICollection
//
//  Created by Hector Guadalupe Climaco Flores on 23/03/22.
//

import UIKit
import FirebaseAuth
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

        //print(userData.userId)
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
    /*private let email: String
    private let provider :ProviderType
    
    init(email:String, provider:ProviderType) {
        self.email = email
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }*/
    let userData = UserData.shared
    @IBAction func btnActionFavoritos(_ sender: Any) {
        //let usuario = Auth.auth().currentUser
        guard let id = pelicula?.id else {return}
        //let strInt = String(id)
        if Auth.auth().currentUser?.uid == userData.userId {
            
            print("alv")
        }
        let fav = FavoritesManager()
        if let peli = pelicula {
            fav.setFavorites(movie: MovieViewData(id: peli.id, title: peli.title, image: peli.poster_path, rating: peli.vote_average, resume: peli.overview, date: peli.release_date))
        }
        
    }
        /*let idPelicula = pelicula?.id
        guard let nombrePelicula = pelicula?.title else { return }
        
        dataBase.collection("Pelicula Favoritas").document(nombrePelicula).setData([
            "ID": idPelicula ?? "",
            "nombrePelicula": nombrePelicula
        ])
        */
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
