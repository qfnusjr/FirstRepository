//
//  CollectionViewController.swift
//  SwiftTestProject1
//
//  Created by sjr on 16/9/7.
//  Copyright © 2016年 dianwangjr. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "CollectionViewCell"

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var books: NSMutableArray = []
    var start: Int = 0
    var count: Int = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "collectionView"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(CollectionViewController.startRefreshUpPull))
        self.collectionView?.mj_footer = footer

        // Do any additional setup after loading the view.
        requestBooks()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestBooks() {
        var params = [String: AnyObject]()
        params["q"] = "音乐" as AnyObject?
        params["start"] = self.start as AnyObject?
        params["count"] = self.count as AnyObject?
        
        Alamofire.request("https://api.douban.com/v2/book/search", method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            self.collectionView!.mj_footer.endRefreshing()
            if let value = response.result.value as? [String: AnyObject] {
                if let result = value["books"] {
                    var books = [BookModel]()
                    for dict in result as! [[String: AnyObject]] {
                        books.append(BookModel.init(dict: dict))
                    }
                    self.books.addObjects(from: books)
                    self.collectionView!.reloadData()
                    self.start += 10
                }
            }
        }
        
//        Alamofire.request(.GET, "https://api.douban.com/v2/book/search", parameters: params, encoding: .url, headers: nil).responseJSON { (response) in
//            
//        }
    }
    
    func startRefreshUpPull() {
        requestBooks()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.books.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        // Configure the cell
        let bookModel = self.books[(indexPath as NSIndexPath).row] as! BookModel
        cell.book = bookModel
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.size.width - 20) / 3, height: (UIScreen.main.bounds.size.width - 20) / 3 * 19 / 16 + 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
