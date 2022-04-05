//
//  PopularesTableViewCell.swift
//  MobileAPICollection
//
//  Created by Hector Guadalupe Climaco Flores on 22/03/22.
//

import UIKit
protocol FavoritoPopularProtocol {
    func guardarPopularFavorito(cell: PopularesTableViewCell)
}

class PopularesTableViewCell: UITableViewCell {
    
    var favoritoPopularDelegate : FavoritoPopularProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var btnFavoritos: UIButton!
    @IBOutlet weak var lblCalificacion: UILabel!
    //@IBOutlet weak var lblDescripcion: UILabel!
    @IBOutlet weak var lblNombrePelicula: UILabel!
    @IBOutlet weak var imgPoster: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnActionFavoritos(_ sender: Any) {
        favoritoPopularDelegate?.guardarPopularFavorito(cell: self)
    }
    
}
