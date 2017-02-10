//
//  BookCell.swift
//  SwiftTestProject1
//
//  Created by sjr on 16/8/30.
//  Copyright © 2016年 dianwangjr. All rights reserved.
//

import UIKit
import Kingfisher

// @objc 是用于处理Swift与OC之间的转换的，由于optional是OC中的关键字，
// 所以在protocol之前需要添加上@objc。
@objc protocol BookCellDelegate: NSObjectProtocol {
    // optional 说明这个代理方法是可选方法，
    // 那么在调用的时候，需要这样调用：delegate?.selectBookCover?(alt)
    // 其中delegate?是因为delegate也是optional的
    @objc optional func selectBookCover(_ alt: String)
}

class BookCell: UITableViewCell {
    @IBOutlet weak var picture: UIImageView!

    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var publisher: UILabel!
    
    @IBOutlet weak var summary: UILabel!
    
    weak var delegate: BookCellDelegate?
    
    var book: BookModel? {
        didSet {
            if let aBook = book {
                picture.kf.setImage(with: URL.init(string: aBook.image!))
//                picture.kf_setImageWithURL(URL.init(string: aBook.image!)!)
                author.text = aBook.author_name
                publisher.text = aBook.publisher
                summary.text = aBook.summary
                
                picture.isUserInteractionEnabled = true
                let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(BookCell.didSelectBookCover))
                picture.addGestureRecognizer(tapGesture)
            }
        }
    }
    
    func didSelectBookCover() -> Void {
        self.delegate?.selectBookCover?((self.book?.alt!)!)
    }
    
    func heightForRowAtIndexPath(_ string: String) -> CGFloat {
        let width = UIScreen.main.bounds.size.width
        let size = string.boundingRect(with: CGSize(width: width - 30, height: 1000), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
        return size.height + 75
    }
}

