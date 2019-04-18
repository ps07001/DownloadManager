//
//  PinBoardData.swift
//  AbstractDownloadManager
//
//  Created by parul on 11/04/19.
//  Copyright © 2019 parul. All rights reserved.
//


import Foundation


class PinBoardData : NSObject, NSCoding{

	var categories : [Category]!
	var color : String!
	var createdAt : String!
	var currentUserCollections : [AnyObject]!
	var height : Int!
	var id : String!
	var likedByUser : Bool!
	var likes : Int!
	var links : Link!
	var urls : Url!
	var user : User!
	var width : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		categories = [Category]()
		if let categoriesArray = dictionary[Key.categories] as? [[String:Any]]{
			for dic in categoriesArray{
				let value = Category(fromDictionary: dic)
				categories.append(value)
			}
		}
        
        if let colorVal = dictionary[Key.color] as? String
        {
            color = colorVal
        }
        
        if let createdDate = dictionary[Key.created_at] as? String
        {
            createdAt = createdDate
        }
        if let  userData =  dictionary[Key.current_user_collections] as? [AnyObject]
        {
            self.currentUserCollections = userData
        }
        
        if let id = dictionary[Key.Id] as? String
        {
            self.id = id
        }
        
        
        if let height = dictionary[Key.height] as? Int
        {
            self.height = height
        }
    
        if let liked = dictionary[Key.likes] as? Int
        {
            self.likes = liked
        }
        
        if let likedbyUser = dictionary[Key.liked_by_user] as? Bool
        {
            self.likedByUser = likedbyUser
        }
        
        if let width = dictionary[Key.width] as? Int
        {
            self.width = width
        }
        
		if let linksData = dictionary[Key.links] as? [String:Any]{
			links = Link(fromDictionary: linksData)
		}
		if let urlsData = dictionary[Key.urls] as? [String:Any]{
			urls = Url(fromDictionary: urlsData)
		}
		if let userData = dictionary[Key.user] as? [String:Any]{
			user = User(fromDictionary: userData)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if categories != nil{
			var dictionaryElements = [[String:Any]]()
			for categoriesElement in categories {
				dictionaryElements.append(categoriesElement.toDictionary())
			}
			dictionary[Key.categories] = dictionaryElements
		}
		if color != nil{
			dictionary[Key.color] = color
		}
		if createdAt != nil{
			dictionary[Key.created_at] = createdAt
		}
		if currentUserCollections != nil{
			dictionary[Key.current_user_collections] = currentUserCollections
		}
		if height != nil{
			dictionary[Key.height] = height
		}
		if id != nil{
			dictionary[Key.Id] = id
		}
		if likedByUser != nil{
			dictionary[Key.liked_by_user] = likedByUser
		}
		if likes != nil{
			dictionary[Key.likes] = likes
		}
		if links != nil{
			dictionary[Key.links] = links.toDictionary()
		}
		if urls != nil{
			dictionary[Key.urls] = urls.toDictionary()
		}
		if user != nil{
			dictionary[Key.user] = user.toDictionary()
		}
		if width != nil{
			dictionary[Key.width] = width
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         categories = aDecoder.decodeObject(forKey :Key.categories) as? [Category]
         color = aDecoder.decodeObject(forKey: Key.color) as? String
         createdAt = aDecoder.decodeObject(forKey: Key.created_at) as? String
         currentUserCollections = aDecoder.decodeObject(forKey: Key.current_user_collections) as? [AnyObject]
         height = aDecoder.decodeObject(forKey: Key.height) as? Int
         id = aDecoder.decodeObject(forKey: Key.Id) as? String
         likedByUser = aDecoder.decodeObject(forKey: Key.liked_by_user) as? Bool
         likes = aDecoder.decodeObject(forKey: Key.likes) as? Int
         links = aDecoder.decodeObject(forKey: Key.links) as? Link
         urls = aDecoder.decodeObject(forKey: Key.urls) as? Url
         user = aDecoder.decodeObject(forKey: Key.user) as? User
         width = aDecoder.decodeObject(forKey: Key.width) as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if categories != nil{
			aCoder.encode(categories, forKey: Key.categories)
		}
		if color != nil{
			aCoder.encode(color, forKey: Key.color)
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: Key.created_at)
		}
		if currentUserCollections != nil{
			aCoder.encode(currentUserCollections, forKey: Key.current_user_collections)
		}
		if height != nil{
			aCoder.encode(height, forKey: Key.height)
		}
		if id != nil{
			aCoder.encode(id, forKey: Key.Id)
		}
		if likedByUser != nil{
			aCoder.encode(likedByUser, forKey: Key.liked_by_user)
		}
		if likes != nil{
			aCoder.encode(likes, forKey: Key.likes)
		}
		if links != nil{
			aCoder.encode(links, forKey: Key.links)
		}
		if urls != nil{
			aCoder.encode(urls, forKey: Key.urls)
		}
		if user != nil{
			aCoder.encode(user, forKey: Key.user)
		}
		if width != nil{
			aCoder.encode(width, forKey: Key.width)
		}

	}

}
