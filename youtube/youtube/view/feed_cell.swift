//
//  feed_cell.swift
//  youtube
//
//  Created by HaiPhan on 6/26/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class feed_cell: UICollectionViewCell, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    var array_video: [video] = [video]()
    var collect_feed: UICollectionView!
    let CellReuseIdentifier = "cell"
    let cell_like = "like"
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = UIColor.white
        setup_view()
    }
    
    func setup_view(){
        collect_feed_setup_autolayout()
        get_array_video()
    }
    func get_array_video(){
        api_serivce.share.fetch_video { (array_video_2: [video]) in
            self.array_video = array_video_2
            DispatchQueue.main.async {
                self.collect_feed.reloadData()
            }
//            return array_video_2
        }
    }
    //setup - autolayout collect
    func collect_feed_setup_autolayout(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        collect_feed = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collect_feed = UICollectionView()
//        collect_feed.backgroundColor = UIColor.blue
        collect_feed.delegate = self
        collect_feed.dataSource = self
        collect_feed.register(home_cell.self, forCellWithReuseIdentifier: CellReuseIdentifier)
        collect_feed.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cell_like)
        collect_feed.contentInset = UIEdgeInsets(top: 58, left: 0, bottom: 58, right: 0)
        collect_feed.scrollIndicatorInsets = UIEdgeInsets(top: 58, left: 0, bottom: 58, right: 0)

        self.addSubview(collect_feed)

        collect_feed.translatesAutoresizingMaskIntoConstraints = false
        collect_feed.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        collect_feed.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        collect_feed.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0).isActive = true
        collect_feed.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 0).isActive  = true

        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.array_video.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReuseIdentifier, for: indexPath) as! home_cell
        cell.backgroundColor = UIColor.white
        cell.video = self.array_video[indexPath.row]
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.frame.width, height: self.frame.height)
//    }
    //customer height cho cell
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let height_text = estiamte_size_for_text(text: (self.array_video[indexPath.row].title)!).height
            var height_cell: CGFloat!
            if height_text > 20 {
                height_cell = 300
            }
            else {
                height_cell = 200
            }
            return CGSize(width: self.frame.width, height: 300)
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let view_play_text = view_play()
        view_play_text.create_view_play()
    }
    
    func estiamte_size_for_text(text: String) -> CGRect{
        let size = CGSize(width: self.frame.width - 8 - 44 - 8 - 8, height: 1000)
        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: option, attributes:  [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)], context: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

