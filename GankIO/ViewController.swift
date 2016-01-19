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
        cell.beautyImageView.image = UIImage(named: beautyImages[indexPath.row])
        cell.dateLabel.text = titleNames[indexPath.row]
        return cell
    }
    
    // hide status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

