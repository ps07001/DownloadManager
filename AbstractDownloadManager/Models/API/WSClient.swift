//
//  WSClient.swift
//  AbstractDownloadManager
//
//  Created by parul on 10/04/19.
//  Copyright © 2019 parul. All rights reserved.
//


import Foundation
import UIKit

class WSClient {
    
    let baseURL: String = "http://pastebin.com/raw/wgkJgazE"
    /**
     Share instance of class
     */
    static let sharedInstance: WSClient = WSClient()
    
    init() {
        print("Should Print only one time");
    }
    
    /**
     Call request for api
     */
    private func apiRequest ( method1: HTTPMethod ,api : String, params : [String: AnyObject]? = nil,loadingMsg : String, completion: @escaping (_ result: AnyObject?, _ error : NSError?) -> Void)
    {
        
        let req : DataRequest!
        if method1 == .get {
            req  = request(baseURL, method: method1, parameters: params, encoding: URLEncoding.default, headers: [:])
        }
        else
        {
            req = request(baseURL, method: method1, parameters: params, encoding: JSONEncoding.default, headers: [:])
        }
        
        if loadingMsg == ""
        {
            print("no HUD")
        }
        if loadingMsg.count > 0
        {
            CommonFunctions.showGlobalProgressHUDWithTitle(title: loadingMsg)
        }
        
        req.responseJSON { (response:DataResponse<Any>) in
            if loadingMsg.count > 0
            {
                CommonFunctions.dismissGlobalHUD()
            }
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    
                    let result = response.result
                    let json : Any?
                    json = result.value as AnyObject
                    if loadingMsg.count > 0
                    {
                        CommonFunctions.dismissGlobalHUD()
                    }
                    if json != nil {
                        completion(json! as AnyObject , result.error as NSError?)
                    } else {
                        completion(nil , NSError(domain: "Error", code: -1001010, userInfo: nil))
                    }
                }
                break
                
            case .failure(_):
                print(response.result.error as Any)
                //Show Network Error Alert.
                let error = response.result.error
                completion(nil , error! as NSError)
                //Show Network Error Alert.
                if error != nil && (error?._code == -1000 || error?._code == -1001 || error?._code == -1002 || error?._code == -1003 || error?._code == -1004 || error?._code == -1005 || error?._code == -1008 || error?._code == -1009)
                {
                    NSLog("%@", (error?.localizedDescription)!)
                    let delayTime = DispatchTime.now() + Double(Int64(0.4 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
                    DispatchQueue.main.asyncAfter(deadline: delayTime) {
                        if error?._code == -1009{
                            CommonFunctions.showMessage(message:Message.ConnectionError)
                        }
                        else {
                            CommonFunctions.showMessage(message:Message.networkError)
                        }
                        CommonFunctions.dismissGlobalHUD()
                    }
                    
                }
                break
            }
        }
    }
    
    /**
     Call get request
     */
    
    public func getRequest(api : String, params : [String: AnyObject]? = nil,loadingMsg : String, completion: @escaping (_ result: AnyObject?, _ error : NSError?) -> Void)
    {
        self.apiRequest(method1: .get, api: api, params: params, loadingMsg: loadingMsg) { (result, error) in
            completion(result , error)
        }
    }
    
    /**
     Call Post request
     */
    
    public func postRequest(api : String, params : [String: AnyObject]? = nil,loadingMsg : String, completion: @escaping (_ result: AnyObject?, _ error : NSError?) -> Void)
    {
        
        self.apiRequest(method1: .post, api: api, params: params, loadingMsg: loadingMsg) { (result, error) -> Void in
            completion(result , error)
        }
    }
    
    /**
     Call Put request
     */
    public func deleteRequest(api : String, params : [String: AnyObject]? = nil,loadingMsg : String, completion: @escaping (_ result: AnyObject?, _ error : NSError?) -> Void)
    {
        self.apiRequest(method1: .delete, api: api, params: params, loadingMsg: loadingMsg) { (result, error) -> Void in
            completion( result , error)
        }
    }
}
