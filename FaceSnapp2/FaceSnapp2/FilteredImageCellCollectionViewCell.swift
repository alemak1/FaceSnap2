//
//  FilteredImageCellCollectionViewCell.swift
//  FaceSnapp2
//
//  Created by Aleksander Makedonski on 2/13/17.
//  Copyright © 2017 Changzhou Panda. All rights reserved.
//

import UIKit

class FilteredImageCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: FilteredImageCell.self)
    
    let imageView = UIImageView()
    
    override func layoutSubviews(){
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),

            
            ])
    }
}
