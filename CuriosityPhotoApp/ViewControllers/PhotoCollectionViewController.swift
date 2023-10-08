//
//  PhotoCollectionViewController.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 10/5/23.
//

import UIKit

class PhotoCollectionViewController: UIViewController {
    
    var cameraPhotos: [Photo] = []
    
    @IBOutlet weak var photoCollectionViewController: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - Private Methods
extension PhotoCollectionViewController: UICollectionViewDelegate {
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        photoCollectionViewController.collectionViewLayout = layout
        photoCollectionViewController.delegate = self
        photoCollectionViewController.dataSource = self
    }
}

// MARK: - UICollectionViewDataSource
extension PhotoCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
