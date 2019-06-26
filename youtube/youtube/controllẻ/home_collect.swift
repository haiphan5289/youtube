//
//  home_collect.swift
//  youtube
//
//  Created by HaiPhan on 6/22/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class home_collect: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collect: UICollectionView!
    var array_video: [video] = [video]()
    let CellWithReuseIdentifier_temp = "cell"
    var array_title = ["Home", "Like", "Share", "Comment"]
    let cell_like_text = "like"
    let subscription_text = "subscription"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register cell classes
//        self.collectionView!.register(home_cell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collect.register(feed_cell.self, forCellWithReuseIdentifier: CellWithReuseIdentifier_temp)
        self.collect.register(cell_like.self, forCellWithReuseIdentifier: cell_like_text)
        self.collect.register(subscription_cell.self, forCellWithReuseIdentifier: subscription_text)
        self.collect.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
        self.collect.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
        self.collect.isPagingEnabled = true
        if let layout = collect.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
//        let model = model_video()
//        array_video = model.create_video()
        
        setup_view()

    }
    
    func setup_view(){
        navigation_setup()
        menu_view_setup_autolayout()
//        fetch_data_json()
        check_api()
    }
    
    func check_api(){
        api_serivce.share.fetch_video { (array_video_2: [video]) in
            self.array_video = array_video_2
            DispatchQueue.main.async {
                self.collect.reloadData()
            }
//            return self.array_video
        }
    }
    
    func fetch_data_json(){
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { (data, res, err) in
            if err != nil {
                print(err?.localizedDescription ?? "hihi")
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
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
                    self.array_video.append(video_data)
                    DispatchQueue.main.async {
                        self.collect.reloadData()
                    }
                }

            } catch let err as NSError{
                print(err)
            }

        }.resume()
    }
    var menu_view_home: menu_view!
    //setup navigation
    func navigation_setup(){

        
        //add View controller-based status bar appearance vào infor = no
        UIApplication.shared.statusBarStyle = .lightContent
        
//        navigationController?.navigationBar.topItem?.title = "Home"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.barTintColor = UIColor(red: 230/255, green: 31/255, blue: 32/255, alpha: 1)
        
        //tạo 1 label trên titleview
        let title = UILabel()
        title.text = "Home"
        title.textColor = UIColor.white
        title.frame = CGRect(x: 0, y: 0, width: view.frame.width,  height: view.frame.height)
        title.font = UIFont.boldSystemFont(ofSize: 25)
        navigationItem.titleView = title
        
        navigationController?.navigationBar.isTranslucent = false
        
        //set bordẻ navigation hide
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        //tạo view cho status bar
//        let statusBar = UIApplication.shared.value(forKey: "statusBarWindow") as? UIWindow
        // create a subview & add it to the status bar
//        let subview = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: UIApplication.shared.statusBarFrame.height))
//        subview.backgroundColor = UIColor(red: 194/155, green: 31/255, blue: 32/255, alpha: 1)
//        subview.alpha = 0.3
//        statusBar?.addSubview(subview)
//        statusBar?.bringSubviewToFront(subview)
        let search: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(search_button))
        let more: UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "more")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: nil)

        navigationItem.rightBarButtonItems = [more,search]

    }
    
    @objc func search_button(){
        scroll_to_uicollect(positiom_item: 2)
    }
//    let setting_launcher: setting! = nil
//    @objc func handle_click_more(){
//        self.setting_launcher!.create_setting()
//
//    }


    
    //setup menu view
    func menu_view_setup_autolayout(){
        //add menu view
        menu_view_home = menu_view()
//        menu_view_home.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        //phải khai báo dòng này không thì sẽ bị lỗi nil, không sẽ bị crash app khi view khác khởi tạo hàm trong view này
        menu_view_home.delegate_home_collect = self
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
//            self.navigationController?.hidesBarsOnSwipe = true
        }, completion: nil)
        view.addSubview(menu_view_home)
        
        menu_view_home.translatesAutoresizingMaskIntoConstraints = false
        menu_view_home.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        menu_view_home.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        menu_view_home.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
        menu_view_home.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func scroll_to_uicollect(positiom_item: Int){
        let index = IndexPath(item: positiom_item, section: 0)
        self.collect.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.item == 0 {
//            return collect.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! home_collect
//        }

        if indexPath.row == 1 {
            return collect.dequeueReusableCell(withReuseIdentifier: cell_like_text, for: indexPath)
        } else if indexPath.row == 2{
            return collect.dequeueReusableCell(withReuseIdentifier: subscription_text, for: indexPath)
        }
        let cell = collect.dequeueReusableCell(withReuseIdentifier: CellWithReuseIdentifier_temp, for: indexPath)
//        let array_color: [UIColor] = [.blue, .red, .green, .cyan]
//        cell.backgroundColor = array_color[indexPath.row]
//        cell.video = self.array_video[indexPath.row]
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.height)
    }
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = (targetContentOffset.pointee.x / self.view.frame.width) * self.view.frame.width / 4
        let index_text = Int(targetContentOffset.pointee.x / self.view.frame.width)
        let index_select = IndexPath(item: index_text, section: 0)
        self.menu_view_home.left_border_menu.constant = x
        //select item của uicollect
        self.menu_view_home.collect_menu.selectItem(at: index_select, animated: true, scrollPosition: .centeredVertically)
        UIView.animate(withDuration: 0.7) {
            self.view.layoutIfNeeded()
        }
        if let title = navigationItem.titleView as? UILabel {
            title.text = self.array_title[index_text]
        }
    }
    

//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of items
//        return self.array_video.count
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! home_cell
////        cell.backgroundColor = UIColor.darkGray
//        cell.layer.borderColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
//        cell.layer.borderWidth = 1
//        cell.video = self.array_video[indexPath.row]
//
//        return cell
//    }
//
//    customer height cho cell
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let height_text = estiamte_size_for_text(text: (self.array_video[indexPath.row].title)!).height
//        var height_cell: CGFloat!
//        if height_text > 20 {
//            height_cell = 300
//        }
//        else {
//            height_cell = 200
//        }
//        return CGSize(width: self.view.frame.width, height: 300)
//    }
    
    func estiamte_size_for_text(text: String) -> CGRect{
        let size = CGSize(width: self.view.frame.width - 8 - 44 - 8 - 8, height: 1000)
        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: option, attributes:  [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)], context: nil)
    }



}
