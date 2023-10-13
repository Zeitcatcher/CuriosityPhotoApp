//
//  PhotoCollectionViewController.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 10/5/23.
//

import UIKit

class PhotoCollectionViewController: UIViewController {
    @IBOutlet weak var photoCollectionViewController: UICollectionView!
    @IBOutlet weak var photoLabel: UILabel!
    
    var cameraPhotos: [Photo] = []
    var filteredPhotos: [Photo] = []
    var cameraName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        photoLabel.text = cameraName
    }
    
    func configure(with photos: [Photo], and name: String) {
        cameraPhotos = photos
        cameraName = name
        filter()
    }
    
    private func filter() {
        filteredPhotos = cameraPhotos.filter { $0.camera.cameraName == cameraName }
    }
}

//MARK: - Private Methods
extension PhotoCollectionViewController: UICollectionViewDelegate {
    private func setupCollectionView() {
        photoCollectionViewController.delegate = self
        photoCollectionViewController.dataSource = self
    }
}

// MARK: - UICollectionViewDataSource
extension PhotoCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "photoCell",
                for: indexPath
            ) as? PhotosCollectionViewCell 
        else {
            return UICollectionViewCell()
        }
        
        let photo = filteredPhotos[indexPath.item]
        cell.configure(with: photo)
        return cell
    }
}
