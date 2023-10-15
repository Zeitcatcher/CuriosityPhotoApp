//
//  CollectionViewController.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 9/17/23.
//

import UIKit

final class CamerasCollectionViewController: UIViewController {
    
    @IBOutlet private weak var camerasCollectionVewController: UICollectionView!
    
    private var photos: [Photo] = [] {
        didSet {
            photos.forEach { uniqueCameras.insert( $0.camera.cameraName )}
        }
    }
    
    private var uniqueCameras = Set<String>()
    private var tappedCameraLabelText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotos()
        setupCollectionView()
    }
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let currentCell = collectionView.cellForItem(at: indexPath) as? CamerasCollectionViewCell else { return }
        let photoVC = PhotoCollectionViewController.instantiate()
        
        tappedCameraLabelText = currentCell.cameraLabel.text ?? ""
        photoVC.configure(with: photos, and: tappedCameraLabelText)
        present(photoVC, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension CamerasCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        uniqueCameras.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "cameraCell",
                for: indexPath
            ) as? CamerasCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.configue(with: photos[indexPath.item])
        return cell
    }
}

//MARK: - UICollectionViewDelegetaFlowLayout
extension CamerasCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width / 2 - 24, height: UIScreen.main.bounds.width / 1.2)
    }
}
