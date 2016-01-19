//
//  ViewController.swift
//  GankIO
//
//  Created by ZhuDuan on 16/1/19.
//  Copyright © 2016年 Anthony. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var titleNames = ["20160119", "20160118", "20160117", "20160116", "20160115"]
    var beautyImages = ["pic1", "pic1", "pic1", "pic1", "pic1"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        
        let originImage = UIImage(named: beautyImages[indexPath.row])
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
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio, size.height * widthRatio)
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
            print("image crop suceess!")
            return UIImage(CGImage: imageTar, scale: UIScreen.mainScreen().scale, orientation: image.imageOrientation)

        } else {
            print("image crop FAILED!")
            return image
        }
    }
}

