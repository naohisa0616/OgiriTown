//
//  AlertDialogViewController.swift
//  OgiriTown
//
//  Created by 宮崎直久 on 2023/09/16.
//

import UIKit

class AlertDialogViewController: UIViewController {
    
    func displayAlert(alertTitle: String,
                            alertMessage: String,
                            buttonTitle: String) {
        let alert = UIAlertController(title: alertTitle,
                                      message: alertMessage,
                                      preferredStyle: .alert)
        
        let buttonTitle = UIAlertAction(title: buttonTitle,
                                        style: .default,
                                        handler: { (action) -> Void in
            print("\(buttonTitle) button tapped")
        })
        
        alert.addAction(buttonTitle)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayAlertTwoButton(alertTitle: String,
                            alertMessage: String,
                            rightButtonTitle: String,
                            leftButtonTitle: String) {
        let alert = UIAlertController(title: alertTitle,
                                      message: alertMessage,
                                      preferredStyle: .alert)
        
        let rightButton = UIAlertAction(title: rightButtonTitle,
                                        style: .default,
                                        handler: { (action) -> Void in
            print("\(rightButtonTitle) button tapped")
        })
        
        let leftButton = UIAlertAction(title: leftButtonTitle,
                                       style: .cancel,
                                       handler: { (action) -> Void in
            print("\(leftButtonTitle) button tapped")
        })
        
        alert.addAction(rightButton)
        alert.addAction(leftButton)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
