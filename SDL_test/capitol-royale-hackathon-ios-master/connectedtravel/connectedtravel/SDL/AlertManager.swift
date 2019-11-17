//
//  AlertManager.swift
//  SmartDeviceLink-Example-Swift
//
//  Created by Nicole on 4/12/18.
//  Copyright © 2018 smartdevicelink. All rights reserved.
//

import Foundation
import SmartDeviceLink

class AlertManager {
    private class var okSoftButton: SDLSoftButton {
        return SDLSoftButton(type: .text, text: "OK", image: nil, highlighted: true, buttonId: 1, systemAction: nil, handler: nil)
    }
    
    /// Creates an alert with one or two lines of text.
    ///
    /// - Parameters:
    ///   - textField1: The first line of a message to display in the alert
    ///   - textField2: The second line of a message to display in the alert
    /// - Returns: An SDLAlert object
    class func alertWithMessage(_ textField1: String, textField2: String? = nil) -> SDLAlert {
        return SDLAlert(alertText1: textField1, alertText2: nil, alertText3: nil)
    }
    
    /// Creates an alert with up to two lines of text and a close button that will dismiss the alert when tapped
    ///
    /// - Parameters:
    ///   - textField1: The first line of a message to display in the alert
    ///   - textField2: The second line of a message to display in the alert
    /// - Returns: An SDLAlert object
    class func alertWithMessageAndCloseButton(_ textField1: String, textField2: String? = nil) -> SDLAlert {
        return SDLAlert(alertText1: textField1, alertText2: textField2, alertText3: nil, duration: 5000, softButtons: [AlertManager.okSoftButton])
    }
    
    
    
    class func alertWithSoftButtons(_ textField1: String, textField2: String? = nil,textField3: String? = nil) -> SDLAlert {
        
        let yesButton = SDLSoftButton(type: .text, text: "Confirm", image: nil, highlighted: false, buttonId: 2, systemAction: .defaultAction, handler: { buttonPress, buttonEvent in
            guard buttonPress != nil else { return }
                        
        })

        let noButton = SDLSoftButton(type: .text, text: "Cancel", image: nil, highlighted: false, buttonId: 3, systemAction: .defaultAction, handler: { buttonPress, buttonEvent in
            guard buttonPress != nil else { return }
        })
        
      
        return   SDLAlert(alertText: textField1, softButtons: [yesButton,noButton], playTone: .random(), ttsChunks: .none, alertIcon: .none, cancelID: .max)
        
    }
    
    
}
