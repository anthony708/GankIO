//
//  ViewController.swift
//  GankIO
//
//  Created by ZhuDuan on 16/1/19.
//  Copyright © 2016年 Anthony. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mainTableView: UITableView!
    let url = NSURL(string: "http://gank.avosapps.com/api/data/%E7%A6%8F%E5%88%A9/10/1")
    
    var titleNames = [String]()
    var beautyImages = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData(url!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CustomTableViewCell
        
        cell.titleLabel.text = titleNames[indexPath.row]
        cell.dateLabel.text = titleNames[indexPath.row]
        
        let imageData: NSData = NSData(contentsOfURL: NSURL(string: beautyImages[indexPath.row])!)!
        let originImage = UIImage(data: imageData, scale: 1.0)
        let resizedImage : UIImage
        if originImage?.size.height > originImage?.size.width {
            resizedImage = resizeImage(originImage!, size: CGSizeMake(320, (originImage?.size.height)! / (originImage?.size.width)! * 320))
        } else {
            resizedImage = resizeImage(originImage!, size: CGSizeMake((originImage?.size.width)! / (originImage?.size.height)! * 240, 240))
        }
        
        let cropImage = cropRectImage(resizedImage)
        
        cell.beautyImageView.image = cropImage
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
        }
        
    }
}

