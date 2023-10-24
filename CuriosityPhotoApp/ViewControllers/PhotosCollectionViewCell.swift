//
//  PhotosCollectionViewCell.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 10/5/23.
//

import UIKit

final class PhotosCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet weak var photoLabel: UILabel!
    
    private var imageURL: URL? {
        didSet {
            photoImageView.image = nil
            updateImage()
        }
    }
    private var activityIndicator: UIActivityIndicatorView?
    
    func configure(with photo: Photo) {
        photoLabel.text = photo.camera.cameraName
        imageURL = URL(string: photo.imageURL)
        photoImageView.layer.cornerRadius = 20
        setupViews()
        activityIndicator = ActivityIndicator().showSpinner(in: photoImageView)
        layoutActivityIndicator()
    }
}

//MARK: - Private Methods
extension PhotosCollectionViewCell {
    private func getImage(from url: URL, complition: @escaping(Result<UIImage, Error>) -> Void) {
        if let cacheImage = ImageCacheManager.shared.object(forKey: url.lastPathComponent as NSString) {
            complition(.success(cacheImage))
            self.activityIndicator?.stopAnimating()
            return
        }
        
        NetworkManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let imageData):
                guard let uiImage = UIImage(data: imageData) else { return }
                ImageCacheManager.shared.setObject(uiImage, forKey: url.lastPathComponent as NSString)
                print("Image from network: ", url.lastPathComponent)
                complition(.success(uiImage))
                self.activityIndicator?.stopAnimating()
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
                self?.activityIndicator?.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupViews() {
        // Configure photoImageView
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
        
        // Configure photoLabel
        photoLabel.font = UIFont.systemFont(ofSize: 20)
        photoLabel.textAlignment = .center
        photoLabel.numberOfLines = 0
        
        // Add photoImageView and photoLabel to the cell's contentView
        contentView.addSubview(photoImageView)
        contentView.addSubview(photoLabel)
        
        // Define constraints
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            photoImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2.50),
            photoImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 4),
            photoImageView.bottomAnchor.constraint(equalTo: photoLabel.topAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
//            photoLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 8),
            photoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func layoutActivityIndicator() {
        guard let activityIndicator = activityIndicator else { return }
  
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor)
        ])
    }
}
