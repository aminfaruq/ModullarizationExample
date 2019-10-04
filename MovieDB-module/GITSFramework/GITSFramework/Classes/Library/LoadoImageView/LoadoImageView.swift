//
//  LoadoImageView.swift
//  Tradepost
//
//  Created by AJIE ARGANATA on 10/11/17.
//  Copyright © 2017 GITS INDONESIA. All rights reserved.
//

import UIKit
import HexColors

extension UIImageView {
    
    //Start or Stop a loading view in an ImageView
    public func setLoad(isLoad: Bool, style: UIActivityIndicatorView.Style) {
        if isLoad {
            if subviews.count == 0 {
                let progress = UIActivityIndicatorView(activityIndicatorStyle: style)
                progress.startAnimating()
                progress.color = UIColor("#2B333C")
                self.insertSubview(progress, aboveSubview: self)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    progress.center = self.center
                }
            }
        } else {
            self.subviews.forEach{ $0.removeFromSuperview() }
        }
    }
}
