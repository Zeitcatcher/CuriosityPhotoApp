//
//  DetailsViewController.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 10/23/23.
//

import UIKit

final class DetailsViewController: UIViewController {

    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var photoLabel: UITextView!
    @IBOutlet private weak var cameraLabel: UITextView!
    @IBOutlet private weak var backgroundView: UIView!
    
    private var imageURL: URL?
    
    var photo: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageURL = URL(string: photo.imageURL)
//        updateImage()
        setupDetailsVC()
    }
    
    // MARK: - Private Methods
    private func setupDetailsVC() {
        updateImage()
        backgroundView.layer.cornerRadius = 20
        photoLabel.layer.cornerRadius = 20
        photoLabel.text = photo.rover.name
        cameraLabel.layer.cornerRadius = 20
        cameraLabel.text = photo.camera.cameraFullName
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
    
    private func getImage(from url: URL, complition: @escaping(Result<UIImage, Error>) -> Void) {
        if let cacheImage = ImageCacheManager.shared.object(forKey: url.lastPathComponent as NSString) {
            complition(.success(cacheImage))
            return
        }
    }
}

// MARK: - Storyboarded
extension DetailsViewController: Storyboarded {}

