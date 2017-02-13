//
//  PhotoFilterController.swift
//  FaceSnapp2
//
//  Created by Aleksander Makedonski on 2/13/17.
//  Copyright © 2017 Changzhou Panda. All rights reserved.
//

import UIKit

class PhotoFilterController: UIViewController {

    private var mainImage: UIImage
    let context: CIContext
    let eaglContext: EAGLContext
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var filterHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Select a filter"
        label.textAlignment = .center
        return label
    }()
    
    lazy var filtersCollectionView: UICollectionView = {
       let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 1000
        flowLayout.itemSize = CGSize(width: 100, height: 100)
        
        let collectionView = UICollectionView(frame: CGRect(origin: CGPoint(x: 0, y:0), size: CGSize(width: 0, height: 0)), collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.register(FilteredImageCell.self, forCellWithReuseIdentifier: FilteredImageCell.reuseIdentifier)
        return collectionView
    }()
    
    lazy var filteredImages: [CIImage] = {
        let filteredImageBuilder = FilteredImageBuilder(image: self.mainImage, context: self.context)
        return filteredImageBuilder.imageWithDefaultFilters()
    }()
    
    init(image: UIImage, context: CIContext, eaglContext: EAGLContext){
        self.context = context
        self.mainImage = image
        self.eaglContext = eaglContext
        self.photoImageView.image = mainImage
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillLayoutSubviews() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(photoImageView)
        
        filterHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filterHeaderLabel)
        
        filtersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filtersCollectionView)
        
        NSLayoutConstraint.activate([
            filtersCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            filtersCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            filtersCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            filtersCollectionView.heightAnchor.constraint(equalToConstant: 200.0),
            filtersCollectionView.topAnchor.constraint(equalTo: filterHeaderLabel.bottomAnchor),
            filterHeaderLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            filterHeaderLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: filtersCollectionView.topAnchor),
            photoImageView.topAnchor.constraint(equalTo: view.topAnchor),
            photoImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            photoImageView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }

}

//MARK: UICollectionViewDataSource

extension PhotoFilterController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilteredImageCell.reuseIdentifier, for: indexPath) as! FilteredImageCell
        let ciImage = filteredImages[indexPath.row]
        
        cell.ciContext = context
        cell.eaglContext = eaglContext
        cell.image = ciImage
        
        
        return cell
    }
}
