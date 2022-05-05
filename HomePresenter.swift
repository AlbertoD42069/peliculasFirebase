//
//  HomePresenter.swift
//  MobileAPICollection
//
//  Created by
//

import Foundation


struct MovieViewData{
    let id:Int
    let title: String
    let image: String
    let rating : Double
    let resume : String
    let date : String
    
}

protocol HomeView {
    func startLoading()
    func finishLoading()
    func setUsers(_ users: [MovieViewData])
    func setEmptyUsers()
    func addfavorite(movieId:String)
}



class UserPresenter {
    let userService:ServiceManager
    var userView : HomeView?
    
    init(userService:ServiceManager){
        self.userService = userService
    }
    
    func attachView(_ view:HomeView){
        userView = view
    }
    
    func detachView() {
        userView = nil
    }
    
    func getMovies(){
        self.userView?.startLoading()
        userService.execute(url: Urls.linkPopular, complited:{ [weak self] movies in
            self?.userView?.finishLoading()
            if(movies.count == 0){
                self?.userView?.setEmptyUsers()
            }else{
                let mappedUsers = movies.map{
                    return MovieViewData(id:$0.id,title: $0.title, image: $0.poster_path, rating: $0.vote_average, resume: $0.overview, date: $0.release_date)
                }
                self?.userView?.setUsers(mappedUsers)
            }
            
        })
    }
    func addfavorite(movie:MovieViewData){        
        let favoriteManager = FavoritesManager()
        favoriteManager.setFavorites(movie: movie)
    }
    
}

