//
//  repositorio.swift
//  MobileAPICollection
//
//  Created by Hector Guadalupe Climaco Flores on 07/04/22.
//

import Foundation
/*
 uso de protocolos en las clases. para usar el patron de delegados con protocolos se realiza de la siguiendo los pasos:
 
 1// crear el protocolo que se debe de usar, como buena practica, en el nombre del protocolo se debe de colocar <protocol> al final del nombre del protocolo. ejemplo <RepositoryDelegateProtocol>
 ESTE PROCESO SE DICE QUE ES EL DEFINICION DE DELEGADO ATRAVEZ DE UN DELEGADO.
 */
protocol RepositoryDelegateProtocol {
/*
 2// crear las funciones que implementa el protocolo
     en los protocolos no se desarrollan las funciones.
 */
    func didUpdateData() //funcion de protocolo que no recibe parametros
    func didSearchMovie(movie:Movie) //funcion del protocolo que recibe un parametro de tipo movie

}

class MoviesRepository {
    
    /*
     3// se crea una variable el cual sera el delegado, la variable siempre debe de ser del tipo protocolo
     en este caso nuestro protocolo se llama <RepositoryDelegateProtocol> por lo tanto la variable que es el delegado debe de ser de este tipo
     */
    var delegate: RepositoryDelegateProtocol?
    
    
    var arrPopulates : [Movie]?
    var arrUpcoming : [Movie]?
   
    /*
     inicializador de la clase.
     */
    init(){}
    
    /*
     funcion get data es la que consume el servicio usando la clase <ExecuteJSON>.
     */
    func getData(){
        let servicesManager = ExecuteJSON()//la sintanxis indica que se ha instanciado la clase <ExecuteJSON> en la variable <servicesManager>
        
        /*
         la sintaxis weak self se trata de de una referencia debil que hace el clouser a si mismo
         */
        servicesManager.executeJSON(url: Urls.linkPopular) { [weak self] movies in
            self?.arrPopulates = movies
            
            /*
             4// acontinuacion se implementa las funciones del protocolo usando la variable la cual se indico que es un delegado
             */
            self?.delegate?.didUpdateData()
        }
        let serviceForUpcomming = ExecuteJSON()
        serviceForUpcomming.executeJSON(url: Urls.linkUpComing) {[weak self] movies in
            self?.arrUpcoming = movies
            /*
             4// acontinuacion se implementa las funciones del protocolo usando la variable la cual se indico que es un delegado
             */
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
        
        
        
        
        //Aqui les toca hacer el nuevvo servicio y al devolver el resultado hay que invocar al delegate
        
        let apiService = SearchMovieService()
        
        apiService.excecute(idmovie: id) { [weak self] movie in
            /*
             4// acontinuacion se implementa las funciones del protocolo usando la variable la cual se indico que es un delegado
             */
            self?.delegate?.didSearchMovie(movie: movie)
        }
        
    }
    
    
    
}
