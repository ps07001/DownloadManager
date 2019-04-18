//
//  Link.swift
//  AbstractDownloadManager
//
//  Created by parul on 11/04/19.
//  Copyright © 2019 parul. All rights reserved.
//


import Foundation


class Link : NSObject, NSCoding{

	var photos : String!
	var selfLink : String!
	var download : String!
	var html : String!
	var likes : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any])
    {
        if let photoes = dictionary[Key.photos] as? String
        {
            photos = photoes
        }
        
        if let linkSelf = dictionary[Key.selfLink] as? String
        {
            selfLink = linkSelf
        }
        
        if let download = dictionary[Key.download] as? String
        {
            self.download = download
        }
        
        if let htmlLink = dictionary[Key.html] as? String
        {
            self.html = htmlLink
        }
        
        if let likeLink = dictionary[Key.likes] as? String
        {
            self.likes = likeLink
        }
        
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if photos != nil{
			dictionary[Key.photos] = photos
		}
		if selfLink != nil{
			dictionary[Key.selfLink] = selfLink
		}
		if download != nil{
			dictionary[Key.download] = download
		}
		if html != nil{
			dictionary[Key.html] = html
		}
		if likes != nil{
			dictionary[Key.likes] = likes
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         photos = aDecoder.decodeObject(forKey: Key.photos) as? String
         selfLink = aDecoder.decodeObject(forKey: Key.selfLink) as? String
         download = aDecoder.decodeObject(forKey: Key.download) as? String
         html = aDecoder.decodeObject(forKey: Key.html) as? String
         likes = aDecoder.decodeObject(forKey: Key.likes) as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if photos != nil{
			aCoder.encode(photos, forKey: Key.photos)
		}
		if selfLink != nil{
			aCoder.encode(self, forKey: Key.selfLink)
		}
		if download != nil{
			aCoder.encode(download, forKey: Key.download)
		}
		if html != nil{
			aCoder.encode(html, forKey: Key.html)
		}
		if likes != nil{
			aCoder.encode(likes, forKey: Key.likes)
		}

	}

}
