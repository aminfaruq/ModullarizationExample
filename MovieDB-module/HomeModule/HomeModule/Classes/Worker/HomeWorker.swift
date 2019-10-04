//
//  HomeWorker.swift
//  HomeModule
//
//  Created by Amin faruq on 25/09/19.
//  Copyright © 2019 Amin faruq. All rights reserved.
//

import GITSFramework
import NetworkModule
import SwiftyJSON
import Foundation

// MARK: - Implement API TNC
public class HomeWorker {
    
    private static let API_KEY = "5ba01fa664bad862f5c8f6cbbec5f291"
    
    static func doGetDiscover( withGenres : String?, onSuccess: @escaping (_ result: [DiscoverModel]) -> Void, onFailure: @escaping onError) {
        
        GITSNet.request(request: NetworkHome.getDiscover(apiKey: API_KEY, sortBy: "popularity.desc", withGenres: withGenres), onRequest: {_ in}, onSuccess: { (rawJSON) in
            
            let response = DAOMovieListBaseClass(json: rawJSON)
            var models : [DiscoverModel] = []
            
            if response.results != nil {
                for data in response.results ?? [] {
                    var discoverModel = DiscoverModel()
                    discoverModel = DiscoverModel(posterPath: data.posterPath, id: data.id, title: data.title, overview: data.overview, releaseDate: data.releaseDate)
                    
                    models.append(discoverModel)
                }
                
                onSuccess(models)
            }
            
        }) { (error) in
            onFailure(error)
        }
        
    }
    
    static func doGetSimilar(movie_id : String? , onSuccess: @escaping (_ result: [MovieModel]) -> Void, onFailure: @escaping onError){
        
        GITSNet.request(request: NetworkHome.getSimilar(movie: movie_id, apiKey: API_KEY), onRequest: {_ in}, onSuccess: { (rawJSON) in
            
            let response = DAOMovieListBaseClass(json: rawJSON)
            var models : [MovieModel] = []
            
            if response.results != nil {
                for data in response.results ?? []{
                    var similarModel = MovieModel()
                    similarModel = MovieModel(posterPath: data.posterPath, id: data.id, title: data.title, overview: data.overview, releaseDate: data.releaseDate)
                    models.append(similarModel)
                }
                onSuccess(models)
            }
        }) { (error) in
            onFailure(error)
        }
        
    }
    
    static func doGetCredit(movie_id : String? , onSuccess: @escaping (_ result: [CreditsModel]) -> Void, onFailure: @escaping onError) {
        
        GITSNet.request(request: NetworkHome.getCredits(movie: movie_id, apiKey: API_KEY), onRequest: {_ in}, onSuccess: { (rawJSON) in
            
            let response = DAOCreditsListBaseClassBaseClass(json: rawJSON)
            
            var creditsModels : [CreditsModel] = []
            
            if response.cast != nil {
                for data in response.cast ?? [] {
                    var creditModel = CreditsModel()
                    
                    creditModel = CreditsModel(id: data.id, name: data.name, profile_path:
                        data.profilePath, character: data.character, cast_id: data.castId)

                    creditsModels.append(creditModel)
                }
                onSuccess(creditsModels)
            }
            
        }) { (error) in
            onFailure(error)
        }
        
        
    }
    
    static func doGetGenre(onSuccess: @escaping (_ result: [GenreModel]) -> Void, onFailure: @escaping onError){
        
        GITSNet.request(request: NetworkHome.getGenre(apiKey: API_KEY), onRequest: {_ in}, onSuccess: { (rawJason) in
            
            let response = DAOGenreListBaseClassBaseClass(json: rawJason)
            print(response)
            
            var genreModels : [GenreModel] = []
            
            if response.genres != nil {
                for data in response.genres ?? [] {
                    var model = GenreModel()
                    model = GenreModel(id: data.id, name: data.name)
                    
                    genreModels.append(model)
                   
                }
                onSuccess(genreModels)
            }
            
        }) { (error) in
            print(error)
            onFailure(error)
        }
        
    }
    static func doGetBanner(onSuccess: @escaping (_ result: [MovieModel]) -> Void, onFailure: @escaping onError) {
        GITSNet.request(request: NetworkHome.getBanner(apiKey: API_KEY), onRequest: {_ in}, onSuccess: {(rawJson) in
            
            let response = DAOMovieListBaseClass(json: rawJson)
            print(response)
            
            var models : [MovieModel] = []
            
            if response.results != nil{
                for data in response.results ?? []{
                    var model = MovieModel()
                    model = MovieModel(posterPath: data.posterPath, id: data.id, title: data.title, overview: data.overview, releaseDate: data.releaseDate)
                    
                    models.append(model)
                }
                
                onSuccess(models)
            }
            
            
        }) { (error) in
            print(error)
            onFailure(error)
        }
    }
    
  
    
    static func doGetMovies(onSuccess: @escaping (_ result: [MovieModel]) -> Void, onFailure: @escaping onError) {
        GITSNet.request(request: NetworkHome.doGetHome(apikey: API_KEY ), onRequest: { _ in}, onSuccess: { (rawJson) in
            
            let response = DAOMovieListBaseClass(json: rawJson)
            print(response)
            var models : [MovieModel] = []

            
            if response.results != nil {

                for data in response.results ?? []{
                    var model = MovieModel()
                    model = MovieModel(posterPath: data.posterPath, id: data.id, title: data.title, overview: data.overview, releaseDate: data.releaseDate)
                    
                    models.append(model)
                }
                
                onSuccess(models)
                
            }
            
        }) { (error) in
            print(error)
            onFailure(error)
        }
    }
    
}
