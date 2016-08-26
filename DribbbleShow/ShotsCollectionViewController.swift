//
//  ShotsCollectionViewController.swift
//  DribbbleShow
//
//  Created by Jirat Ki. on 8/26/2559 BE.
//  Copyright © 2559 n3tr. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "ShotCollectionViewCell"
private let dribbbleAccessToken = "865c0ec9f1388e9df68a4a2d55d54d9bcfbe330b4e5b3bf9529cfc819b5f7b63"

class ShotsCollectionViewController: UICollectionViewController {
    
    var shots: [[String: AnyObject]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // UNCOMMENT HERE TO CLEAR IMAGE CACHE
        // Force Clear SDWebImage Cache
//        SDImageCache.sharedImageCache().clearMemory()
//        SDImageCache.sharedImageCache().clearDisk()
        

        // Register cell classes
        self.collectionView?.registerNib(UINib(nibName: "ShotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        
        setupFlowLayout()
        fetchShots()
    }
    
    func setupFlowLayout() {
        let screenWidth = CGRectGetWidth(UIScreen.mainScreen().bounds)
        let itemWidth = (screenWidth - 4) / 2
        let itemHeight = itemWidth * 0.75
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight)
        flowLayout.minimumLineSpacing = 4
        flowLayout.minimumInteritemSpacing = 4
        self.collectionView?.collectionViewLayout = flowLayout

    }
    
    func fetchShots(){
        let url = NSURL(string: "https://api.dribbble.com/v1/shots?per_page=100&access_token=\(dribbbleAccessToken)")!
        NSURLSession.sharedSession().dataTaskWithURL(url) { [unowned self] (data, _, _) in
            let shots = try? NSJSONSerialization.JSONObjectWithData(data!, options: []) // array of shot dict
            self.shots = shots as! [[String: AnyObject]]
            debugPrint(self.shots)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.collectionView?.reloadData()
            })
            
        }.resume()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.shots.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! ShotCollectionViewCell
        cell.configureCell(self.shots[indexPath.row])
        
        // Configure the cell
    
        return cell
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
