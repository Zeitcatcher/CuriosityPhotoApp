//
//  PhotoCollectionViewCell.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 9/21/23.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    private var imageURL: URL? {
        didSet {
            cameraImageView.image = nil
            updateImage()
        }
    }
    
    @IBOutlet weak var cameraImageView: UIImageView!
    @IBOutlet weak var cameraLabel: UILabel!
    
    func configue(with photo: Photo) {
        self.backgroundColor = .green
        cameraLabel.text = photo.camera.cameraName
        imageURL = URL(string: photo.imageURL)
        cameraImageView.layer.cornerRadius = 20
    }
}

//MARK: - Private methods
extension PhotoCollectionViewCell {
    private func updateImage() {
        guard let imageURL = imageURL else { return }
        getImage(from: imageURL) { [weak self ] result in
            switch result {
            case .success(let image):
                self?.cameraImageView.image = image
            case .failure(let error):
                print(error)
            }
        }
    }
    
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
}
