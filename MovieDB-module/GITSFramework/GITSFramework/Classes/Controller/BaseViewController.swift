//
//  BaseViewController.swift
//  GITSFramework
//
//  Created by GITS Indonesia on 3/14/17.
//  Copyright © 2017 GITS Indonesia. All rights reserved.
//

import UIKit
import Alamofire
import SwiftMessages
import HexColors
import Material
import ChameleonFramework

open class  BaseViewController: UIViewController {
    public var baseDelegate: GITSRootDelegate?
    public var performDelegate: GITSPerformDelegate?
    public var loadingView: MbloadingView?
    public var emptyView: EmptyView?
    public var heightStatusNavBar: CGFloat = 0
    public var request: DataRequest?
    public var snackBarTimer: Timer?
    public var isShowSnackBar = false
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.heightStatusNavBar = (UIApplication.shared.statusBarFrame.size.height)  + (self.navigationController?.navigationBar.frame.height ?? 0.0)
        NotificationCenter.default.addObserver(self, selector: #selector(deviceRotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        self.dismissSnackbar(completion: nil)
    }
    
    @objc open func deviceRotated() {
        self.heightStatusNavBar = (UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0))
        self.baseDelegate?.didRotate()
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    open func configLeftTitleView() {
        let titleView = TitleView.instantiateFromNib()
        titleView.frame = CGRect(x: 8, y: 0, width: self.navigationController?.navigationBar.frame.size.width ?? 0, height: 34)
        let barButton = UIBarButtonItem(customView: titleView)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    open func configTransparantBar(color: String) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = UIColor(color)
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor.clear
    }
    
    open func configColorBar(colorBar: String, colorTitle: String, colorBarButton: String, alpha: CGFloat = 1, isTranslucent: Bool = false) {
        self.navigationController?.navigationBar.setBackgroundImage(alpha == 1 ? nil : UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = alpha == 1 ? nil : UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor(colorBarButton)?.withAlphaComponent(alpha)
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
//        self.navigationController?.view.backgroundColor = UIColor(colorBar)?.withAlphaComponent(alpha)
        self.navigationController?.navigationBar.barTintColor = UIColor(colorBar)?.withAlphaComponent(alpha)
        self.navigationController?.navigationBar.backgroundColor = UIColor(colorBar)?.withAlphaComponent(alpha)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor(colorTitle)!.withAlphaComponent(alpha)
        ]
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = alpha == 1 ? UIColor.clear : UIColor(colorBar)?.withAlphaComponent(alpha)
    }
    
    open func configColorBar(colorBar: [UIColor], colorTitle: String, colorBarButton: String, alpha: CGFloat = 1, isTranslucent: Bool = false) {
        self.navigationController?.navigationBar.setBackgroundImage(alpha == 1 ? nil : UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = alpha == 1 ? nil : UIImage()
        self.navigationController?.navigationBar.tintColor = UIColor(colorBarButton)?.withAlphaComponent(alpha)
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        //        self.navigationController?.view.backgroundColor = UIColor(colorBar)?.withAlphaComponent(alpha)
        self.navigationController?.navigationBar.barTintColor = UIColor(gradientStyle: .topToBottom, withFrame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.heightStatusNavBar), andColors: colorBar)?.withAlphaComponent(alpha)
        self.navigationController?.navigationBar.backgroundColor = UIColor(gradientStyle: .topToBottom, withFrame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.heightStatusNavBar), andColors: colorBar)?.withAlphaComponent(alpha)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor(colorTitle)!.withAlphaComponent(alpha)
        ]
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = alpha == 1 ? UIColor.clear : UIColor(gradientStyle: .topToBottom, withFrame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.heightStatusNavBar), andColors: colorBar)?.withAlphaComponent(alpha)
    }
    
    
}

extension BaseViewController: MbloadingProtocol {
    open func showLoading(view: UIView){
        loadingView = MbloadingView.instantiateFromNib()
        loadingView?.loadInView(view: view)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    open func showLoadNet(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    open func stopLoadNet(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    open func stopLoading(isError: Bool, message: String){
        if isError {
            showTryAgain(message: message)
        } else {
            loadingView?.stop()
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    public func doTryAgain(button: UIButton) {
        baseDelegate?.doTryAgain()
    }
    
    func showTryAgain(message:String) {
        loadingView?.showTryAgain(message: message, delegate: self)
    }
}

// MARK: EmptyView
extension BaseViewController {
    
    //navigation section
    open func setupNavbar() {
        self.configTransparantBar()
        let imageBack = UIImage(named: "ic-back")
        self.navigationController?.navigationBar.backIndicatorImage = imageBack
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = imageBack
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor("#505050") ?? UIColor.white, NSAttributedStringKey.font : UIFont(name: "Avenir-Black", size: 20)! ]
    }
    
    
    open func configTransparantBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = UIColor("#1356A3")
        //        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Avenir-Book", size: 15)!]
    }
    open func showEmptyView(view: UIView, title: String = "", message: String = ""){
        if self.emptyView == nil {
            self.emptyView = EmptyView.instantiateFromNib()
            self.emptyView?.create(view: view, title: title, message: message)
        }
    }
    
    open func hideEmptyView(){
        self.emptyView?.removeView()
        self.emptyView = nil
    }
}

// MARK: Setup SnackBar
extension BaseViewController {
    open func showSnackbar(message: String, delay: Double = 4, completion: ((Snackbar) -> Void)? = nil) {
        self.snackBarTimer?.invalidate()
        self.dismissSnackbar { (snackbar) in
            self.prepareSnackbar(message: message)
            self.animateSnackbar(delay: delay, completion: completion)
        }
    }
    
    fileprivate func prepareSnackbar(message: String) {
        guard let snackbar = snackbarController?.snackbar else {
            return
        }
        snackbar.text = message
    }
    
    @objc
    fileprivate func animateSnackbar(delay: Double, completion: ((Snackbar) -> Void)? = nil) {
        guard let sc = snackbarController else {
            return
        }
        self.isShowSnackBar = true
        _ = sc.animate(snackbar: .visible, delay: 0)
        if completion != nil {
            _ = sc.animate(snackbar: .hidden, delay: delay, animations: nil, completion: completion)
        } else {
            self.snackBarTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.dismissSnackbar), userInfo: nil, repeats: false)
        }
    }
    
    public func dismissSnackbar(completion: ((Snackbar) -> Void)? = nil) {
        guard let sc = snackbarController else {
            return
        }
        if self.isShowSnackBar {
            self.isShowSnackBar = false
            sc.animate(snackbar: .hidden, delay: 0, animations: nil, completion: completion)
        } else {
            completion?(sc.snackbar)
        }
    }
    
    @objc
    fileprivate func dismissSnackbar() {
        guard let sc = snackbarController else {
            return
        }
        sc.animate(snackbar: .hidden, delay: 0)
        self.isShowSnackBar = false
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismissSnackbar()
    }
}
