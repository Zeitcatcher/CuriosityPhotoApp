//
//  PhotosCollectionViewCell.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 10/5/23.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    private var imageURL: URL? {
        didSet {
            photoImageView.image = nil
            updateImage()
        }
    }
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoLabel: UILabel!
    
    func config(with photo: Photo) {
        photoLabel.text = photo.camera.cameraName
        imageURL = URL(string: photo.imageURL)
        photoImageView.layer.cornerRadius = 20
    }
}

//MARK: - Private Methods
extension PhotosCollectionViewCell {
    
    private func getImage(from url: URL, complition: @escaping(Result<UIImage, Error>) -> Void) {
        NetworkManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let imageData):
                guard let uiImage = UIImage(data: imageData) else { return }
                print("Image from network: ", url.lastPathComponent)
                complition(.success(uiImage))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateImage() {
        guard let imageURL = imageURL else { return }
        getImage(from: imageURL) { [ weak self ] result in
            switch result {
            case .success(let image):
                self?.photoImageView.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
}
