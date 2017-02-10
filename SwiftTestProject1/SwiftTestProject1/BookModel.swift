//
//  BookModel.swift
//  SwiftTestProject1
//
//  Created by sjr on 16/8/30.
//  Copyright © 2016年 dianwangjr. All rights reserved.
//

import UIKit

class BookModel: NSObject {
    // 书名
    var subtitle: String?
    // 图片
    var image: String?
    // 作者
    var author: NSArray = []
    {
        didSet {
            if author.count > 0 {
                author_name = author[0] as? String
            }
        }
    }
    var author_name: String?
    // 出版社
    var publisher: String?
    // 作者简介
    var author_intro: String?
    // 概要
    var summary: String?
    // 豆瓣链接
    var alt: String?
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
