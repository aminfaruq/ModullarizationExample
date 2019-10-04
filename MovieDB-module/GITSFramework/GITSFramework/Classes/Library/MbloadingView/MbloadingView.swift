//
//  Loading.swift
//  PertaminaGO
//
//  Created by GITS on 8/19/16.
//  Copyright © 2016 GITS. All rights reserved.
//

import UIKit

public protocol MbloadingProtocol {
    func doTryAgain(button:UIButton)
}

open class MbloadingView: UIView {
    @IBOutlet var viewParent: UIView!
    @IBOutlet weak var progressActivity: UIActivityIndicatorView!
    @IBOutlet weak var errorMessageUI: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    
    var delegate: MbloadingProtocol?
    
    func loadInView(view:UIView){
        errorMessageUI.isHidden = true
        tryAgainButton.isHidden = true
        progressActivity.isHidden = false
        progressActivity.startAnimating()
        self.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        view.insertSubview(self, aboveSubview: view)
        view.addConstraints([
            NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        ])
    }
    
    func showTryAgain(message:String, delegate:MbloadingProtocol?){
        self.delegate = delegate
        errorMessageUI.isHidden = false
        tryAgainButton.isHidden = false
        progressActivity.isHidden = true
        progressActivity.stopAnimating()
        errorMessageUI.text = message
    }
    
    func showEmptyData(message:String){
        errorMessageUI.isHidden = false
        tryAgainButton.isHidden = true
        progressActivity.isHidden = true
        progressActivity.stopAnimating()
        errorMessageUI.text = message
    }
    @IBAction func tryAgainAksiWithSender(sender: AnyObject) {
        delegate?.doTryAgain(button: sender as! UIButton)
        errorMessageUI.isHidden = true
        tryAgainButton.isHidden = true
        progressActivity.isHidden = false
        progressActivity.startAnimating()
    }
    
    func stop(){
        self.removeFromSuperview()
    }
}

public extension MbloadingView {
    public class func instantiateFromNib() -> MbloadingView {
        return UINib(nibName: "MbloadingView", bundle: bundle).instantiate(withOwner: nil, options: [:])[0] as! MbloadingView
    }
    
    static var bundle:Bundle {
        let podBundle = Bundle(for: MbloadingView.self)
        let bundleURL = podBundle.url(forResource: "GITSFramework", withExtension: "bundle")
        if bundleURL == nil {
            return podBundle
        }else{
            return Bundle(url: bundleURL!)!
        }
    }
}
