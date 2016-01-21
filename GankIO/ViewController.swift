//
//  ViewController.swift
//  GankIO
//
//  Created by ZhuDuan on 16/1/19.
//  Copyright © 2016年 Anthony. All rights reserved.
//

import UIKit
import Kingfisher
import PullToRefreshSwift
import XWSwiftRefresh

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mainTableView: UITableView!
    let urlString: String = "http://gank.avosapps.com/api/data/%E7%A6%8F%E5%88%A9/10/"
    var page = 1
    
    var titleNames = [String]()
    var beautyImages = [String]()

    override func viewDidLoad() {
        let options = PullToRefreshOption()
        options.backgroundColor = UIColor.whiteColor()
        options.indicatorColor = UIColor.whiteColor()
        
        let mainURL = NSURL(string: self.urlString + String(self.page))
        
        // pull to refresh
        self.mainTableView.addPullToRefresh(options: options, refreshCompletion: { [weak self] in
            // 上拉刷新清除
            self!.titleNames = []
            self!.beautyImages = []
            self!.page = 1
            self?.loadData(mainURL!)
            })
        
        // pull up to load
        self.mainTableView.tableFooterView = UIView()
//        self.mainTableView.registerClass(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.mainTableView.footerView = XWRefreshAutoNormalFooter(target: self, action: "upPullLoadData")
        
        // Do any additional setup after loading the view, typically from a nib.
        loadData(mainURL!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearCache(sender: AnyObject) {
        KingfisherManager.sharedManager.cache.clearMemoryCache()
        KingfisherManager.sharedManager.cache.clearDiskCache()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CustomTableViewCell
        
        cell.titleLabel.text = titleNames[indexPath.row]
        cell.dateLabel.text = titleNames[indexPath.row]
        
        
        cell.beautyImageView.kf_setImageWithURL(NSURL(string: beautyImages[indexPath.row])!,
            placeholderImage: nil,
            optionsInfo: nil,
            progressBlock: nil,
            completionHandler: { (image, error, CacheType, imageURL) -> () in
//                let imageData: NSData = NSData(contentsOfURL: NSURL(string: self.beautyImages[indexPath.row])!)!
//                let originImage = UIImage(data: imageData, scale: 1.0)

                let resizedImage : UIImage
                if image?.size.height > image?.size.width {
                    resizedImage = self.resizeImage(image!, size: CGSizeMake(320, (image?.size.height)! / (image?.size.width)! * 320))
                } else {
                    resizedImage = self.resizeImage(image!, size: CGSizeMake((image?.size.width)! / (image?.size.height)! * 240, 240))
                }
                
                let cropImage = self.cropRectImage(resizedImage)
                cell.beautyImageView.image = cropImage
        })
        return cell
    }
    
    // hide status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func resizeImage(image: UIImage, size: CGSize) -> UIImage {
        let sourceSize = image.size
        
        let widthRatio = size.width / sourceSize.width
        let heightRatio = size.height / sourceSize.height
        
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSizeMake(sourceSize.width * heightRatio, sourceSize.height * heightRatio)
        } else {
            newSize = CGSizeMake(sourceSize.width * widthRatio, sourceSize.height * widthRatio)
        }
        
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func cropRectImage(image: UIImage) -> UIImage {
        let targetSize = CGSizeMake(320, 240)
        let sourceSize = image.size
        
        var cropRect: CGRect
        if sourceSize.width > sourceSize.height {
            cropRect = CGRectMake((sourceSize.width - targetSize.width) / 2, 0, targetSize.width, targetSize.height)
        } else {
            cropRect = CGRectMake(0, (sourceSize.height - targetSize.height) / 2, targetSize.width, targetSize.height)
        }
        
        let imageRef = CGImageCreateWithImageInRect(image.CGImage, cropRect)
        if let imageTar = imageRef {
//            print("image crop suceess!")
            return UIImage(CGImage: imageTar, scale: UIScreen.mainScreen().scale, orientation: image.imageOrientation)

        } else {
//            print("image crop FAILED!")
            return image
        }
    }
    
    func loadData(url: NSURL) {
        
        let data: NSData! = try? NSData.init(contentsOfURL: url, options:NSDataReadingOptions.DataReadingUncached)
        let json = try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        if let resultsDict = json as? [String: AnyObject] {
            let resultsDictionary = resultsDict["results"] as? [[String: AnyObject]]
            for item in resultsDictionary! {
                let publishedAt = item["publishedAt"] as! String
                let imageURL = item["url"] as! String
                //            print(publishedAt)
                titleNames.append(publishedAt.substringToIndex(publishedAt.startIndex.advancedBy(10)))
                beautyImages.append(imageURL)
            }
            mainTableView.reloadData()
            mainTableView.stopPullToRefresh()
            mainTableView.footerView?.endRefreshing()
        }
    }
    
    func upPullLoadData() {
        
        page += 1
        let url: NSURL = NSURL(string: self.urlString + String(self.page))!
        loadData(url)
    }
}

