//
//  ButtonManager.swift
//  SmartDeviceLink
//
//  Created by Nicole on 4/11/18.
//  Copyright © 2018 smartdevicelink. All rights reserved.
//

import Foundation
import SmartDeviceLink

typealias RefreshUIHandler = (() -> Void)

class ButtonManager: NSObject {
    fileprivate let sdlManager: SDLManager!
    fileprivate var refreshUIHandler: RefreshUIHandler?
    
    /// SDL UI textfields are visible if true; hidden if false
    public fileprivate(set) var textEnabled: Bool {
        didSet {
            guard let refreshUIHandler = refreshUIHandler else { return }
            refreshUIHandler()
        }
    }
    
    /// SDL UI images are visible if true; hidden if false
    public fileprivate(set) var imagesEnabled: Bool {
        didSet {
            guard let refreshUIHandler = refreshUIHandler, let alertSoftButton = sdlManager.screenManager.softButtonObjectNamed(AlertSoftButton.AlertSoftButton) else { return }
            alertSoftButton.transitionToNextState()
            refreshUIHandler()
        }
    }
    
    /// Keeps track of the toggle soft button current state. The image or text changes when the button is selected
    fileprivate var toggleEnabled: Bool {
        didSet {
            guard let hexagonSoftButton = sdlManager.screenManager.softButtonObjectNamed(SDLToggleSoftButtons.ToggleSoftButton), hexagonSoftButton.transition(toState: toggleEnabled ? SDLToggleSoftButtons.ToggleSoftButtonImageOnState : SDLToggleSoftButtons.ToggleSoftButtonImageOffState) else { return }
        }
    }
    
    init(sdlManager: SDLManager, updateScreenHandler: RefreshUIHandler? = nil) {
        self.sdlManager = sdlManager
        self.refreshUIHandler = updateScreenHandler
        textEnabled = true
        imagesEnabled = true
        toggleEnabled = true
        super.init()

        NotificationCenter.default.addObserver(forName: Notification.Name("FindParkingsVoice"), object: nil, queue: .main) { [unowned self] notification in
            self.makeParkingRequest()
        }

        NotificationCenter.default.addObserver(forName: Notification.Name("FindEventsVoice"), object: nil, queue: .main) { [unowned self] notification in
            self.makeEventsRequest()
        }
    }
    
    /// Creates and returns an array of all soft buttons for the UI
    ///
    /// - Parameter manager: The SDL Manager
    /// - Returns: An array of all soft buttons for the UI
    func allScreenSoftButtons(with manager: SDLManager) -> [SDLSoftButtonObject] {
        return [softButtonParkings(with: manager), softButtonEvents(with: manager)]
    }
}

// MARK: - Custom Soft Buttons
private extension ButtonManager {
    /// Returns a soft button that shows parking when tapped.
    ///
    /// - Parameter manager: The SDL Manager for showing the alert
    /// - Returns: A soft button
    func softButtonParkings(with manager: SDLManager) -> SDLSoftButtonObject {
        let textSoftButtonState = SDLSoftButtonState(stateName: AlertSoftButton.AlertSoftButtonImageState, text: "Find Parking", image:nil)
        
        return SDLSoftButtonObject(name: "Parking Button", states: [textSoftButtonState], initialStateName: textSoftButtonState.name) { [unowned self] (buttonPress, buttonEvent) in
            guard buttonPress != nil else { return }

            self.makeParkingRequest()
        }
    }

    private func makeParkingRequest() {
        let alert = SDLAlert(alertText: "Loading...", softButtons: nil, playTone: false, ttsChunks: nil, alertIcon: nil, cancelID: 11)
        alert.progressIndicator = true as NSNumber
        sdlManager.send(request: alert, responseHandler: nil)

        APIManager.getParkings{ [unowned self] (result) in
            self.sdlManager.send(request: SDLCancelInteraction(alertCancelID: 11), responseHandler: nil)

            switch result {
            case .success(let parkings):

                let titles = Set(parkings.map({ "\($0.name), \($0.usd)$" }))
                let cells = titles.prefix(10).map({ SDLChoiceCell(text: $0) })
                let choiceSet = SDLChoiceSet(title: "Parkings", delegate: self, choices: cells)
                choiceSet.timeout = 60
                self.sdlManager.screenManager.present(choiceSet, mode: .manualOnly)

            case .failure(let error):
                let alert = AlertManager.alertWithMessageAndCloseButton(error.localizedDescription)
                self.sdlManager.send(alert)
            }
        }
    }
    
    /// Returns a soft button that shows events when tapped.
    ///
    /// - Parameter manager: The SDL Manager for showing the alert
    /// - Returns: A soft button
    func softButtonEvents(with manager: SDLManager) -> SDLSoftButtonObject {
        let textSoftButtonState = SDLSoftButtonState(stateName: AlertSoftButton.AlertSoftButtonImageState, text: "Find Events", image:nil)
        
        return SDLSoftButtonObject(name: "Events Button", states: [textSoftButtonState], initialStateName: textSoftButtonState.name) { [unowned self] (buttonPress, buttonEvent) in
            guard buttonPress != nil else { return }
            self.makeEventsRequest()
        }
    }

    private func makeEventsRequest() {
        let alert = SDLAlert(alertText: "Loading...", softButtons: nil, playTone: false, ttsChunks: nil, alertIcon: nil, cancelID: 10)
        alert.progressIndicator = true as NSNumber
        sdlManager.send(request: alert, responseHandler: nil)

        APIManager.getEvents { [unowned self] (result) in
            self.sdlManager.send(request: SDLCancelInteraction(alertCancelID: 10), responseHandler: nil)

            switch result {
            case .success(let events):
                let titles = Set(events.items.map({ $0.name }))
                let cells = titles.prefix(10).map({ SDLChoiceCell(text: $0) })
                let choiceSet = SDLChoiceSet(title: "Events", delegate: self, choices: cells)
                choiceSet.timeout = 60
                self.sdlManager.screenManager.present(choiceSet, mode: .manualOnly)

            case .failure(let error):
                let alert = AlertManager.alertWithMessageAndCloseButton(error.localizedDescription)
                self.sdlManager.send(alert)
            }
        }
    }
}

extension ButtonManager: SDLChoiceSetDelegate {
    func choiceSet(_ choiceSet: SDLChoiceSet, didSelectChoice choice: SDLChoiceCell, withSource source: SDLTriggerSource, atRowIndex rowIndex: UInt) {
              
        let alert = AlertManager.alertWithSoftButtons("Proceed to payment?")
        sdlManager.send(alert)
                      
    }
    
    func choiceSet(_ choiceSet: SDLChoiceSet, didReceiveError error: Error) {
        // TODO
    }
}






