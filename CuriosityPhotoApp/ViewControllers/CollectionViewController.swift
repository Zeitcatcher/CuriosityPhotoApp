//
//  CollectionViewController.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 9/17/23.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var CamerasCollectionVewController: UICollectionView!
    
    var photos: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotos()
    }
    
    // MARK: - Table view data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var uniqueCameras = Set<String>()
        for photo in photos {
            uniqueCameras.insert(photo.camera.cameraName)
        }
        return uniqueCameras.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "cell",
                for: indexPath
            ) as? PhotoCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let photo = photos[indexPath.item]
        cell.configue(with: photo)
        return cell
    }
}

//MARK: - Private Methods
extension CollectionViewController {
    private func fetchPhotos() {
        NetworkManager.shared.fetch([Photo].self, from: Photo.URL.nasa.rawValue) { [ weak self ] result in
            switch result {
            case .success(let photos):
                self?.photos = photos
                //дописать обновления item
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK: - UICollectionViewDelegetaFlowLayout
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width / 2 - 24, height: UIScreen.main.bounds.width / 1.5)
    }
}
