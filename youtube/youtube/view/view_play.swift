//
//  view_play.swift
//  youtube
//
//  Created by HaiPhan on 6/26/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit
import AVFoundation

class view_avplayer: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/banhangonline-f2561.appspot.com/o/video_url%3A%2FKAnypXqd2XaPTLQxwtz8x7JuqIk1105?alt=media&token=14e47b21-9455-4871-9134-8c1a323a92d6")
        let video_field = AVPlayer(url: url!)
        let frame_video = AVPlayerLayer(player: video_field)
        let height = self.frame.width * 9 / 16
        frame_video.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        frame_video.backgroundColor = UIColor.green.cgColor
        self.layer.addSublayer(frame_video)
        video_field.play()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class view_play: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func create_view_play(){
        if let key_window = UIApplication.shared.keyWindow {
            //tạo 1 cái view dựa tren frame của key_window
            let view_play_video = UIView()
            view_play_video.frame = key_window.frame
            view_play_video.backgroundColor = UIColor.blue
            view_play_video.frame = CGRect(x: key_window.frame.width, y: key_window.frame.height, width: 20, height: 20 )
            key_window.addSubview(view_play_video)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                view_play_video.frame = CGRect(x: 0, y: 0, width: key_window.frame.width, height: key_window.frame.height)
                let height = view_play_video.frame.width * 9 / 16
                let player = view_avplayer(frame: CGRect(x: 0, y: 0, width: view_play_video.frame.width, height: height))
                view_play_video.addSubview(player)
//                let video_field = AVPlayer(url: url!)
//                let frame_video = AVPlayerLayer(player: video_field)
//                let height = self.frame.width * 9 / 16
//                frame_video.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: height)
//                frame_video.backgroundColor = UIColor.green.cgColor
//                self.layer.addSublayer(frame_video)
//                video_field.play()
            }) { (completion) in
                //ẩn status
                UIApplication.shared.isStatusBarHidden = true
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
