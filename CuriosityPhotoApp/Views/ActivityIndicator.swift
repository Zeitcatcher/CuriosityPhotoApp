//
//  ActivityIndicator.swift
//  CuriosityPhotoApp
//
//  Created by Arseniy Oksenoyt on 10/14/23.
//

import UIKit

final class ActivityIndicator {
    
    private var activityIndicator: UIActivityIndicatorView?
    
    func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }
}
