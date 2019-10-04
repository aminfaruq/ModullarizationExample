//
//  HomePresenter.swift
//  HomeModule
//
//  Created by Amin faruq on 25/09/19.
//  Copyright © 2019 Amin faruq. All rights reserved.
//

import Foundation
import GITSFramework

protocol HomeRequest: BaseRequest {
    func doGetMovieList()
    func getBanner()
    func getGenre()
    func getCredit(movie_id : String?)
    func getSimilar(movie_id : String?)
    func getDiscover (withGenres : String?)
}


protocol HomeResponse : BaseResponse {
    func displayGetNotificationList(result: [MovieModel])
    func displayGetBanner(result : [MovieModel])
    func displayGetGenre(result : [GenreModel])
    func displayGetCredit(result : [CreditsModel])
    func displayGetSimilar(result : [MovieModel])
    func displayGetDiscover(result : [DiscoverModel])
}

extension HomeResponse {
    func displayGetNotificationList(result: [MovieModel]) {}
    func displayGetBanner(result : [MovieModel]) {}
    func displayGetGenre(result : [GenreModel]){}
    func displayGetCredit(result : [CreditsModel]){}
    func displayGetSimilar(result : [MovieModel]){}
    func displayGetDiscover(result : [DiscoverModel]){}
}

struct HomePresenter: HomeRequest {
   
    weak var output: HomeResponse?
    
    func getDiscover( withGenres: String?) {
        HomeWorker.doGetDiscover(withGenres: withGenres, onSuccess: { (result) in
            self.output?.displayGetDiscover(result: result)
        }) { (error) in
            self.output?.displayError(message: error, object: "")
        }
    }
    
    
    func getSimilar(movie_id: String?) {
        HomeWorker.doGetSimilar(movie_id: movie_id, onSuccess: { (result) in
            self.output?.displayGetSimilar(result: result)
        }) { (error) in
            self.output?.displayError(message: error, object: "")
        }
    }
    
    func getCredit(movie_id: String?) {
        HomeWorker.doGetCredit(movie_id: movie_id, onSuccess: { (result) in
            self.output?.displayGetCredit(result: result)
        }) { (error) in
            self.output?.displayError(message: error, object: "")
        }
    }
    
    
    func getGenre() {
        HomeWorker.doGetGenre(onSuccess: { (result) in
            self.output?.displayGetGenre(result: result)
        }) { (error) in
            self.output?.displayError(message: error, object: "")        }
    }
    
    func getBanner() {
        HomeWorker.doGetBanner(onSuccess: { (result) in
            self.output?.displayGetBanner(result: result)
        }) { (error) in
            self.output?.displayError(message: error, object: "")
        }
    }
    
    
    func doGetMovieList() {
        HomeWorker.doGetMovies(onSuccess: {(result) in
            self.output?.displayGetNotificationList(result: result)
        }) { (error) in
            self.output?.displayError(message: error, object: "")
        }
    }
}
