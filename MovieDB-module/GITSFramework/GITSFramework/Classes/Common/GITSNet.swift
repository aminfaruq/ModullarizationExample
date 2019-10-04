//
//  GITSNet.swift
//  GITSFramework
//
//  Created by GITS Indonesia on 3/16/17.
//  Copyright © 2017 GITS Indonesia. All rights reserved.
//

import Foundation
import GITSRest
import Alamofire
import SwiftyJSON


let SUCCESS = "success"
let NETWORK_ERROR = "Tidak ada koneksi"
let SYSTEM_ERROR = "Terjadi kesalahan sistem"
public let UNKNOWN_ERROR = "Oops! Something went wrong..."

public typealias onRequest = (_ onRequest: DataRequest)-> Void
public typealias onError = (_ message: String)-> Void

extension GITSRestError {
    var message : String {
        switch self {
        case .serverFailure( _, let message):
            return message
        case .timeout:
            return "Request timeout"
        case .unauthorized:
            return "Unauthorized"
        case .unknown:
            return UNKNOWN_ERROR
        }
    }
}

public struct GITSNet {
    
    public static func getToken()-> String {
//        if let token = GITSPref.getLogin()?.data?.token, token != "" {
//            return token
//        } else {
//            return ""
//        }
        return ""
    }

    public static func request(
        request:URLRequestConvertible,
        onRequest: @escaping (_ request: DataRequest) -> Void,
        onSuccess:@escaping (_ response:JSON) -> Void,
        onFailure:@escaping (_ response:String) -> Void) {
        
        let req:URLRequest?
        do {
            req = try request.asURLRequest()
        } catch  {
            req = nil
        }
        
        let runRequest = GITSRest.runRequest(urlRequest: req!, jsonValidation: { json in
            return nil
        }) { error,json in
            if error == nil {
                print("JSON Result => \(String(describing: json!))" )
                onSuccess(json!)
            }else if let err = error {
                print("JSON Error => \(err.message)" )
                if err.message.lowercased() != "cancelled" {
                    onFailure(err.message)
                }
            }
        }
        onRequest(runRequest)
    }
    
    public static func uploadRequest(
        request: URLRequestConvertible,
        multipartFormData: @escaping (MultipartFormData) -> Void,
        onRequest: @escaping onRequest,
        onSuccess:@escaping (_ response:JSON) -> Void,
        onFailure:@escaping (_ response:String) -> Void) {
        let req:URLRequest?
        do {
            req = try request.asURLRequest()
        } catch  {
            req = nil
        }
        
        Alamofire.upload(multipartFormData: multipartFormData, with: req!) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _ ):
                let runRequest = upload.responseJSON { response in
                    var json : JSON?
                    var err : GITSRestError?
                    switch response.result {
                    case .success(let value) :
                        json = JSON(value)
                    case .failure(let error) :
                        let nserror = error as NSError
                        if nserror.code == -1001 {
                            err = .timeout
                        } else if nserror.code == 401 {
                            err = .unauthorized
                        } else {
                            err = .serverFailure(code: nserror.code, message: nserror.localizedDescription)
                        }
                    }
                    if err == nil {
                        print("JSON Result => \(String(describing: json!))" )
                        onSuccess(json!)
                    } else if let err = err {
                        print("JSON Error => \(err.message)" )
                        if err.message.lowercased() != "cancelled" {
                            onFailure(err.message)
                        }
                    }
                }
                onRequest(runRequest)
            case .failure(let encodingError):
                print("===Failure Encoding===")
                print(encodingError)
                onFailure(encodingError.localizedDescription)
            }
        }
    }
}
