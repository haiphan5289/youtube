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
    var view_container_play_button: UIView!
    var activities: UIActivityIndicatorView!
    var video_field: AVPlayer!
    @objc let text : String = "key_path"
    var show_button: UIButton!
    var isplaying: Bool!
    var total_time: UILabel!
    var show_time_video: UISlider!
    var time_start: UILabel!
//    var show_button: UIButton!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup_video()
//        self.backgroundColor = UIColor(white: 0, alpha: 0.5)
        view_container_play_button = UIView()
        view_container_play_button.frame = self.frame
        view_container_play_button.backgroundColor = UIColor(white: 0, alpha: 0.1)
        self.addSubview(view_container_play_button)
        

        activities = UIActivityIndicatorView(style: .whiteLarge)
        view_container_play_button.addSubview(activities)
        activities.translatesAutoresizingMaskIntoConstraints = false
        activities.centerXAnchor.constraint(equalTo: view_container_play_button.centerXAnchor, constant: 0).isActive = true
        activities.centerYAnchor.constraint(equalTo: view_container_play_button.centerYAnchor, constant: 0).isActive = true
//        activities.startAnimating()
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap_video)))
        
        show_button = UIButton(type: .system)
        view_container_play_button.addSubview(show_button)
        show_button.setTitle("hihi", for: .normal)
        show_button.isHidden = true
        show_button.translatesAutoresizingMaskIntoConstraints = false
        show_button.centerYAnchor.constraint(equalTo: view_container_play_button.centerYAnchor).isActive = true
        show_button.centerXAnchor.constraint(equalTo: view_container_play_button.centerXAnchor, constant: 0).isActive = true
        show_button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        show_button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        isplaying = true
        
        total_time = UILabel()
        total_time.text = "00:00"
        total_time.font = UIFont.boldSystemFont(ofSize: 16)
        total_time.textColor = .white
        view_container_play_button.addSubview(total_time)
        
        total_time.translatesAutoresizingMaskIntoConstraints = false
        total_time.rightAnchor.constraint(equalTo: view_container_play_button.rightAnchor, constant: -8).isActive = true
        total_time.bottomAnchor.constraint(equalTo: view_container_play_button.bottomAnchor, constant: 0).isActive = true
        total_time.widthAnchor.constraint(equalToConstant: 60).isActive = true
        total_time.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        time_start = UILabel()
        time_start.text = "00:00"
        time_start.font = UIFont.boldSystemFont(ofSize: 16)
        time_start.textColor = .white
        view_container_play_button.addSubview(time_start)
        
        time_start.translatesAutoresizingMaskIntoConstraints = false
        time_start.leftAnchor.constraint(equalTo: view_container_play_button.leftAnchor, constant: 8).isActive = true
        time_start.bottomAnchor.constraint(equalTo: view_container_play_button.bottomAnchor, constant: 0).isActive = true
        time_start.widthAnchor.constraint(equalToConstant: 60).isActive = true
        time_start.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        show_time_video = UISlider()
        show_time_video.minimumTrackTintColor = UIColor.red
        show_time_video.maximumTrackTintColor = UIColor.white
        show_time_video.addTarget(self, action: #selector(handle_video_process), for: .valueChanged)
        view_container_play_button.addSubview(show_time_video)
        
        show_time_video.translatesAutoresizingMaskIntoConstraints = false
        show_time_video.leftAnchor.constraint(equalTo: time_start.rightAnchor, constant: 8).isActive = true
        show_time_video.centerYAnchor.constraint(equalTo: total_time.centerYAnchor, constant: 0).isActive = true
        show_time_video.rightAnchor.constraint(equalTo: total_time.leftAnchor, constant: -8).isActive = true
        show_time_video.heightAnchor.constraint(equalToConstant: 30).isActive = true


    }
    
    @objc func handle_video_process(){
        //total thời gian video
        let total_2 = video_field.currentItem?.duration
        let total_second_2 = CMTimeGetSeconds(total_2!)
//        show_time_video.maximumValue = Float(total_second_2)
//        show_time_video.minimumValue = 0
        
        //lấy giá trị value slider ra
        let value = Float64(show_time_video.value)
        //đổi giái trị slider >> time của video
        let interval = CMTime(value: CMTimeValue(Float64(value)), timescale: 1)
        print(interval)
//        print(show_time_video.value)
        //play tiếp nới slider hiển
        video_field.seek(to: interval) { (completion) in
            
        }
    }
    
    @objc func tap_video(){
        if isplaying {
            video_field.pause()
            isplaying = false
            show_button.isHidden = false
        }else{
            video_field.play()
            isplaying = true
            show_button.isHidden = true
        }
    }
    
    func setup_video(){
        
        let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/banhangonline-f2561.appspot.com/o/video_url%3A%2FKAnypXqd2XaPTLQxwtz8x7JuqIk1105?alt=media&token=14e47b21-9455-4871-9134-8c1a323a92d6")
        video_field = AVPlayer(url: url!)
        let frame_video = AVPlayerLayer(player: video_field)
//        let height = self.frame.width * 9 / 16
        frame_video.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        //        frame_video.backgroundColor = UIColor.green.cgColor
        self.layer.addSublayer(frame_video)
        video_field.play()

        //            let total_duration_second = CMTimeGetSeconds(total_duratin!)
        //chuyển dữ liệu time >> second
        let interval = CMTime(value: 1, timescale: 2)
        video_field.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { (process) in
            let total_duratin = self.video_field.currentItem?.duration
            let total_duration_second = CMTimeGetSeconds(total_duratin!)
            let second = Int(total_duration_second) % 60
//            let minutes = Int(total_duration_second) / 60
            let minutes = String(format: "%2d", Int(second) / 60)
            self.total_time.text = "\(minutes):\(second)"
            let current_second = CMTimeGetSeconds(process)
            self.show_time_video.maximumValue = Float(CGFloat(total_duration_second))
            self.show_time_video.minimumValue = 0
            self.show_time_video.value = Float(CGFloat(current_second))
            let current_time = CMTimeGetSeconds(process)
            let start_second = Int(current_time) % 60
            let start_minutes = Int(current_time) / 60
            self.time_start.text = "\(start_minutes):\(start_second)"
        }
//        activities.stopAnimating()
//        video_field.addObserver(self, forKeyPath: "abc", options: .new, context: nil)

    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "abc" {
            print("hihi")
        }
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
            view_play_video.backgroundColor = UIColor.white
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
