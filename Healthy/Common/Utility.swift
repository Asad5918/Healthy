//
//  Utility.swift
//  Healthy
//
//  Created by Md Asadullah on 23/11/23.
//

import Foundation
import UIKit

class Utility {
    
    // Function to show the loader
    class func showLoader(onView : UIView? = nil) {
        LoaderView.shared.showLoader(view: onView)
    }
    
    // Function to hide the loader
    class func hideLoader() {
        LoaderView.shared.hide()
    }
}
