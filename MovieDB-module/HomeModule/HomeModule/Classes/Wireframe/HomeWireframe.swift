//
//  HomeWireframe.swift
//  HomeModule
//
//  Created by Amin faruq on 25/09/19.
//  Copyright © 2019 Amin faruq. All rights reserved.
//

import Foundation
import GITSFramework

public struct HomeWireframe {
    
    public static func performToMovie(caller: UIViewController) {
        let storyboard = UIStoryboard(name: "Home", bundle: bundleNotification)
        let nav = storyboard.instantiateInitialViewController()! as! UINavigationController
        let vc = nav.topViewController as! HomeVC
        caller.navigationController?.pushViewController(vc, animated: true)
    }
    
    public static func performToDetailMovie(imageUrl: String, title: String, overviewLabel: String, movieId: Int,date: String, caller: UIViewController) {
        let storyBoard = UIStoryboard(name: "Detail", bundle: bundleDetail)
        let nav = storyBoard.instantiateInitialViewController()! as! UINavigationController
        let vc = nav.topViewController as! DetailVC
        vc.imgMovie = imageUrl
        vc.labelTitle = title
        vc.labelOverview = overviewLabel
        vc.movie_id = movieId
        vc.labelDate = date
        caller.navigationController?.pushViewController(vc, animated: true)
    }
    
    public static func performToDiscoverMovie( genreId: Int, caller: UIViewController){
        let storyBoard = UIStoryboard(name: "Discover", bundle: bundleDiscover)
        let nav = storyBoard.instantiateInitialViewController()! as! UINavigationController
        let vc = nav.topViewController as! DiscoverVC
        vc.id_genre = genreId
        caller.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    static var bundleNotification : Bundle{
        let podBundle = Bundle(for: HomeVC.self)
        let bundleURL = podBundle.url(forResource: "HomeModule", withExtension: "bundle")
        if bundleURL == nil {
            return podBundle
        }else{
            return Bundle(url: bundleURL!)!
        }
    }
    
    static var bundleDetail: Bundle {
        let podBundle = Bundle(for: DetailVC.self)
        let bundleURL = podBundle.url(forResource: "HomeModule", withExtension: "bundle")
        if bundleURL == nil {
            return podBundle
        } else {
            return Bundle(url: bundleURL!)!
        }
    }
    
    static var bundleDiscover: Bundle {
        let podBundle = Bundle(for: DiscoverVC.self)
        let bundleURL = podBundle.url(forResource: "HomeModule", withExtension: "bundle")
        if bundleURL == nil {
            return podBundle
        } else {
            return Bundle(url: bundleURL!)!
        }
    }
    
}
