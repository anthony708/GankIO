//
//  ContentTableViewController.swift
//  GankIO
//
//  Created by ZhuDuan on 16/1/27.
//  Copyright © 2016年 Anthony. All rights reserved.
//

import UIKit

class ContentTableViewController: UITableViewController {
    
    var dateString: String = ""
    let contentURL: String = "http://gank.avosapps.com/api/day/"
    
    var gankDataList = [GankCategory]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadContentData(NSURL(string: contentURL + dateString)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return gankDataList[section].sectionHeader
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return gankDataList.count - 1
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return gankDataList[section].descData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContentCell", forIndexPath: indexPath) as! ContentTableViewCell
        // Configure the cell...
        let cellText = gankDataList[indexPath.section].descData[indexPath.row]
        let cellUrl = gankDataList[indexPath.section].urlList[indexPath.row]
        let htmlText = try? NSAttributedString(data: "<a href=\"\(cellUrl)\" target=\"__blank\">\(cellText)</a>".dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        cell.descTextView.attributedText = htmlText
    
        return cell
    }
    
    func loadContentData(url: NSURL) {
        let data: NSData! = try? NSData.init(contentsOfURL: url, options:NSDataReadingOptions.DataReadingUncached)
        let json = try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        if let jsonDict = json as? [String: AnyObject] {
            
            let resultsDict = jsonDict["results"] as? [String: [[String: AnyObject]]]
            for (key,value) in resultsDict! {
                let data = GankCategory()
                data.sectionHeader = key
                
                var descArray = [String]()
                var URLArray = [String]()
                
                for subValue in value {
                    
                    descArray.append((subValue["desc"] as? String)!)
                    URLArray.append((subValue["url"] as? String)!)

                }
                
                data.descData = descArray
                data.urlList = URLArray
                gankDataList.append(data)
            }
        }
    }
}

