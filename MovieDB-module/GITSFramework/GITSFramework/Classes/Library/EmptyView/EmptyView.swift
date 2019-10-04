//
//  EmptyView.swift
//  GITSFramework
//
//  Created by GITS INDONESIA on 11/27/17.
//  Copyright © 2017 GITS Indonesia. All rights reserved.
//

import UIKit

open class EmptyView: UIView {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    
    public func create(view: UIView, title: String = "", message: String = "") {
        self.titleLbl.text = title
        self.detailLbl.text = message
        self.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        view.insertSubview(self, aboveSubview: view)
    }
    
    public func removeView() {
        self.removeFromSuperview()
    }
}

public extension EmptyView {
    class func instantiateFromNib() -> EmptyView {
        return UINib(nibName: "EmptyView", bundle: bundle).instantiate(withOwner: nil, options: [:])[0] as! EmptyView
    }
    
    static var bundle:Bundle {
        let podBundle = Bundle(for: EmptyView.self)
        let bundleURL = podBundle.url(forResource: "GITSFramework", withExtension: "bundle")
        if bundleURL == nil {
            return podBundle
        }else{
            return Bundle(url: bundleURL!)!
        }
    }
}
