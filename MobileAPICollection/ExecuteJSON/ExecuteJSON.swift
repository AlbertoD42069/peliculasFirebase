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

class ExecuteJSON {
    
    /*
     la keywork @escaping es para que el contexto del clouser funcion se almacene para poder ser usado en otro momento.
     en este caso la funcion queda en un segundo plano y hara la peticion cuando se le requiera.
     */
    func executeJSON(url:String, complited: @escaping (_ movies:[Movie])-> () ) {
        
        //instancia del singletos URLSession el cual es el encargado de realizar las peticiones de http
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
    
    /*
     la keywork @escaping es para que el contexto del clouser funcion se almacene para poder ser usado en otro momento.
     en este caso la funcion queda en un segundo plano y hara la peticion cuando haya terminado y retornado.
     */
    func excecute(idmovie:String, complited: @escaping (_ movies:Movie) -> () ) {
    
        /*asignacion de la url del servicio a una variable por medio de otra clase */
        let finalString = Urls.searchMovie .replacingOccurrences(of: "{id}", with: idmovie)
        // en donde se guardara la URL ademas de que se cambia los caracteres {id} por el objeto idmovie el cual es uno de los objetos que la funcion recibe
    
        //administrador o coordinador de las solicitudes que realiza su aplicación
        let urlSession = URLSession.shared
        // direccion del singleton de URLsession
        
        /*verificacion que si la condicion es correcta*/
        
        /*es decir que si no estamos asignando el url de forma correcta el URL la funcion saldra pero
        definicion de la url */
        guard let url = URL(string: finalString) else {
            return
        }
        /*el urlrequest estructura encapsula la información que la sesión de URL necesita para realizar la solicitud HTTP.*/
        
        /*
        poniendo de ejemplo ir de a comprar despensa, con una lista.
        en terminos de programacion.
         la tienda es el servidor.
         el que ba a realizar las compras es el URLSession
         la lista de lo que se debe de comprar es el URLRequest.
         
         por tanto el URLRequest indica al URLSesion especificamente que debe de traer el JSON.
         
         por eso solo trae el JSON de una pelicula.
         URLRequest en español significa solicitudURL
         */
        var requestUrl = URLRequest(url: url)
        
        /*este objeto es el quivalente en la analogia de la tienda a una llave o una clave, no es el objeto es la clave para acceder al objeto.
         
         la parte del json que deseamos asignar el api key es que le da la autorizacion para accederlo*/
        let v4apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjODlmOTk3YjlmODA1ZDc4M2M4MWZjMWU4NTRlZDdkMSIsInN1YiI6IjYxOTZiYTkyYmMyY2IzMDA0Mjc4M2U0NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.n6hXlqHR9Fv4hHi_j3pZC0oJoKq8hJrU-owQodEkocQ"
       
        
        /*
         el setValues es el equivalente en la analogia de la tienda a indicarle en que forma debe de traer lo que se le solicita
         en este caso se le indica al URLRequest en que formato se debe traer la peticion realizada.
         
         cabe mencionar que se le puede deci que lo traiga en disferentes formatos.
         */
        requestUrl.setValue( //4
            "application/json;charset=utf-8",
            forHTTPHeaderField: "Content-Type"
        )
        
        /*
         el addValue es el quivalente en la analogia de la compra a agregarlo a la lista.
        
         en contexto de programacion le esta indicando al objeto requestUrl el cual es igual al URLRequest
         cual es el objeto que debe de traer, es decir que parte del json y no todo el json
         */
        
        requestUrl.addValue("Bearer \(v4apiKey)" , forHTTPHeaderField: "Authorization")
        
        
        //el metodo datatask invoca a la tarea de datos.  Este método devuelve una URLSessionDataTaskinstancia
        // lo del { (data, response, error) en adelante es un bloque de finalizacion, es decir que cuando la tarea de data task se realiza existen 3 posibles respuestas
        urlSession.dataTask(with: requestUrl) { (data, response, error) in
       
        /*
         validacion de si el error es nulo se realiza el do.
         al decir que el error es nulo se especifica que no hay error o no existe
         */
            if error == nil {
                
                /*
                 si se encuetra error en al tarea dataTask el do pasa al catch es decir que no se pudo conectar con el json
                 si no existe error la sentencia pasa al do.
                 
                 donde a la variable responseModel se le asigna que decodifique el json usando la struct movie el cual es modelo de datos que se ajusta al del json.
                 */
                do {
                    let responseModel = try JSONDecoder().decode(Movie.self, from: data!)
                    /*
                     una vez decodificado el json se imprime
                     */
                    print(responseModel)
                    
                    /*
                     esperará la ejecución de la tarea (cola en serie) o puede ejecutar la siguiente tarea antes de que finalice la tarea actual (cola concurrente).
                     
                     se trata de una llamada asíncrona, una operación pesada agregada puede congelar la interfaz de usuario ya que sus operaciones se ejecutan en serie en el subproceso principal. Si se llama a este método desde el subproceso en segundo plano, el control volverá a ese subproceso instantáneamente, incluso cuando la interfaz de usuario parezca estar congelada. Esto se debe a que asyncla llamada se realiza enDispatchQueue.main2
                     */
                    DispatchQueue.main.async {
                       complited(responseModel)
                    }
                /*si existe un error aki es donde la sentencia cae*/
                }catch {
                    print("error JSON")
                }
            }
        }.resume()
    }
    }
                                   
