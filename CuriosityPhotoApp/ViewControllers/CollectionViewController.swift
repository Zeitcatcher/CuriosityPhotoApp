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
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotos()
        setupCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.item]
        performSegue(withIdentifier: "detailsSegue", sender: photo)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let photoCollectionView = segue.destination as? PhotoCollectionViewController else { return }
        guard let indexPath = camerasCollectionVewController.indexPathsForSelectedItems?.first else { return }
        
    }
}

//MARK: - Private Methods
extension CollectionViewController: UICollectionViewDelegate {
    private func fetchPhotos() {
        NetworkManager.shared.fetch(PhotoCollection.self, from: JsonURL.nasa.rawValue) { [ weak self ] result in
            switch result {
            case .success(let photoCollection):
                print("Photos fetched succesfully")
                self?.photos = photoCollection.photos
                self?.camerasCollectionVewController.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        camerasCollectionVewController.collectionViewLayout = layout
        camerasCollectionVewController.delegate = self
        camerasCollectionVewController.dataSource = self
    }
}

// MARK: - UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDataSource {
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
            ) as? CameraCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let photo = photos[indexPath.item]
        cell.configue(with: photo)
        return cell
    }
}

//MARK: - UICollectionViewDelegetaFlowLayout
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width / 2 - 24, height: UIScreen.main.bounds.width / 1.2)
    }
}
