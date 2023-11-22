//
//  LoaderView.swift
//  Healthy
//
//  Created by Md Asadullah on 23/11/23.
//

import UIKit

public class LoaderView {

var mainView = UIView()
var overlayView = UIView()
var blurView = UIVisualEffectView()
var viewToPresentOn: UIView? = nil
var activityIndicator = UIActivityIndicatorView()

class var shared: LoaderView {
    struct Static {
        static let instance: LoaderView = LoaderView()
    }
    return Static.instance
}

    public func showLoader(view: UIView?) {
        
        if view == nil {
            self.mainView = UIApplication.shared.windows.first!
        }else{
            self.mainView = view!
        }
        
        self.overlayView.frame = self.mainView.frame
        self.blurView.frame = self.mainView.frame
        self.overlayView.addSubview(self.blurView)
        self.overlayView.center = self.mainView.center
        self.overlayView.backgroundColor = UIColor(white: 0.8, alpha: 0.36)
        self.overlayView.clipsToBounds = true
        self.overlayView.layer.cornerRadius = 10

        self.activityIndicator.style = .medium
        self.activityIndicator.color = .blue
        self.activityIndicator.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.activityIndicator.center = CGPoint(x: (self.overlayView.bounds.width / 2), y: (self.overlayView.bounds.height / 2))
        self.overlayView.addSubview(self.activityIndicator)
        self.mainView.addSubview(self.overlayView)
        self.activityIndicator.startAnimating()
        
        setupContainerView()
    }

    public func hide() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.overlayView.removeFromSuperview()
        }
    }
    
    func setupContainerView() {
        self.overlayView.translatesAutoresizingMaskIntoConstraints = false
        let constainView = [
            self.overlayView.topAnchor.constraint(equalTo: self.mainView.topAnchor),
            self.overlayView.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor),
            self.overlayView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor),
            self.overlayView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constainView)
        
        
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        let constainAI = [
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.overlayView.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.overlayView.centerYAnchor),
        ]
        NSLayoutConstraint.activate(constainAI)

    }

}
