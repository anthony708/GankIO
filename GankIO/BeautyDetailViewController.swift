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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.beautyDetailImageView.kf_setImageWithURL(NSURL(string: beautyDetailImageString)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
