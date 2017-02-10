//
//  ViewController.swift
//  SwiftTestProject1
//
//  Created by sjr on 16/8/29.
//  Copyright © 2016年 dianwangjr. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var books: NSMutableArray = []
    var selectedBook: BookModel?
    var selectedBookAlt: String?
    
    var start: Int = 0
    var count: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "小说列表"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 63
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(ViewController.startRefreshUpPull))
        tableView.mj_footer = footer
        
        requestBooks()
    }
    
    func requestBooks() {
//        var params = [String: AnyObject]()
//        params["q"] = "小说" as AnyObject?
//        params["start"] = self.start as AnyObject?
//        params["count"] = self.count as AnyObject?
        
        let params: Parameters = [
            "q": "小说",
            "start": self.start,
            "count": self.count
        ]
        
        Alamofire.request("https://api.douban.com/v2/book/search", method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            self.tableView.mj_footer.endRefreshing()
            if let value = response.result.value as? [String : AnyObject] {
                if let result = value["books"] {
                    var books = [BookModel]()
                    let resultArray = result as! [[String: AnyObject]]
                    for dict in resultArray {
                        books.append(BookModel.init(dict: dict))
                    }
//                    for dict in result as! [[String: AnyObject]] {
//                        books.append(BookModel.init(dict: dict))
//                    }
                    self.books.addObjects(from: books)
                    self.tableView.reloadData()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: DetailViewController.self) {
            let detailVC = segue.destination as! DetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow
            self.selectedBook = self.books[(indexPath! as NSIndexPath).row] as? BookModel
            detailVC.book = self.selectedBook
        }
        else if segue.destination.isKind(of: WebViewController.self) {
            let webVC = segue.destination as! WebViewController
            webVC.alt = self.selectedBookAlt
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "CellIdentifier";
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! BookCell
        cell.delegate = self
        cell.book = self.books[(indexPath as NSIndexPath).row] as? BookModel
        return cell
    }
}

extension ViewController: BookCellDelegate {
    func selectBookCover(_ alt: String) {
        self.selectedBookAlt = alt
        self.performSegue(withIdentifier: "showWebView", sender: self)
    }
}


