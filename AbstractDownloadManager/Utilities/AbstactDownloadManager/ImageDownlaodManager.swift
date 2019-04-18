//
//  ImageDownlaodManager.swift
//  AbstractDownloadManager
//
//  Created by parul on 11/04/19.
//  Copyright © 2019 parul. All rights reserved.
//

import UIKit

class ImageDownlaodManager: NSObject
{
    var oldFrame:CGRect = CGRect()

    public static let shared: ImageDownlaodManager = { return ImageDownlaodManager() }()
    
    //MARK:- Private methods
    
    private override init() {
        super.init()
    }
    
    func show(imageView:UIImageView, url:String?, defaultImage:String?, completion: @escaping () -> Void) -> Void {
        
        if url == nil || url!.isEmpty {
            return //URL is null, don't proceed
        }
        
        //Clip subviews for image view
        imageView.clipsToBounds = true;
        
        
        //Remove all "/" from the url because it will be used as the entire file name in order to be unique
        let imgName:String = url!.replacingOccurrences(of: "/", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        //Image path in temporary diretory
        let imagePath:String = String(format:"%@%@", NSTemporaryDirectory(), imgName)
        
        //Check if image exists
        let imageExists:Bool = FileManager.default.fileExists(atPath: imagePath)
        
        if imageExists {
            
            //check if imageview size is 0
            let width:CGFloat = imageView.bounds.size.width;
            let height:CGFloat = imageView.bounds.size.height;
            
            //In case of default cell images (Dimensions are 0 when not present)
            if height == 0 && width == 0 {
                
                var frame:CGRect = imageView.frame
                frame.size.width = 40
                frame.size.height = 40
                imageView.frame = frame
            }
            
            if let imageData = try? Data(contentsOf: URL(fileURLWithPath: imagePath)) {
                //Image exists
                let dat:Data = imageData
                
                let image:UIImage = UIImage(data:dat)!
                
                imageView.image = image;

                //Animation for image
                imageView.alpha = 0
                UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.showHideTransitionViews, animations: { () -> Void in
                    imageView.alpha = 1
                }, completion: { (Bool) -> Void in    }
                )
                
                
                //Completion
                completion()
            }
            else {
                //Image exists but corrupted. Load it again
                if let defaultImg = defaultImage {
                    imageView.image = UIImage(named:defaultImg)
                }
                else {
                    imageView.image = UIImage(named:"")
                }
                
                //Lazy load image (Asychronous call)
                self.lazyLoad(imageView: imageView, url: url) {
                    completion()
                }
            }
        }
        else
        {
            //Image does not exist. Load it
            if let defaultImg = defaultImage {
                imageView.image = UIImage(named:defaultImg)
            }
            else {
                imageView.image = UIImage(named:"")
            }
            
            self.lazyLoad(imageView: imageView, url: url) {
                completion()
            }
            
        }
    }
    
    
    
     fileprivate func lazyLoad(imageView:UIImageView, url:String?, completion: @escaping () -> Void) -> Void {
        
        if url == nil || url!.isEmpty {
            return //URL is null, don't proceed
        }
        
        //Remove all "/" from the url because it will be used as the entire file name in order to be unique
        let imgName:String = url!.replacingOccurrences(of: "/", with: "", options: NSString.CompareOptions.literal, range: nil)
        
        //Image path
        let imagePath:String = String(format:"%@%@", NSTemporaryDirectory(), imgName)
        
        let width:CGFloat = imageView.bounds.size.width;
        let height:CGFloat = imageView.bounds.size.height;
        
        //In case of default cell images (Dimensions are 0 when not present)
        if height == 0 && width == 0 {
            
            var frame:CGRect = imageView.frame
            frame.size.width = 40
            frame.size.height = 40
            imageView.frame = frame
        }
        
        //Lazy load image (Asychronous call)
        if  let urlObject: URL = URL(string:url!)
        {
            let urlRequest:URLRequest = URLRequest(url: urlObject)
            
            let backgroundQueue = DispatchQueue(label:"ImageBackgroundQueue",
                                                qos: .background,
                                                target: nil)
            
            backgroundQueue.async(execute: {
                
                let session:URLSession = URLSession(configuration: URLSessionConfiguration.default)
                let task = session.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
                    
                    if response != nil {
                        let httpResponse:HTTPURLResponse = response as! HTTPURLResponse
                        
                        if httpResponse.statusCode != 200 {
                            Swift.debugPrint("ImageDownloadManager status code : \(httpResponse.statusCode)")
                        }
                    }
                    
                    if data == nil {
                        if error != nil {
                            Swift.debugPrint("Error : \(error!.localizedDescription)")
                        }
                        Swift.debugPrint("ImageDownloadManager: No image data available")
                        return
                    }
                    
                    let image:UIImage? = UIImage(data:data!)
                    
                    
                    //Go to main thread and update the UI
                    DispatchQueue.main.async(execute: { () -> Void in
                        
                        if let img = image {
                            
                            imageView.image = img;
                            
                            //Animation for image
                            imageView.alpha = 0
                            UIView.animate(withDuration: 0.5, delay: 0, options: UIView.AnimationOptions.showHideTransitionViews, animations: { () -> Void in
                                imageView.alpha = 1
                            }, completion: { (Bool) -> Void in    }
                            )
                            //Store image to the temporary folder for later use
                            var error: NSError?
                            
                            do {
                                try img.pngData()!.write(to: URL(fileURLWithPath: imagePath), options: [])
                            } catch let error1 as NSError {
                                error = error1
                                if let actualError = error {
                                    NSLog("Image not saved. \(actualError)")
                                }
                            } catch {
                                fatalError()
                            }
                            
                            
                            //Completion block
                            completion()
                        }
                    })
                })
                task.resume()
            })
        }
    }
    

}
