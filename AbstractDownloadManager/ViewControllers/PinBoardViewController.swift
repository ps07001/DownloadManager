//
//  PinBoardViewController.swift
//  AbstractDownloadManager
//
//  Created by parul on 10/04/19.
//  Copyright © 2019 parul. All rights reserved.
//

import UIKit
import QuickLook

class PinBoardViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var strLocalPath: String! = ""

    private let downloadManager = FileDownloadManager.shared
    let directoryName : String = "FileDirectory"


    let urlToDownload = "http://www.orimi.com/pdf-test.pdf"
    let urlToDownloadVideo = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"

    
    lazy var viewModel: PinBoarViewModel = {
        return PinBoarViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "PinBoardData"
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        self.initilizeViewModel()
        self.addPullToRefresh()
    }
    
    // MARK: - Initialize  viewModel

    func initilizeViewModel()
    {
        viewModel.fetchDataFromJson()
        viewModel.showLoading = {
            if self.viewModel.isLoading {
                self.activityIndicator.startAnimating()
                self.collectionView.alpha = 0.0
            } else {
                self.activityIndicator.stopAnimating()
                self.collectionView.alpha = 1.0
            }
        }
        viewModel.reloadViewForImageClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
    }
    
    // MARK: - Refresh- PullToRefresh
    
    func addPullToRefresh()
    {
        let refreshControl: UIRefreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action:
                #selector(PinBoardViewController.handleRefresh(_:)),
                                     for: UIControl.Event.valueChanged)
            refreshControl.tintColor = UIColor.blue
            
            return refreshControl
        }()

        self.collectionView.addSubview(refreshControl)

    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        
        self.viewModel.fetchDataFromJson()
        self.collectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
    // MARK: - open File
    func checkFileExists(attchmentName: String) -> Bool {
        var directoryUrl = FileUtils.cacheDirectoryPath().appendingPathComponent(directoryName)
        directoryUrl = directoryUrl.appendingPathComponent(attchmentName)
        if FileManager.default.fileExists(atPath: directoryUrl.path) {
            self.strLocalPath = directoryUrl.path
            self.openQlPreview()
            return true
        }
        return false
    }
    
}

// MARK: - CollectionView Methods


extension PinBoardViewController: PinterestLayoutDelegate
{
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
    {
        let imageHeight = (viewModel.pinBoardData[indexPath.row].height / 8)
        return CGFloat(imageHeight)
    }
}


// MARK: Data source

extension PinBoardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PinBoardCollectionViewCell", for: indexPath) as? PinBoardCollectionViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        ImageDownlaodManager.shared.show(imageView: cell.imageView, url: viewModel.pinBoardData[indexPath.row].urls.small, defaultImage: "image")
        {
        }
        return cell
    }
    
    // MARK: - open File
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let fileName = (self.urlToDownload as NSString).lastPathComponent
        if checkFileExists(attchmentName: fileName) == false
        {
            CommonFunctions.showGlobalProgressHUDWithTitle(title: "Please wait..")
            let request = URLRequest(url: URL(string: self.urlToDownload)!)
            _ = self.downloadManager.downloadFile(withRequest: request, inDirectory: directoryName, withName:fileName , shouldDownloadInBackground: true, onProgress: { (progress) in
                let percentage = String(format: "%.1f %", (progress * 100))
                debugPrint("Background progress : \(percentage)")
            }) { [weak self] (error, url) in
                if let error = error {
                    print("Error is \(error as NSError)")
                    CommonFunctions.dismissGlobalHUD()
                } else {
                    if let url = url
                    {
                        self?.strLocalPath = url.path
                        print("Downloaded file's url is \(url.path)")
                        CommonFunctions.dismissGlobalHUD()
                        self?.openQlPreview()
                    }
                }
            }
        }
    }
}


extension PinBoardViewController : QLPreviewControllerDelegate , QLPreviewControllerDataSource
{
    
    func openQlPreview() {
        let previoew = QLPreviewController.init()
        previoew.dataSource = self
        previoew.delegate = self
        DispatchQueue.main.async {
            self.present(previoew, animated: true, completion: {
            })
        }
    }
    
    public func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 5
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        print("strLocalPath = \(strLocalPath ?? "")")
        return URL.init(fileURLWithPath: self.strLocalPath) as QLPreviewItem
    }
    
    public func previewController(_ controller: QLPreviewController, shouldOpen url: URL, for item: QLPreviewItem) -> Bool {
        return true
    }
    
    func previewControllerWillDismiss(_ controller: QLPreviewController) {
//        self.removeFromParent()
    }
    
}
