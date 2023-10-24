//
//  PhotoCollectionViewCell.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 9/21/23.
//

import UIKit

final class CamerasCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var cameraImageView: UIImageView!
    @IBOutlet weak var cameraLabel: UILabel!
    
    private var imageURL: URL? {
        didSet {
            cameraImageView.image = nil
            updateImage()
        }
    }
    
    private var activityIndicator: UIActivityIndicatorView?
    
    func configue(with photo: Photo) {
        cameraLabel.text = photo.camera.cameraName
        imageURL = URL(string: photo.imageURL)
        cameraImageView.layer.cornerRadius = 20
        setupViews()
        activityIndicator = ActivityIndicator().showSpinner(in: cameraImageView)
        layoutActivityIndicator()
    }
}

//MARK: - Private methods
extension CamerasCollectionViewCell {
    private func getImage(from url: URL, complition: @escaping(Result<UIImage, Error>) -> Void) {
        if let cacheImage = ImageCacheManager.shared.object(forKey: url.lastPathComponent as NSString) {
            complition(.success(cacheImage))
            activityIndicator?.stopAnimating()
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
        getImage(from: imageURL) { [weak self ] result in
            switch result {
            case .success(let image):
                self?.cameraImageView.image = image
                self?.activityIndicator?.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupViews() {
        // Configure cameraImageView
        cameraImageView.contentMode = .scaleAspectFill
        cameraImageView.clipsToBounds = true
        
        // Configure cameraLabel
        cameraLabel.font = UIFont.systemFont(ofSize: 20)
        cameraLabel.textAlignment = .center
        cameraLabel.numberOfLines = 0 // Allow multiple lines
        
        // Add cameraImageView and cameraLabel to the cell's contentView
        contentView.addSubview(cameraImageView)
        contentView.addSubview(cameraLabel)
        
        // Define constraints
        cameraImageView.translatesAutoresizingMaskIntoConstraints = false
        cameraLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cameraImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cameraImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
            cameraImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cameraImageView.bottomAnchor.constraint(equalTo: cameraLabel.topAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            cameraLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
            cameraLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cameraLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func layoutActivityIndicator() {
        guard let activityIndicator = activityIndicator else { return }
        
        NSLayoutConstraint.activate([
                    activityIndicator.centerXAnchor.constraint(equalTo: cameraImageView.centerXAnchor),
                    activityIndicator.centerYAnchor.constraint(equalTo: cameraImageView.centerYAnchor)
        ])
    }
}
