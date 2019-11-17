//
//  MenuManager.swift
//  SmartDeviceLink-Example-Swift
//
//  Created by Nicole on 4/11/18.
//  Copyright © 2018 smartdevicelink. All rights reserved.
//

import Foundation
import SmartDeviceLink

class MenuManager: NSObject {
    /// Creates and returns the menu items
    ///
    /// - Parameter manager: The SDL Manager
    /// - Returns: An array of SDLAddCommand objects
    class func allMenuItems(with manager: SDLManager, choiceSetManager: PerformInteractionManager) -> [SDLMenuCell] {
        return [menuCellSpeakName(with: manager),
                menuCellGetAllVehicleData(with: manager),
                menuCellShowPerformInteraction(with: manager, choiceSetManager: choiceSetManager),
                menuCellRecordInCarMicrophoneAudio(with: manager),
                menuCellDialNumber(with: manager),
                menuCellChangeTemplate(with: manager),
                menuCellWithSubmenu(with: manager)]
    }

    /// Creates and returns the voice commands. The voice commands are menu items that are selected using the voice recognition system.
    ///
    /// - Parameter manager: The SDL Manager
    /// - Returns: An array of SDLVoiceCommand objects
    class func allVoiceMenuItems(with manager: SDLManager) -> [SDLVoiceCommand] {
        guard manager.systemCapabilityManager.vrCapability else {
            print("The head unit does not support voice recognition")
            return []
        }

        return [
            SDLVoiceCommand(voiceCommands: ["Find parkings"]) {
                NotificationCenter.default.post(name: Notification.Name("FindParkingsVoice"), object: nil)
            },
            SDLVoiceCommand(voiceCommands: ["Find events"]) {
                NotificationCenter.default.post(name: Notification.Name("FindEventsVoice"), object: nil)
            }
        ]
    }
}

// MARK: - Root Menu

private extension MenuManager {
    /// Menu item that speaks the app name when selected
    ///
    /// - Parameter manager: The SDL Manager
    /// - Returns: A SDLMenuCell object
    class func menuCellSpeakName(with manager: SDLManager) -> SDLMenuCell {
        return SDLMenuCell(title: SDLACM.ACSpeakAppNameMenuName, icon: SDLArtwork(image: UIImage(named: SDLImageNames.SpeakBWIconImageName)!.withRenderingMode(.alwaysTemplate), persistent: true, as: .PNG), voiceCommands: [SDLACM.ACSpeakAppNameMenuName], handler: { _ in
            manager.send(request: SDLSpeak(tts:SDLCOnfig.ExampleAppNameTTS), responseHandler: { (_, response, error) in
                guard response?.resultCode == .success else { return }
                print("Error sending the Speak RPC: \(error?.localizedDescription ?? "no error message")")
            })
        })
    }

    /// Menu item that, when selected, shows a submenu with all possible vehicle data types
    ///
    /// - Parameter manager: The SDL Manager
    /// - Returns: A SDLMenuCell object
    class func menuCellGetAllVehicleData(with manager: SDLManager) -> SDLMenuCell {
        let submenuItems = allVehicleDataTypes.map { submenuName in
            SDLMenuCell(title: submenuName, icon: nil, voiceCommands: nil, handler: { triggerSource in
                VehicleDataManager.getAllVehicleData(with: manager, triggerSource: triggerSource, vehicleDataType: submenuName)
            })
        }
        
        return SDLMenuCell(title: SDLACM.ACGetAllVehicleDataMenuName, icon: SDLArtwork(image: UIImage(named: SDLImageNames.CarBWIconImageName)!.withRenderingMode(.alwaysTemplate), persistent: true, as: .PNG), subCells: submenuItems)
    }

    /// A list of all possible vehicle data types
    static var allVehicleDataTypes: [String] {
        return [Other.ACAccelerationPedalPositionMenuName, Other.ACAirbagStatusMenuName, Other.ACBeltStatusMenuName, Other.ACBodyInformationMenuName, Other.ACClusterModeStatusMenuName, Other.ACDeviceStatusMenuName, Other.ACDriverBrakingMenuName, Other.ACECallInfoMenuName, Other.ACElectronicParkBrakeStatus, Other.ACEmergencyEventMenuName, Other.ACEngineOilLifeMenuName, Other.ACEngineTorqueMenuName, Other.ACExternalTemperatureMenuName, Other.ACFuelLevelMenuName, Other.ACFuelLevelStateMenuName, Other.ACFuelRangeMenuName, Other.ACGPSMenuName, Other.ACHeadLampStatusMenuName, Other.ACInstantFuelConsumptionMenuName, Other.ACMyKeyMenuName, Other.ACOdometerMenuName, Other.ACPRNDLMenuName, Other.ACRPMMenuName, Other.ACSpeedMenuName, Other.ACSteeringWheelAngleMenuName, Other.ACTirePressureMenuName, Other.ACTurnSignalMenuName, Other.ACVINMenuName, Other.ACWiperStatusMenuName]
    }

    /// Menu item that shows a custom menu (i.e. a Perform Interaction Choice Set) when selected
    ///
    /// - Parameter manager: The SDL Manager
    /// - Returns: A SDLMenuCell object
    class func menuCellShowPerformInteraction(with manager: SDLManager, choiceSetManager: PerformInteractionManager) -> SDLMenuCell {
        return SDLMenuCell(title: SDLACM.ACShowChoiceSetMenuName, icon: SDLArtwork(image: UIImage(named: SDLImageNames.MenuBWIconImageName)!.withRenderingMode(.alwaysTemplate), persistent: true, as: .PNG), voiceCommands: [SDLACM.ACShowChoiceSetMenuName], handler: { triggerSource in
            choiceSetManager.show(from: triggerSource)
        })
    }

