import Foundation

protocol RepositoryDelegateProtocol {
    func didUpdateData()
    func didSearchMovie(movie:Movie)
}

class MoviesRepository {
  
    var delegate: RepositoryDelegateProtocol?

    var arrPopulates : [Movie]?
    init(){}
    
    func getData(){
        let servicesManager = ServiceManager()
        servicesManager.execute(url: Urls.linkPopular) { [weak self] movies in
            self?.arrPopulates = movies
            self?.delegate?.didUpdateData()
        }
       
    }

    func getPopulates()->[Movie]{
        return arrPopulates ?? []
    }
   
    
    func searchMovie(id:String){
        let apiService = SearchMovieService()
    
        apiService.excecute(idmovie: id) { [weak self] movie in
            self?.delegate?.didSearchMovie(movie: movie)
        }
    }
    
    
    
}
