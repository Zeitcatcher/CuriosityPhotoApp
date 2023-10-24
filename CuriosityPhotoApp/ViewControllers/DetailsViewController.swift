//
//  DetailsViewController.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 10/23/23.
//

import UIKit

class DetailsViewController: UIViewController {

    var image: Photo!
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoLabel: UITextView!
    @IBOutlet weak var cameraLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DetailsViewController: Storyboarded {}
