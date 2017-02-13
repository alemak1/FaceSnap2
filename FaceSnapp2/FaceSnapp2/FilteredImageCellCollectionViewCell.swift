//
//  FilteredImageCellCollectionViewCell.swift
//  FaceSnapp2
//
//  Created by Aleksander Makedonski on 2/13/17.
//  Copyright © 2017 Changzhou Panda. All rights reserved.
//

import UIKit
import GLKit

class FilteredImageCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: FilteredImageCell.self)
    
    var eaglContext: EAGLContext!
    var ciContext: CIContext!
    var image: CIImage!
    
    lazy var glkView: GLKView = {
        let view = GLKView(frame: self.contentView.frame, context: self.eaglContext)
        view.delegate = self
        return view
    }()
    
    override func layoutSubviews(){
        contentView.addSubview(glkView)
        glkView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            glkView.topAnchor.constraint(equalTo: contentView.topAnchor),
            glkView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            glkView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            glkView.rightAnchor.constraint(equalTo: contentView.rightAnchor),

            
            ])
    }
}

extension FilteredImageCell: GLKViewDelegate{
    func glkView(_ view: GLKView, drawIn rect: CGRect) {
        ciContext.draw(image, in: rect, from: image.extent)
    }
}
