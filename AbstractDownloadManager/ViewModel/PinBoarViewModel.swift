//
//  PinBoarViewModel.swift
//  AbstractDownloadManager
//
//  Created by parul on 11/04/19.
//  Copyright © 2019 parul. All rights reserved.
//

import UIKit

struct CellViewModel {
    let image: UIImage
}

class PinBoarViewModel: NSObject
{
    
    var reloadViewForImageClosure: (()->())?
    
    var isLoading: Bool = false {
        didSet {
            showLoading?()
        }
    }
    var showLoading: (() -> Void)?

    var pinBoardData: [PinBoardData] = [PinBoardData]() {
        didSet {
            self.reloadViewForImageClosure?()
        }
    }
    
    var cellViewModels: [CellViewModel] = []

    
    override init()
    {
        
    }
    
    var numberOfCells: Int {
        return self.pinBoardData.count
    }
    
    func fetchDataFromJson()
    {
        self.isLoading = true
        if let path = Bundle.main.path(forResource: "imageData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let imageData = jsonResult["pinBoardData"] as? [Any] {
                    
                    for objData in imageData
                    {
                        let pinBoard = PinBoardData(fromDictionary: objData as! [String : Any])
                        self.pinBoardData.append(pinBoard)
                    }
                    self.isLoading = false
                }
            } catch {
                // handle error
            }
        }
    }
    
}
