//
//  CollectionViewCell.swift
//  SwiftTestProject1
//
//  Created by sjr on 16/9/7.
//  Copyright © 2016年 dianwangjr. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var publiserLabel: UILabel!
    
    var book: BookModel? {
        didSet {
            if let aBook = book {
                if let image = aBook.image {
                    imageView.kf.setImage(with: URL.init(string: image))
//                    imageView.kf_setImageWithURL(URL.init(string: image)!)
                }
                authorLabel.text = aBook.author_name
                publiserLabel.text = aBook.publisher
//                summary.text = aBook.summary
                
//                imageView.userInteractionEnabled = true
//                let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(CollectionViewCell.didSelectBookCover))
//                imageView.addGestureRecognizer(tapGesture)
            }
        }
    }
    // 可以解决collectionView只有滑动回来之后布局才显示正确的问题
    /*
      if you are not subclassing UICollectionViewCell. Just add this two lines under your cellForItemAtIndexPath: after dequeueReusableCellWithReuseIdentifier:
     
      cell.contentView.frame = cell.bounds
      cell.contentView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
     */
    override var bounds: CGRect {
        didSet {
            contentView.frame = bounds
        }
    }
}
