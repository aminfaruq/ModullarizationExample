//
//  NetworkHome.swift
//  NetworkModule
//
//  Created by Amin faruq on 25/09/19.
//  Copyright © 2019 Amin faruq. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON 

public enum NetworkHome: URLRequestConvertible {
    static let baseURLString = MovieApps.GetUrl()
    //static let baseURLString = "https://api.themoviedb.org/3/"
    
    case doGetHome(apikey : String?)
    case getBanner(apiKey : String?)
    case getDiscover(apiKey : String? , sortBy :String? , withGenres : String?)
    case getGenre(apiKey : String?)
    case getCredits(movie : String? ,apiKey : String?)
    case getSimilar(movie : String? , apiKey : String?)
    
    var method: HTTPMethod {
        switch self {
        case .doGetHome(_):
            return .get
        case .getBanner(_):
            return .get
        case .getDiscover(_,_,_):
            return .get
        case .getGenre(_):
            return .get
        case .getCredits(_,_):
            return .get
        case .getSimilar(_,_):
            return .get
        default:
            break
        }
    }
    
    
    var res: (path: String, param: [String: Any]) {
        switch self {
        case .doGetHome(let apiKey):
            return ("movie/now_playing" , ["api_key" : apiKey ?? ""])
        case .getBanner(let apiKey):
            return ("movie/now_playing" , ["api_key" : apiKey ?? ""])
        case .getDiscover(let apiKey , let sortBy , let withGenres):
            return ("discover/movie" , ["api_key" : apiKey ?? "", "sort_by" : sortBy ?? "" , "with_genres" : withGenres ?? ""] )
        case .getGenre(let apiKey):
            return ("genre/movie/list" , ["api_key" : apiKey ?? ""])
        case .getCredits(let movie, let apiKey):
            return ("movie/\(movie ?? "")/credits", ["api_key" : apiKey ?? ""])
        case .getSimilar(let movie, let apiKey):
            return ("movie/\(movie ?? "")/similar" , ["api_key" : apiKey ?? ""])
        default:
            break
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        var url: URL?
        var urlRequest: URLRequest?
        url = try NetworkHome.baseURLString.asURL()
        urlRequest = URLRequest(url: (url?.appendingPathComponent(res.path))!)
        urlRequest?.httpMethod = method.rawValue
        
        urlRequest = try URLEncoding.default.encode(urlRequest!, with: res.param)
        print("URL API => "+(urlRequest?.url?.absoluteString)!)
        print("Parameter => \(res.param)")
        return urlRequest!
    }
}

