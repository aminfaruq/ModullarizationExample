//
//  BannerHome.swift
//  HomeModule
//
//  Created by Amin faruq on 27/09/19.
//  Copyright © 2019 Amin faruq. All rights reserved.
//

import UIKit

class BannerHome: UIView {
    @IBOutlet weak var imgBanner: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbGenre: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        self.imgBanner.clipsToBounds = true
        self.imgBanner.layer.cornerRadius = 10
    }
}

extension BannerHome{
    public class func instantiateFromNib() -> BannerHome {
        return UINib(nibName: "BannerHome", bundle: bundle).instantiate(withOwner: nil, options: [:])[0] as! BannerHome
    }
    
    static var bundle:Bundle {
        let podBundle = Bundle(for: BannerHome.self)
        let bundleURL = podBundle.url(forResource: "HomeModule", withExtension: "bundle")
        if bundleURL == nil {
            return podBundle
        }else{
            return Bundle(url: bundleURL!)!
        }
    }
}


