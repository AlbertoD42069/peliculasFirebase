//
//  repositorio.swift
//  MobileAPICollection
//
//  Created by Hector Guadalupe Climaco Flores on 07/04/22.
//

import Foundation

protocol RepositoryDelegate {
    
    func didUpdateData()
    func didSearchMovie(movie:Movie)

}

class MoviesRepository {
    var delegate: RepositoryDelegate?
    var arrPopulates : [Movie]?
    var arrUpcoming : [Movie]?
   
    init(){}
    
    func getData(){
        let servicesManager = ExecuteJSON()
        servicesManager.executeJSON(url: Urls.linkPopular) { [weak self] movies in
            self?.arrPopulates = movies
            self?.delegate?.didUpdateData()
        }
        let serviceForUpcomming = ExecuteJSON()
        serviceForUpcomming.executeJSON(url: Urls.linkUpComing) {[weak self] movies in
            self?.arrUpcoming = movies
            self?.delegate?.didUpdateData()
        }
        
    }
    
    
    func getUpcomming()-> [Movie]
    {
        return arrUpcoming ?? []
    }
    
    
    func getPopulates()->[Movie]{
        return arrPopulates ?? []
    }
   
    
    func searchMovie(id:String){
        
        //validamos en nuestro cache osea en los atributos de la clase
//        var movie = arrUpcoming?.filter({ movie in
//            return movie.id == Int(id)
//        }).first
//
//
//
//        if let movieSearched = movie {
//            delegate?.didSearchMovie(movie: movieSearched)
//            return
//        }
//
//        movie = arrPopulates?.filter({ movie in
//           return movie.id == Int(id)
//       }).first
//
//        if let movieSearched = movie {
//            delegate?.didSearchMovie(movie: movieSearched)
//            return
//        }
//
//
        
        
        //Aqui les toca hacer el nuevvo servicio y al devolver el resultado hay que invocar al delegate
        
        let apiService = SearchMovieService()
        
        apiService.excecute(idmovie: id) { [weak self] movie in
            self?.delegate?.didSearchMovie(movie: movie)
        }
        
    }
    
    
    
}
