//
//  BeautyDetailViewController.swift
//  GankIO
//
//  Created by ZhuDuan on 16/1/25.
//  Copyright © 2016年 Anthony. All rights reserved.
//

import UIKit

class BeautyDetailViewController: UIViewController {
    
    @IBOutlet var beautyDetailImageView: UIImageView!
    var beautyDetailImageString: String!

    @IBAction func saveImgeToAlbum(sender: AnyObject) {
        print("\(self.beautyDetailImageString)")
        UIImageWriteToSavedPhotosAlbum(self.beautyDetailImageView.image!, self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafePointer<Void>) {
        if let err = error {
            UIAlertView(title: "错误", message: err.localizedDescription, delegate: nil, cancelButtonTitle: "确定").show()
        } else {
            UIAlertView(title: "提示", message: "保存成功", delegate: nil, cancelButtonTitle: "确定").show()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.beautyDetailImageView.kf_setImageWithURL(NSURL(string: beautyDetailImageString)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
