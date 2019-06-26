//
//  menu_view.swift
//  youtube
//
//  Created by HaiPhan on 6/22/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class menu_view: UIView {
    var collect_menu: UICollectionView!
    let CellWithReuseIdentifier = "cell"
    var array_menu = ["comments", "like", "share", "new_feed"]
    var delegate_home_collect: home_collect?
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = UIColor(red: 230/255, green: 31/255, blue: 32/255, alpha: 1)
        menu_setup_autolayut()
    }
    
    //setup -autolayout menu
    func menu_setup_autolayut(){
        let layout = UICollectionViewFlowLayout()
        collect_menu = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collect_menu.backgroundColor = UIColor(red: 230/255, green: 31/255, blue: 32/255, alpha: 1)
        collect_menu.delegate = self
        collect_menu.dataSource = self
        collect_menu.register(menu_cell.self, forCellWithReuseIdentifier: CellWithReuseIdentifier)
        collect_menu.backgroundColor = UIColor(red: 230/255, green: 31/255, blue: 32/255, alpha: 1)
        addSubview(collect_menu)
        
        collect_menu.translatesAutoresizingMaskIntoConstraints = false
        collect_menu.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        collect_menu.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        collect_menu.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0).isActive = true
        collect_menu.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 0).isActive = true
        
        //chọn item đầu tiền
        let indexpath = IndexPath(item: 0, section: 0)
        collect_menu.selectItem(at: indexpath, animated: true, scrollPosition: .left)
        
        barbutton_menu_Setup()
    }
    var left_border_menu: NSLayoutConstraint!
    func barbutton_menu_Setup(){
        let barbutton_menu = UIView()
        barbutton_menu.backgroundColor = UIColor.white
        self.addSubview(barbutton_menu)
        
        barbutton_menu.translatesAutoresizingMaskIntoConstraints = false
        left_border_menu = barbutton_menu.leftAnchor.constraint(equalTo: collect_menu.leftAnchor, constant: 0)
        left_border_menu.isActive = true
        barbutton_menu.bottomAnchor.constraint(equalTo: collect_menu.bottomAnchor, constant: 0).isActive = true
        barbutton_menu.widthAnchor.constraint(equalTo: collect_menu.widthAnchor, multiplier: 1/4).isActive = true
//        barbutton_menu.widthAnchor.constraint(equalToConstant: 200).isActive = true
        barbutton_menu.heightAnchor.constraint(equalToConstant: 4).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension menu_view: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.array_menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellWithReuseIdentifier, for: indexPath) as! menu_cell
        cell.backgroundColor = UIColor(red: 230/255, green: 31/255, blue: 32/255, alpha: 1)
        cell.cell_image.image = UIImage(named: self.array_menu[indexPath.row])!.withRenderingMode(.alwaysTemplate)
//        cell.layer.borderColor = UIColor.clear.cgColor
//        cell.layer.borderColor = UIColor(red: 230/255, green: 31/255, blue: 32/255, alpha: 1).cgColor
//        cell.layer.borderWidth = 1
//        cell.separatorInset = UIEdgeInsets.zero
//        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width / 4, height: self.frame.height - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let x = CGFloat(indexPath.item) * self.frame.width / 4
        let index = Int(indexPath.item)
        self.delegate_home_collect!.scroll_to_uicollect(positiom_item: index)
        if let title = self.delegate_home_collect?.navigationItem.titleView as? UILabel {
            title.text = self.delegate_home_collect?.array_title[index]
        }
        left_border_menu.constant = x
        UIView.animate(withDuration: 0.7) {
            self.layoutIfNeeded()
            
        }
    }
}
