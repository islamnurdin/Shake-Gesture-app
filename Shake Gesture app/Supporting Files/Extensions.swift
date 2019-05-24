//
//  Extensions.swift
//  Shake Gesture app
//
//  Created by Name on 5/24/19.
//  Copyright © 2019 Name. All rights reserved.
//

import UIKit

extension UIViewController {
    /**
     Shows error in case the request fails
     
     ### Usage Example: ###
     
     ```
     error(showErrorAlert)
     ```
     */
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
