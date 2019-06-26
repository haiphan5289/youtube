//
//  video.swift
//  youtube
//
//  Created by HaiPhan on 6/24/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class video {
    var thumnail_image_video: String?
    var title: String?
    var chanel: chanel?
    var like: Int?
    
    init(thumnail_image_video: String, title: String, chanel: chanel, like: Int) {
        self.thumnail_image_video = thumnail_image_video
        self.title = title
        self.chanel = chanel
        self.like = like
    }
}

class chanel {
    var profile_image: String?
    var name: String?
}

class model_video {
    func create_video() -> [video]{
        var mang_temp_video: [video] = [video]()
        let profile_chanel: chanel = chanel()
        profile_chanel.name = "chanel name"
        profile_chanel.profile_image = "play"
        
        let video1: video = video(thumnail_image_video: "hai", title: "2222222222", chanel: profile_chanel,like: 1231231233434)
        let video2: video = video(thumnail_image_video: "trang", title: "ád ád ád ád ád á dá đâs dá d ád á d ád a sd ạdkj k jk jk j k jk", chanel: profile_chanel, like: 3434343434)
        mang_temp_video.append(video1)
        mang_temp_video.append(video2)
        return mang_temp_video
    }
}

var image_cache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func load_image(text: String){
        if let image_data = image_cache.object(forKey: text as AnyObject) {
            self.image = image_data as! UIImage
            return
            
        }
        
        let url = URL(string: text)
        URLSession.shared.dataTask(with: url!) { (data, res, err) in
            if err != nil {
                print(err?.localizedDescription ?? "hihi")
                return
            }
            if let image_dowload = UIImage(data: data!){
                image_cache.setObject(image_dowload, forKey: text as AnyObject)
                DispatchQueue.main.async {
                    self.image = image_dowload
                }
            }
            }.resume()
    }
}
