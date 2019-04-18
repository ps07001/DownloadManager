//
//  ProfileImage.swift
//  AbstractDownloadManager
//
//  Created by parul on 11/04/19.
//  Copyright © 2019 parul. All rights reserved.
//


import Foundation


class ProfileImage : NSObject, NSCoding{

	var large : String!
	var medium : String!
	var small : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any])
    {
        if let largePImage = dictionary[Key.large] as? String
        {
            large = largePImage
        }
        if let mediumPImage = dictionary[Key.medium] as? String
        {
            medium = mediumPImage
        }
        
        if let smallPImage = dictionary[Key.small] as? String
        {
            small = smallPImage
        }
       
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if large != nil{
			dictionary[Key.large] = large
		}
		if medium != nil{
			dictionary[Key.medium] = medium
		}
		if small != nil{
			dictionary[Key.small] = small
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         large = aDecoder.decodeObject(forKey: Key.large) as? String
         medium = aDecoder.decodeObject(forKey: Key.medium) as? String
         small = aDecoder.decodeObject(forKey: Key.small) as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if large != nil{
			aCoder.encode(large, forKey: Key.large)
		}
		if medium != nil{
			aCoder.encode(medium, forKey: Key.medium)
		}
		if small != nil{
			aCoder.encode(small, forKey: Key.small)
		}

	}

}
