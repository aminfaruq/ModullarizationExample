//
//  TitleSearchView.swift
//  GITSFramework
//
//  Created by GITS INDONESIA on 15/03/18.
//  Copyright © 2018 GITS Indonesia. All rights reserved.
//

import Foundation
import UIKit

public protocol TitleSearchViewDelegate {
    func textChange(text: String)
}

public class TitleSearchView: UIView {
    @IBOutlet public weak var textField: UITextField!
    public var delegateSearch: TitleSearchViewDelegate?
    
    public func setup(placeholder: String, text: String, delegate: UITextFieldDelegate) {
        self.textField.placeholder = placeholder
        self.textField.text = text
        self.textField.delegate = delegate
    }
    
    override public var intrinsicContentSize: CGSize {
        return UILayoutFittingExpandedSize
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }
    @IBAction func textChangeAction(_ sender: UITextField) {
        self.delegateSearch?.textChange(text: sender.text ?? "")
    }
}

public extension TitleSearchView {
    public class func instantiateFromNib() -> TitleSearchView {
        return UINib(nibName: "TitleSearchView", bundle: bundle).instantiate(withOwner: nil, options: [:])[0] as! TitleSearchView
    }
        
    static var bundle:Bundle {
        let podBundle = Bundle(for: TitleSearchView.self)
        let bundleURL = podBundle.url(forResource: "GITSFramework", withExtension: "bundle")
        if bundleURL == nil {
            return podBundle
        }else{
            return Bundle(url: bundleURL!)!
        }
    }
}

