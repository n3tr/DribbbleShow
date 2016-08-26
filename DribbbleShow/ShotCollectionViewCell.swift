//
//  ShotCollectionViewCell.swift
//  DribbbleShow
//
//  Created by Jirat Ki. on 8/26/2559 BE.
//  Copyright © 2559 n3tr. All rights reserved.
//

import UIKit
import SDWebImage

class ShotCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(shot: [String: AnyObject]) {
        let urlString = shot["images"]!["normal"]! as! String
        let url = NSURL(string: urlString)!
        self.imageView.sd_setImageWithURL(url) { (_, _, _, _) in
            
        }
    }
    

}
