//
//  home_cell.swift
//  youtube
//
//  Created by HaiPhan on 6/22/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class home_cell: UICollectionViewCell {
    
    var video: video! {
        didSet {
            guard let image_thumnail = video.thumnail_image_video, let title_video = video.title, let profile_image_video = video.chanel?.profile_image, let name = video.chanel?.name, let number_like = video.like else {
                return
            }
            thumnail_image_video.load_image(text: image_thumnail)
            title.text = title_video
            
            let size = CGSize(width: self.frame.width - 8 - 44 - 8 - 8, height: 1000)
            let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let height_title_video = NSString(string: title_video).boundingRect(with: size, options: option, attributes:  [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)], context: nil).height
            if height_title_video > 20 {
                height_title.constant = 44
            }
            else {
                height_title.constant = 20
            }
            
//            profile_image.image = UIImage(named: profile_image_video)
//            load_image_profile(text: profile_image_video)
            profile_image.load_image(text: profile_image_video)
            let date_format = NumberFormatter()
            date_format.numberStyle = .decimal
            let num_format = date_format.string(from: NSNumber(value: number_like))!
            let sub_title_video = "\(name)" + "    \(num_format)"
            sub_title.text = sub_title_video
        }
    }
    
//    func load_image_profile(text: String){
//        let url = URL(string: text)
//        URLSession.shared.dataTask(with: url!) { (data, res, err) in
//            if err != nil {
//                print(err?.localizedDescription ?? "hihi")
//                return
//            }
//            DispatchQueue.main.async {
//                self.profile_image.image = UIImage(data: data!)
//            }
//
//            }.resume()
//    }
    
//    func load_image_thumail(text: String){
//        let url = URL(string: text)
//        URLSession.shared.dataTask(with: url!) { (data, res, err) in
//            if err != nil {
//                print(err?.localizedDescription ?? "hihi")
//                return
//            }
//            DispatchQueue.main.async {
//                self.thumnail_image_video.image = UIImage(data: data!)
//            }
//
//        }.resume()
//
//    }
    
    var thumnail_image_video: UIImageView!
    var profile_image: UIImageView!
    var title: UILabel!
    var sub_title: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup_view()
    }
    
    func setup_view(){
        sub_title_setup_autolayout()
        title_setup_autolayout()
        profile_image_etup_autolayout()
//        profile_image_etup_autolayout()
//        title_setup_autolayout()
//        sub_title_setup_autolayout()
        thumnail_image_video_setup_autolayout()
    }
    
    //setup - sub title
    func sub_title_setup_autolayout(){
        sub_title = UILabel()
        sub_title.text = "05/02/1989"
        sub_title.font = UIFont.boldSystemFont(ofSize: 14)
        sub_title.textColor = UIColor.lightGray
        sub_title.numberOfLines = 2
        addSubview(sub_title)
        
        sub_title.translatesAutoresizingMaskIntoConstraints = false
        sub_title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 60).isActive = true
//        sub_title.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 4).isActive = true
        sub_title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        sub_title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        sub_title.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    //setup - title
    var height_title: NSLayoutConstraint!
    func title_setup_autolayout(){
        title = UILabel()
        title.text = "Phan Thanh Hai"
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.numberOfLines = 2
        addSubview(title)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 60).isActive = true
//        title.topAnchor.constraint(equalTo: profile_image.topAnchor, constant: 0).isActive = true
        title.bottomAnchor.constraint(equalTo: sub_title.topAnchor, constant: 4).isActive = true
        title.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        height_title = title.heightAnchor.constraint(equalToConstant: 20)
        height_title.isActive = true
    }
    
    //setup - profile image
    func profile_image_etup_autolayout(){
        profile_image = UIImageView()
//        profile_image.backgroundColor = UIColor.green
        profile_image.image = UIImage(named: "profile")
        profile_image.layer.cornerRadius = 22
        profile_image.clipsToBounds = true
        profile_image.contentMode = .scaleToFill
        addSubview(profile_image)
        
        profile_image.translatesAutoresizingMaskIntoConstraints = false
//        profile_image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        profile_image.topAnchor.constraint(equalTo: title.topAnchor, constant: 0).isActive = true
        profile_image.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profile_image.widthAnchor.constraint(equalToConstant: 44).isActive = true
        profile_image.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    //setup thumnail image
    func thumnail_image_video_setup_autolayout(){
        thumnail_image_video = UIImageView()
//        thumnail_image_video.backgroundColor = UIColor.brown
//        thumnail_image_video.image = UIImage(named: "hai")
        thumnail_image_video.clipsToBounds = true
        thumnail_image_video.contentMode = .scaleToFill
        addSubview(thumnail_image_video)
        
        thumnail_image_video.translatesAutoresizingMaskIntoConstraints = false
        thumnail_image_video.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        thumnail_image_video.bottomAnchor.constraint(equalTo: profile_image.topAnchor, constant: -8).isActive = true
        thumnail_image_video.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -16).isActive = true
        thumnail_image_video.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
//        thumnail_image_video.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -68).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
