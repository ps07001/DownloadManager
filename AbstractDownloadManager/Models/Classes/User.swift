//
//  User.swift
//  AbstractDownloadManager
//
//  Created by parul on 11/04/19.
//  Copyright © 2019 parul. All rights reserved.
//


import Foundation


class User : NSObject, NSCoding{

	var id : String!
	var links : Link!
	var name : String!
	var profileImage : ProfileImage!
	var username : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any])
    {
        
        if let idVal = dictionary[Key.Id] as? String
        {
            self.id = idVal
        }
        if let linksData = dictionary[Key.links] as? [String:Any]{
			links = Link(fromDictionary: linksData)
		}
        if let nameVal = dictionary[Key.Id] as? String
        {
            self.name = nameVal
        }
        
		if let profileImageData = dictionary[Key.profile_image] as? [String:Any]{
			profileImage = ProfileImage(fromDictionary: profileImageData)
		}
        
        if let userNameVal = dictionary[Key.username] as? String
        {
            self.username = userNameVal
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
		if name != nil{
			dictionary[Key.name] = name
		}
		if profileImage != nil{
			dictionary[Key.profile_image] = profileImage.toDictionary()
		}
		if username != nil{
			dictionary[Key.username] = username
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: Key.Id) as? String
         links = aDecoder.decodeObject(forKey: Key.links) as? Link
         name = aDecoder.decodeObject(forKey: Key.name) as? String
         profileImage = aDecoder.decodeObject(forKey: Key.profile_image) as? ProfileImage
         username = aDecoder.decodeObject(forKey: Key.username) as? String

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
		if name != nil{
			aCoder.encode(name, forKey: Key.name)
		}
		if profileImage != nil{
			aCoder.encode(profileImage, forKey: Key.profile_image)
		}
		if username != nil{
			aCoder.encode(username, forKey: Key.username)
		}

	}

}
