//
//  DetailsViewController.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 10/23/23.
//

import UIKit

final class DetailsViewController: UIViewController {

    var photo: Photo!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoLabel: UITextView!
    @IBOutlet weak var cameraLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupDetailsVC() {
    }
}


extension DetailsViewController: Storyboarded {}
