//
//  api_serivce.swift
//  youtube
//
//  Created by HaiPhan on 6/25/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class api_serivce {
    static let share = api_serivce()
    func fetch_video(completion: @escaping ([video]) ->()){
        get_data_json(text: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json") { (videos) in
            completion(videos)
        }
    }
    func fetch_video_like(completion: @escaping ([video]) ->()){
        //trả về là 1 mảng [video], đểl lưu dữl iệu [video] khi qua các hàm
        get_data_json(text: "https://s3-us-west-2.amazonaws.com/youtubeassets/trending.json") { (videos) in
            completion(videos)
        }
    }
    func fetch_video_share(completion: @escaping ([video]) -> ()){
        get_data_json(text: "https://s3-us-west-2.amazonaws.com/youtubeassets/subscriptions.json") { (videos) in
            completion(videos)
        }
    }
    //hàm rút gọn thi get data tư json, trả về là 1 mảng [video]
    func get_data_json(text: String, completion: @escaping ([video]) -> ()){
        let url = URL(string: text)
        URLSession.shared.dataTask(with: url!) { (data, res, err) in
            if err != nil {
                print(err?.localizedDescription ?? "hihi")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
                var array_video: [video] = [video]()
                for childa in json as! [[String:Any]] {
                    let title = childa["title"] as! String
                    let number = childa["number_of_views"] as! NSNumber
                    let thumbnail_image_name = childa["thumbnail_image_name"] as! String
                    let chanel_json = childa["channel"] as! NSDictionary
                    let channel_name = chanel_json["name"] as! String
                    let channel_image = chanel_json["profile_image_name"] as! String
                    
                    let chanel_temp = chanel()
                    chanel_temp.name = channel_name
                    chanel_temp.profile_image = channel_image
                    
                    let video_data: video = video(thumnail_image_video: thumbnail_image_name, title: title, chanel: chanel_temp, like: Int(truncating: number))
                    array_video.append(video_data)
                }
                completion(array_video)
                
            } catch let err as NSError{
                print(err)
            }
            
            }.resume()
    }
}
