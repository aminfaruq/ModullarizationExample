//
//  SwiftMessageExtension.swift
//  GITSFramework
//
//  Created by GITS Indonesia on 3/16/17.
//  Copyright © 2017 GITS Indonesia. All rights reserved.
//

import Foundation
import SwiftMessages

extension SwiftMessages {
    public static func LineErrorNetwork(message:String) {
        
    }
    
    public static func DialogErrorWithTryAgain(message:String,handle:((_ button: UIButton) -> Void)?){
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.error)
        view.configureDropShadow()
        view.button?.isHidden = false
        view.button?.titleLabel?.text = "Retry"
        view.button?.setTitle("Retry", for: UIControlState.normal)
        view.configureContent(title: "Fail", body: message)
        view.buttonTapHandler = handle
        SwiftMessages.show(view: view)
    }
    public static func DialogError(message:String){
        
    }
    public static func SuccessMessage(message:String){
    
    }
}
