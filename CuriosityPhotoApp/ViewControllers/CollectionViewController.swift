//
//  ViewController.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 9/17/23.
//

import UIKit

class CollectionViewController: UIViewController {
    var photo: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: - Private Methods
extension CollectionViewController {
    private func fetchPhoto() {
        NetworkManager.shared.fetch(Photo.self, from: Photo.URL.nasa.rawValue) { [ weak self ] result in
            switch result {
            case .success(let photo):
                self?.photo = photo
                //дописать обновления item
            case .failure(let error):
                print(error)
            }
        }
    }
}
