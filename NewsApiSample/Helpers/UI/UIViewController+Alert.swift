//
//  UIViewController+Alert.swift
//  NewsApiSample
//
//  Created by Vitaliy Kuznetsov on 21/07/2018.
//  Copyright © 2018 vitaliikuznetsov. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func simpleAlert(_ alert: String, message: String){
        
        let alert = UIAlertController.init(title: alert,
                                           message: message,
                                           preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction.init(title: String.ActionClose,
                                           style: UIAlertActionStyle.default,
                                           handler: { (alertAction) in
                                            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - Localization
extension String {
    static let ActionClose = NSLocalizedString("UIViewController+Alert: ActionClose", comment: "")
}







