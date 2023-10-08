//
//  CollectionViewController.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 9/17/23.
//

import UIKit

class CamerasCollectionViewController: UIViewController {
    
    @IBOutlet weak var camerasCollectionVewController: UICollectionView!
    
    var photos: [Photo] = [] {
        didSet {
            photos.forEach { uniqueCameras.insert( $0.camera.cameraName) }
        }
    }
    
    var uniqueCameras = Set<String>()
    var tappedCameraLabelText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhotos()
        setupCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let currentCell = collectionView.cellForItem(at: indexPath) as? CamerasCollectionViewCell else { return }
        tappedCameraLabelText = currentCell.cameraLabel.text ?? ""
        performSegue(withIdentifier: "detailsSegue", sender: photos)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let photoCollectionView = segue.destination as? PhotoCollectionViewController else { return }
        photoCollectionView.cameraPhotos = photos
        print("#photos: ", photos.count)
        photoCollectionView.cameraName = tappedCameraLabelText
        print("tappedCameraLabelText: ", tappedCameraLabelText)
    }
}

//MARK: - Private Methods
extension CamerasCollectionViewController: UICollectionViewDelegate {
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
        let photo = photos[indexPath.item]
        cell.configue(with: photo)
        return cell
    }
}

//MARK: - UICollectionViewDelegetaFlowLayout
extension CamerasCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width / 2 - 24, height: UIScreen.main.bounds.width / 1.2)
    }
}
