//
//  DetailViewController.swift
//  SwiftTestProject1
//
//  Created by sjr on 16/8/29.
//  Copyright © 2016年 dianwangjr. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var authorIntro: UILabel!
    
    var book: BookModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "作者简介"
        // Do any additional setup after loading the view.
        self.author.text = self.book?.author_name
        self.authorIntro.text = self.book?.author_intro
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
