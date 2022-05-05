//
//  ExecuteJSON.swift
//  MobileAPICollection
//
//  Created by Hector Guadalupe Climaco Flores on 23/03/22.
//

import Foundation
class Urls {
    static let linkPopular = "https://api.themoviedb.org/3/movie/popular?api_key=c89f997b9f805d783c81fc1e854ed7d1"
    static let linkUpComing = "https://api.themoviedb.org/3/movie/upcoming?api_key=c89f997b9f805d783c81fc1e854ed7d1"
    static let searchMovie = "https://api.themoviedb.org/3/movie/{id}"
}

class ServiceManager {
    func execute(url:String, complited: @escaping (_ movies:[Movie])-> () ) {
        let urlSesion = URLSession.shared
        let url = URL(string: url)
        
        urlSesion.dataTask(with: url!) { data, response, error in
            if error == nil {
                do {
                    let response = try JSONDecoder().decode(MoviesPResponse.self, from: data!)
                    DispatchQueue.main.async {
                        complited(response.results)
                    }
                }catch{
                    print("json error")
                }
            }
        }.resume()
    }
    
}
class SearchMovieService {

    func excecute(idmovie:String, complited: @escaping (_ movies:Movie) -> () ) {
    
       
        let finalString = Urls.searchMovie .replacingOccurrences(of: "{id}", with: idmovie)
        
        let urlSession = URLSession.shared
        
        guard let url = URL(string: finalString) else {
            return
        }
        
        var requestUrl = URLRequest(url: url)

        let v4apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjODlmOTk3YjlmODA1ZDc4M2M4MWZjMWU4NTRlZDdkMSIsInN1YiI6IjYxOTZiYTkyYmMyY2IzMDA0Mjc4M2U0NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.n6hXlqHR9Fv4hHi_j3pZC0oJoKq8hJrU-owQodEkocQ"

        requestUrl.setValue( //4
            "application/json;charset=utf-8",
            forHTTPHeaderField: "Content-Type"
        )
    
        
        requestUrl.addValue("Bearer \(v4apiKey)" , forHTTPHeaderField: "Authorization")
        
        
        urlSession.dataTask(with: requestUrl) { (data, response, error) in

            if error == nil {
             
                do {
                    let responseModel = try JSONDecoder().decode(Movie.self, from: data!)
                 
                    print(responseModel)
                
                    DispatchQueue.main.async {
                       complited(responseModel)
                    }
                
                }catch {
                    print("error JSON")
                }
            }
        }.resume()
    }
    }
                                   