    /// Menu item that starts recording sounds via the in-car microphone when selected
    ///
    /// - Parameter manager: The SDL Manager
    /// - Returns: A SDLMenuCell object
    class func menuCellRecordInCarMicrophoneAudio(with manager: SDLManager) -> SDLMenuCell {
        if #available(iOS 10.0, *) {
            let audioManager = AudioManager(sdlManager: manager)
            return SDLMenuCell(title: SDLACM.ACRecordInCarMicrophoneAudioMenuName, icon: SDLArtwork(image: UIImage(named: SDLImageNames.MicrophoneBWIconImageName)!.withRenderingMode(.alwaysTemplate), persistent: true, as: .PNG), voiceCommands: [SDLACM.ACRecordInCarMicrophoneAudioMenuName], handler: { _ in
                audioManager.startRecording()
            })
        }

        return SDLMenuCell(title: SDLACM.ACRecordInCarMicrophoneAudioMenuName, icon: SDLArtwork(image: UIImage(named: SDLImageNames.SpeakBWIconImageName)!.withRenderingMode(.alwaysTemplate), persistent: true, as: .PNG), voiceCommands: [SDLACM.ACRecordInCarMicrophoneAudioMenuName], handler: { _ in
            manager.send(AlertManager.alertWithMessageAndCloseButton("Speech recognition feature only available on iOS 10+"))
        })
    }

    /// Menu item that dials a phone number when selected
    ///
    /// - Parameter manager: The SDL Manager
    /// - Returns: A SDLMenuCell object
    class func menuCellDialNumber(with manager: SDLManager) -> SDLMenuCell {
        return SDLMenuCell(title: SDLACM.ACDialPhoneNumberMenuName, icon: SDLArtwork(image: UIImage(named: SDLImageNames.PhoneBWIconImageName)!.withRenderingMode(.alwaysTemplate), persistent: true, as: .PNG), voiceCommands: [SDLACM.ACDialPhoneNumberMenuName], handler: { _ in
            guard RPCPermissionsManager.isDialNumberRPCAllowed(with: manager) else {
                manager.send(AlertManager.alertWithMessageAndCloseButton("This app does not have the required permissions to dial a number"))
                return
            }

            VehicleDataManager.checkPhoneCallCapability(manager: manager, phoneNumber:"555-555-5555")
        })
    }
    
    /// Menu item that changes the default template
    ///
    /// - Parameter manager: The SDL Manager
    /// - Returns: A SDLMenuCell object
    class func menuCellChangeTemplate(with manager: SDLManager) -> SDLMenuCell {
    
        /// Lets give an example of 2 templates
        var submenuItems = [SDLMenuCell]()
        let errorMessage = "Changing the template failed"
        
        /// Non-Media
        let submenuTitleNonMedia = "Non - Media (Default)"
        submenuItems.append(SDLMenuCell(title: submenuTitleNonMedia, icon: nil, voiceCommands: nil, handler: { (triggerSource) in
            let display = SDLSetDisplayLayout(predefinedLayout: .nonMedia)
            manager.send(request: display) { (request, response, error) in
                guard response?.resultCode == .success else {
                    manager.send(AlertManager.alertWithMessageAndCloseButton(errorMessage))
                    return
                }
            }
        }))
        
        /// Graphic with Text
        let submenuTitleGraphicText = "Graphic With Text"
        submenuItems.append(SDLMenuCell(title: submenuTitleGraphicText, icon: nil, voiceCommands: nil, handler: { (triggerSource) in
            let display = SDLSetDisplayLayout(predefinedLayout: .graphicWithText)
            manager.send(request: display) { (request, response, error) in
                guard response?.resultCode == .success else {
                    manager.send(AlertManager.alertWithMessageAndCloseButton(errorMessage))
                    return
                }
            }
        }))
        
        return SDLMenuCell(title: SDLACM.ACSubmenuTemplateMenuName, icon: nil, subCells: submenuItems)
    }

    /// Menu item that opens a submenu when selected
    ///
    /// - Parameter manager: The SDL Manager
    /// - Returns: A SDLMenuCell object
    class func menuCellWithSubmenu(with manager: SDLManager) -> SDLMenuCell {
        var submenuItems = [SDLMenuCell]()
        for i in 0 ..< 10 {
            let submenuTitle = "Submenu Item \(i)"
            submenuItems.append(SDLMenuCell(title: submenuTitle, icon: SDLArtwork(image: UIImage(named: SDLImageNames.MenuBWIconImageName)!.withRenderingMode(.alwaysTemplate), persistent: true, as: .PNG), voiceCommands: nil, handler: { (triggerSource) in
                let message = "\(submenuTitle) selected!"
                switch triggerSource {
                case .menu:
                    manager.send(AlertManager.alertWithMessageAndCloseButton(message))
                case .voiceRecognition:
                    manager.send(SDLSpeak(tts: message))
                default: break
                }
            }))
        }
        
        return SDLMenuCell(title: SDLACM.ACSubmenuMenuName, icon: SDLArtwork(image: #imageLiteral(resourceName: "choice_set").withRenderingMode(.alwaysTemplate), persistent: true, as: .PNG), subCells: submenuItems)
    }
}
