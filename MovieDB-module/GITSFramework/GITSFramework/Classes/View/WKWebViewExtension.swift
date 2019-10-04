//
//  WKWebViewExtension.swift
//  GITSFramework
//
//  Created by Alvira Nurhaliza Wijaya on 01/02/19.
//  Copyright © 2019 GITS Indonesia. All rights reserved.
//

import Foundation
import WebKit

public extension WKWebView {
    
    public func disableLongTapOnLink() {
        self.evaluateJavaScript("document.body.style.webkitTouchCallout='none';")
    }
    
    public func getContentHeight(onSuccess: @escaping (_ result: CGFloat) -> Void, onFailed: @escaping (_ error: Error) -> Void) {
        self.evaluateJavaScript("document.body.scrollHeight") { (result, error) in
            print("result: \(result ?? ""), error: \(error)")
            if let height = result as? CGFloat {
                onSuccess(height)
            }
            else {
                if let error = error {
                    onFailed(error)
                }
                else {
                    onSuccess(0)
                }
            }
        }
    }
    
}
