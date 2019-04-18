//
//  Constant.swift
//  AbstractDownloadManager
//
//  Created by parul on 10/04/19.
//  Copyright © 2019 parul. All rights reserved.
//

import UIKit

let appDelegate     = UIApplication.shared.delegate as! AppDelegate

let applicationName = "AbstractDownloadManager"


//MARK: Parameter Keys
/*
 It is defining keys which is come in API response
 */

public struct Key
{
    //Lat long Points
    
    static let Id                    =  "id"
    static let created_at            =  "created_at"
    static let width                 =  "width"
    static let height                =  "height"
    
    
    
    static let color                 =  "color"
    static let likes                 =  "likes"
    static let liked_by_user         =  "liked_by_user"
    static let user                  =  "user"
    static let username              =  "username"
    static let name                  =  "name"
    static let profile_image         =  "profile_image"
    
    
    
    static let small                 =  "small"
    static let medium                =  "medium"
    static let large                 =  "large"
    static let links                  =  "links"
    static let selfLink              =  "self"
    static let html                  =  "html"
    static let photos                =  "photos"
    
    
    
    static let current_user_collections                 =  "current_user_collections"
    static let raw                                      =  "raw"
    static let full                                     =  "full"
    static let regular                                  =  "regular"
    static let thumb                                    =  "thumb"
    static let categories                               =  "categories"
    static let title                                    =  "title"
    static let photo_count                              =  "photo_count"
    static let download                                 = "download"
    static let urls                                     = "urls"
}






//MARK: storyBoardID

/**
 Below are that const veriables which are defining different
 ViewControllers storyBoardID.
 */

public struct storyBoardID
{
    
}



//MARK: CustomCellID

/**
 Below are that const veriables which are defining different
 TableViewCell CustomCellID.
 */

public struct CustomCellIdentifier
{
}





