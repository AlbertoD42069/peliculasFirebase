//
//  UpComingTableViewCell.swift
//  MobileAPICollection
//
//  Created by Hector Guadalupe Climaco Flores on 22/03/22.
//

import UIKit

protocol favoritoUpComingProtocol {
    func guardarUpComing(cell: UpComingTableViewCell)
}

class UpComingTableViewCell: UITableViewCell {

    var favoritoUpComingDelegate : favoritoUpComingProtocol?

    @IBOutlet weak var btnFavorito: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var lblFechaEstreno: UILabel!
    @IBOutlet weak var lblNombrePelicula: UILabel!
    @IBOutlet weak var imgPoster: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnActionFavorito(_ sender: Any) {
        favoritoUpComingDelegate?.guardarUpComing(cell: self)
    }
}
