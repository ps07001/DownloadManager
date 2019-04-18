//
//  Url.swift
//  AbstractDownloadManager
//
//  Created by parul on 11/04/19.
//  Copyright © 2019 parul. All rights reserved.
//


import Foundation


class Url : NSObject, NSCoding{

	var full : String!
	var raw : String!
	var regular : String!
	var small : String!
	var thumb : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any])
    {
        if let fullVal = dictionary[Key.full] as? String
        {
            self.full = fullVal
        }
        if let rawVal = dictionary[Key.raw] as? String
        {
            self.raw = rawVal
        }
        if let regulaVal = dictionary[Key.regular] as? String
        {
            self.regular = regulaVal
        }
        if let smallVal = dictionary[Key.small] as? String
        {
            self.small = smallVal
        }
        if let thumbVal = dictionary[Key.thumb] as? String
        {
            self.thumb = thumbVal
        }
        
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if full != nil{
			dictionary[Key.full] = full
		}
		if raw != nil{
			dictionary[Key.raw] = raw
		}
		if regular != nil{
			dictionary[Key.regular] = regular
		}
		if small != nil{
			dictionary[Key.small] = small
		}
		if thumb != nil{
			dictionary[Key.thumb] = thumb
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         full = aDecoder.decodeObject(forKey: Key.full) as? String
         raw = aDecoder.decodeObject(forKey: Key.raw) as? String
         regular = aDecoder.decodeObject(forKey: Key.regular) as? String
         small = aDecoder.decodeObject(forKey: Key.small) as? String
         thumb = aDecoder.decodeObject(forKey: Key.thumb) as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if full != nil{
			aCoder.encode(full, forKey: Key.full)
		}
		if raw != nil{
			aCoder.encode(raw, forKey: Key.raw)
		}
		if regular != nil{
			aCoder.encode(regular, forKey: Key.regular)
		}
		if small != nil{
			aCoder.encode(small, forKey: Key.small)
		}
		if thumb != nil{
			aCoder.encode(thumb, forKey: Key.thumb)
		}

	}

}
