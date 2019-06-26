//
//  setting.swift
//  youtube
//
//  Created by HaiPhan on 6/24/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class setting: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collect_more.delegate   = self
        collect_more.dataSource = self
        collect_more.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CellWithReuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var back_view = UIView()
    var collect_more : UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    let CellWithReuseIdentifier = "cell"
    func create_setting(){
        if let key_window = UIApplication.shared.keyWindow {
//            back_view = UIView()
            back_view.backgroundColor = UIColor(white: 0, alpha: 0.5)
//            back_view.isUserInteractionEnabled = true
            back_view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handle_hide_back_view)))
            key_window.addSubview(back_view)
            back_view.frame = key_window.frame
            
            
            //taok colloect
//            collect_more.frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
            collect_more.backgroundColor = UIColor.white
            
            key_window.addSubview(collect_more)
            let height = 300
            collect_more.frame = CGRect(x: 0, y: key_window.frame.height, width: key_window.frame.width, height: 300)
            collect_more.backgroundColor = UIColor.white
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.collect_more.frame = CGRect(x: 0, y: key_window.frame.height - 300, width: key_window.frame.width, height: 300)
            }, completion: nil)
        }
    }
    @objc func handle_hide_back_view(){
        print("hihi")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collect_more.dequeueReusableCell(withReuseIdentifier: CellWithReuseIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.darkGray
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collect_more.frame.width, height: 50)
    }
}
