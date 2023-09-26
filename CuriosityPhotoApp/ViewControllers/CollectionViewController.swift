//
//  CollectionViewController.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 9/17/23.
//

import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var camerasCollectionVewController: UICollectionView!
    var photos: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchPhotos()
    }
    
    // MARK: - Table view data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var uniqueCameras = Set<String>()
        for photo in photos {
            uniqueCameras.insert(photo.camera.cameraName)
        }
        print("Number of items in section: \(uniqueCameras.count)")
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
        print("test 2 success: cellForItemAt indexPath")
        return cell
    }
}

//MARK: - Private Methods
extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func fetchPhotos() {
        NetworkManager.shared.fetch(PhotoCollection.self, from: JsonURL.nasa.rawValue) { [ weak self ] result in
            switch result {
            case .success(let photoCollection):
                print("Photo fetched succesfully")
                self?.photos = photoCollection.photos
                self?.camerasCollectionVewController.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK: - UICollectionViewDelegetaFlowLayout
extension CollectionViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width / 2 - 24, height: UIScreen.main.bounds.width / 1.5)
    }
    
    private func setupCollectionView() {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.collectionView?.backgroundColor = .red
//        camerasCollectionVewController.backgroundColor = .red
        camerasCollectionVewController.delegate = self
        camerasCollectionVewController.dataSource = self
    }
}
