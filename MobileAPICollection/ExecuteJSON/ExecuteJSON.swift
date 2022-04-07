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
    static let searchMovies = "https://api.themoviedb.org/3/movie/{id}"
}

class ExecuteJSON {
    
    func executeJSON(url:String, complited: @escaping (_ movies:[Movie])-> () ) {
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
    
    func excecute2(idmovie:String, url:String, complited: @escaping (_ movies:Movie) -> () ) {
    
        let finalString = url.replacingOccurrences(of: "{id}", with: idmovie)
        // en donde se guardara la URL
    
        
        let urlSession = URLSession.shared
        // direccion de la URL
        let url = URL(string: finalString)
        let tokenm = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjODlmOTk3YjlmODA1ZDc4M2M4MWZjMWU4NTRlZDdkMSIsInN1YiI6IjYxOTZiYTkyYmMyY2IzMDA0Mjc4M2U0NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.n6hXlqHR9Fv4hHi_j3pZC0oJoKq8hJrU-owQodEkocQ"
        
        urlSession.configuration.httpAdditionalHeaders = [
            "Authorization" : "Bearer \(tokenm)"]
        

        urlSession.dataTask(with: url!) { (data, response, error) in
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
    
    func excecute(idmovie:String, complited: @escaping (_ movies:Movie) -> () ){
        guard let movieDetail = URL( //1
            string: Urls.searchMovies.replacingOccurrences(of: "{id}", with: idmovie)
        ) else { return  }
        
        var movieRequest = URLRequest( //2
            url: movieDetail
        )
        let v4apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjODlmOTk3YjlmODA1ZDc4M2M4MWZjMWU4NTRlZDdkMSIsInN1YiI6IjYxOTZiYTkyYmMyY2IzMDA0Mjc4M2U0NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.n6hXlqHR9Fv4hHi_j3pZC0oJoKq8hJrU-owQodEkocQ"
        movieRequest.setValue( //3
            "Bearer \(v4apiKey)",
            forHTTPHeaderField: "Authentication"
        )
        movieRequest.setValue( //4
            "application/json;charset=utf-8",
            forHTTPHeaderField: "Content-Type"
        )
       let sessionConfiguration = URLSessionConfiguration.default // 5

        sessionConfiguration.httpAdditionalHeaders = [
            "Authorization": "Bearer \(v4apiKey)" // 6
        ]
        
        URLSession.shared.dataTask(with: movieRequest) { (data, response, error) in
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
                                   
