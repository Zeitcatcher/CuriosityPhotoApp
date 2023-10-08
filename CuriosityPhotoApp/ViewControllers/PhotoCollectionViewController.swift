//
//  PhotoCollectionViewController.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 10/5/23.
//

import UIKit

class PhotoCollectionViewController: UIViewController {
    
    var cameraPhotos: [Photo] = []
    
    var cameraName = "" {
        didSet {
            filterCameraPhotos()
            print("#cameraPhotos: ", cameraPhotos.count)
            print("cameraName: \(cameraName)")
            print("#filteredPhotos: ", filteredPhotos.count)
        }
    }
    
    var filteredPhotos: [Photo] = []
    
    @IBOutlet weak var photoCollectionViewController: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
}

//MARK: - Private Methods
extension PhotoCollectionViewController: UICollectionViewDelegate {
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        photoCollectionViewController.delegate = self
        photoCollectionViewController.dataSource = self
    }
    
    private func filterCameraPhotos() {
        print("filtering started. Number to filter: \(cameraPhotos.count)")
        cameraPhotos.forEach { photo in
            if photo.camera.cameraName == cameraName {
                filteredPhotos.append(photo)
                print("filtered successfuly")
            }
        }
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
