//
//  PhotoCollectionViewController.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 10/5/23.
//

import UIKit

final class PhotoCollectionViewController: UIViewController {
    
    @IBOutlet private weak var photoCollectionViewController: UICollectionView!
    @IBOutlet private weak var photoLabel: UILabel!
    
    private var filteredPhotos: [Photo] = []
    private var cameraName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        photoLabel.text = cameraName
    }
    
    func configure(with photos: [Photo], and name: String) {
        cameraName = name
        filter(with: photos)
    }
    
    //MARK: - Private Methods
    private func setupCollectionView() {
        photoCollectionViewController.delegate = self
        photoCollectionViewController.dataSource = self
    }
    
    private func filter(with photos: [Photo]) {
        filteredPhotos = photos.filter { $0.camera.cameraName == cameraName }
    }
}
//MARK: - Collection View Delegate, Collection View DataSource
extension PhotoCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, Storyboarded {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController.instantiate()
        
        detailsVC.image = filteredPhotos[indexPath.item]
        navigationController?.pushViewController(detailsVC, animated: true)
//        present(detailsVC, animated: true, completion: nil)
    }
}
