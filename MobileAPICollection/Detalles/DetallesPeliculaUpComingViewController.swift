//
//  DetallesPeliculaUpComingViewController.swift
//  MobileAPICollection
//
//  Created by Hector Guadalupe Climaco Flores on 31/03/22.
//

import UIKit

class DetallesPeliculaUpComingViewController: UIViewController {
    
    @IBOutlet weak var lblAñoEstreno: UILabel!
    @IBOutlet weak var lblNombrePelicula: UILabel!
    @IBOutlet weak var imgPosterPelicula: UIImageView!
    var movieUpComing : Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let nombrePelicula = movieUpComing?.title,
           let añoEstreno = movieUpComing?.release_date {
            
            lblNombrePelicula.text = nombrePelicula
            lblAñoEstreno.text = añoEstreno
            
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
