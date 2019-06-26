//
//  menu_cell.swift
//  youtube
//
//  Created by HaiPhan on 6/22/19.
//  Copyright © 2019 HaiPhan. All rights reserved.
//

import UIKit

class menu_cell: UICollectionViewCell {
    
    var cell_image: UIImageView!
    override var isHighlighted: Bool {
        didSet {
            cell_image.tintColor = isHighlighted ? UIColor.white : UIColor.black
        }
    }
    override var isSelected: Bool {
        didSet {
            cell_image.tintColor = isSelected ? UIColor.white : UIColor.black
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup_view()
    }
    
    func setup_view(){
        cell_image_setup()
    }
    
    func cell_image_setup(){
        cell_image = UIImageView()
//        cell_image.image = UIImage(named: "share")
        cell_image.tintColor = UIColor.black
        //add withRenderingMode thi image tincolor mới có tác dụng
//        cell_image.image = cell_image.image?.withRenderingMode(.alwaysTemplate)
        addSubview(cell_image)
        
        cell_image.translatesAutoresizingMaskIntoConstraints = false
        cell_image.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        cell_image.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        cell_image.widthAnchor.constraint(equalToConstant: 30).isActive = true
//        cell_image.heightAnchor.constraint(equalToConstant: 30).isActive = true
        cell_image.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
