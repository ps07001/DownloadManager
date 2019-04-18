//
//  Category.swift
//  AbstractDownloadManager
//
//  Created by parul on 11/04/19.
//  Copyright © 2019 parul. All rights reserved.
//


import Foundation


class Category : NSObject, NSCoding{

	var id : Int!
	var links : Link!
	var photoCount : Int!
	var title : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
        if let idVal = dictionary[Key.Id] as? Int
        {
            self.id = idVal
        }
		
		if let linksData = dictionary[Key.links] as? [String:Any]{
			links = Link(fromDictionary: linksData)
		}
        
        if let photoCount = dictionary[Key.photo_count] as? Int
        {
            self.photoCount = photoCount
        }
        if let title = dictionary[Key.title] as? String
        {
            self.title = title
        }
		
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if id != nil{
			dictionary[Key.Id] = id
		}
		if links != nil{
			dictionary[Key.links] = links.toDictionary()
		}
		if photoCount != nil{
			dictionary[Key.photo_count] = photoCount
		}
		if title != nil{
			dictionary[Key.title] = title
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: Key.Id) as? Int
         links = aDecoder.decodeObject(forKey: Key.links) as? Link
         photoCount = aDecoder.decodeObject(forKey: Key.photo_count) as? Int
         title = aDecoder.decodeObject(forKey: Key.title) as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: Key.Id)
		}
		if links != nil{
			aCoder.encode(links, forKey: Key.links)
		}
		if photoCount != nil{
			aCoder.encode(photoCount, forKey: Key.photo_count)
		}
		if title != nil{
			aCoder.encode(title, forKey: Key.title)
		}

	}

}
