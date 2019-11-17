//
//  Constants.swift
//  SmartDeviceLink
//
//  Created by Tine Purg on 29/10/2019.
//  Copyright © 2019 smartdevicelink. All rights reserved.
//

import Foundation


// MARK: - SDL Configuration
struct SDLCOnfig {
    static let ExampleAppName = "Connected Travel";
    static let ExampleAppNameShort = "CT";
    static let ExampleAppNameTTS = "IS THIS WORKING";
    static let ExampleFullAppId = "791253d3-6209-4158-b6d6-6a5d66b82e9e"; // Dummy App Id
}
// MARK:- SDL Textfields
struct SDLTextfields{
    static let SmartDeviceLinkText = "SmartDeviceLink (SDL)";
    static let ExampleAppText = "Connected Travel";
}

// MARK: - SDL Soft Buttons
struct SDLToggleSoftButtons{
    static let ToggleSoftButton = "ToggleSoftButton";
    static let ToggleSoftButtonImageOnState = "ToggleSoftButtonImageOnState";
    static let ToggleSoftButtonImageOffState = "ToggleSoftButtonImageOffState";
    static let ToggleSoftButtonTextOnState = "ToggleSoftButtonTextOnState";
    static let ToggleSoftButtonTextOffState = "ToggleSoftButtonTextOffState";
    static let ToggleSoftButtonTextTextOnText = "➖";
    static let ToggleSoftButtonTextTextOffText = "➕";
}

struct AlertSoftButton {
    static let AlertSoftButton = "AlertSoftButton";
    static let AlertSoftButtonImageState = "AlertSoftButtonImageState";
    static let AlertSoftButtonTextState = "AlertSoftButtonTextState";
    static let AlertSoftButtonText = "Tap Me";
}
struct TextVisable {
    static let TextVisibleSoftButton = "TextVisibleSoftButton";
    static let TextVisibleSoftButtonTextOnState = "TextVisibleSoftButtonTextOnState";
    static let TextVisibleSoftButtonTextOffState = "TextVisibleSoftButtonTextOffState";
    static let TextVisibleSoftButtonTextOnText = "➖Text";
    static let TextVisibleSoftButtonTextOffText = "➕Text";
}
struct ImagesVisable{
    static let ImagesVisibleSoftButton = "ImagesVisibleSoftButton";
    static let ImagesVisibleSoftButtonImageOnState = "ImagesVisibleSoftButtonImageOnState";
    static let ImagesVisibleSoftButtonImageOffState = "ImagesVisibleSoftButtonImageOffState";
    static let ImagesVisibleSoftButtonImageOnText = "➖Icons";
    static let ImagesVisibleSoftButtonImageOffText = "➕Icons";
    
}

// MARK: - SDL Text-To-Speech
struct SDLTTS {
    static let TTSGoodJob = "Good Job";
    static let TTSYouMissed = "You Missed";
}

// MARK: - SDL Voice Commands
struct SDLVC {
    static let VCStart = "Start";
    static let VCStop = "Stop";
}

// MARK: - SDL Perform Interaction Choice Set Menu
struct SDLPRICSM{
    static let PICSInitialText = "Perform Interaction Choice Set Menu Example";
    static let PICSInitialPrompt = "Select an item from the menu";
    static let PICSHelpPrompt = "Select a menu row using your voice or by tapping on the screen";
    static let PICSTimeoutPrompt = "Closing the menu";
    static let PICSFirstChoice = "First Choice";
    static let PICSSecondChoice = "Second Choice";
    static let PICSThirdChoice = "Third Choice";
}

// MARK: - SDL Add Command Menu
struct SDLACM{
    static let ACSpeakAppNameMenuName = "Speak App Name";
    static let ACShowChoiceSetMenuName = "Show Perform Interaction Choice Set";
    static let ACGetVehicleDataMenuName = "Get Vehicle Speed";
    static let ACGetAllVehicleDataMenuName = "Get All Vehicle Data";
    static let ACRecordInCarMicrophoneAudioMenuName = "Record In-Car Microphone Audio";
    static let ACDialPhoneNumberMenuName = "Dial Phone Number";
    static let ACSubmenuMenuName = "Submenu";
    static let ACSubmenuItemMenuName = "Item";
    static let ACSubmenuTemplateMenuName = "Change Template";
}

struct  Other {
    static let ACAccelerationPedalPositionMenuName = "Acceleration Pedal Position";
    static let ACAirbagStatusMenuName = "Airbag Status";
    static let ACBeltStatusMenuName = "Belt Status";
    static let ACBodyInformationMenuName = "Body Information";
    static let ACClusterModeStatusMenuName = "Cluster Mode Status";
    static let ACDeviceStatusMenuName = "Device Status";
    static let ACDriverBrakingMenuName = "Driver Braking";
    static let ACECallInfoMenuName = "eCall Info";
    static let ACElectronicParkBrakeStatus = "Electronic Parking Brake Status";
    static let ACEmergencyEventMenuName = "Emergency Event";
    static let ACEngineOilLifeMenuName = "Engine Oil Life";
    static let ACEngineTorqueMenuName = "Engine Torque";
    static let ACExternalTemperatureMenuName = "External Temperature";
    static let ACFuelLevelMenuName = "Fuel Level";
    static let ACFuelLevelStateMenuName = "Fuel Level State";
    static let ACFuelRangeMenuName = "Fuel Range";
    static let ACGPSMenuName = "GPS";
    static let ACHeadLampStatusMenuName = "Head Lamp Status";
    static let ACInstantFuelConsumptionMenuName = "Instant Fuel Consumption";
    static let ACMyKeyMenuName = "MyKey";
    static let ACOdometerMenuName = "Odometer";
    static let ACPRNDLMenuName = "PRNDL";
    static let ACRPMMenuName = "RPM";
    static let ACSpeedMenuName = "Speed";
    static let ACSteeringWheelAngleMenuName = "Steering Wheel Angle";
    static let ACTirePressureMenuName = "Tire Pressure";
    static let ACTurnSignalMenuName = "Turn Signal";
    static let ACVINMenuName = "VIN";
    static let ACWiperStatusMenuName = "Wiper Status";
}

// MARK: - SDL Image Names
struct SDLImageNames {
    static let AlertBWIconName = "alert";
    static let CarBWIconImageName = "car";
    static let ExampleAppLogoName = "CT_Logo";
    static let MenuBWIconImageName = "choice_set";
    static let MicrophoneBWIconImageName = "microphone";
    static let PhoneBWIconImageName = "phone";
    static let SpeakBWIconImageName = "speak";
    static let ToggleOffBWIconName = "toggle_off";
    static let ToggleOnBWIconName = "toggle_on";
}

// MARK: - SDL App Name in Different Languages
struct SDLANiDL{
    static let ExampleAppNameSpanish = "SDL Aplicación de ejemplo";
    static let ExampleAppNameFrench = "SDL Exemple App";
}

// MARK: - SDL Vehicle Data
struct SDLVehicleData {
    static let VehicleDataOdometerName = "Odometer";
    static let VehicleDataSpeedName = "Speed";
}

