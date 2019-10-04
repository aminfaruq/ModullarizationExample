//
//  LoadingMoreCell.swift
//  GITSFramework
//
//  Created by Ajie Pramono Arganata on 03/05/18.
//  Copyright © 2018 GITS Indonesia. All rights reserved.
//

import UIKit

public class LoadingMoreCell: UITableViewCell {
    @IBOutlet public weak var progressUI: UIActivityIndicatorView!
}

public extension LoadingMoreCell {
    public static var name = "LoadingMoreCell"
    public class func instantiateFromNib() -> UINib {
        return UINib(nibName: LoadingMoreCell.name, bundle: bundle)//.instantiate(withOwner: nil, options: [:])[0] as! LoadingMoreCell
    }
    
    public static var bundle:Bundle {
        let podBundle = Bundle(for: LoadingMoreCell.self)
        let bundleURL = podBundle.url(forResource: "GITSFramework", withExtension: "bundle")
        if bundleURL == nil {
            return podBundle
        }else{
            return Bundle(url: bundleURL!)!
        }
    }
    
    public static func registerNib(_ tableView: UITableView) {
        tableView.register(self.instantiateFromNib(), forCellReuseIdentifier: LoadingMoreCell.name)
    }
    
    public static func initCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LoadingMoreCell.name, for: indexPath) as! LoadingMoreCell
        cell.selectionStyle = .none
        return cell
    }
}
