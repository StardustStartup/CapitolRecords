//
//  SDLAirbagStatusSpec.m
//  SmartDeviceLink


#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLAirbagStatus.h"
#import "SDLRPCParameterNames.h"
#import "SDLVehicleDataEventStatus.h"


QuickSpecBegin(SDLAirbagStatusSpec)

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLAirbagStatus* testStruct = [[SDLAirbagStatus alloc] init];
        
        testStruct.driverAirbagDeployed = SDLVehicleDataEventStatusYes;
        testStruct.driverSideAirbagDeployed = SDLVehicleDataEventStatusNoEvent;
        testStruct.driverCurtainAirbagDeployed = SDLVehicleDataEventStatusNo;
        testStruct.passengerAirbagDeployed = SDLVehicleDataEventStatusNotSupported;
        testStruct.passengerCurtainAirbagDeployed = SDLVehicleDataEventStatusFault;
        testStruct.driverKneeAirbagDeployed = SDLVehicleDataEventStatusNo;
        testStruct.passengerSideAirbagDeployed = SDLVehicleDataEventStatusYes;
        testStruct.passengerKneeAirbagDeployed = SDLVehicleDataEventStatusNoEvent;
        
        expect(testStruct.driverAirbagDeployed).to(equal(SDLVehicleDataEventStatusYes));
        expect(testStruct.driverSideAirbagDeployed).to(equal(SDLVehicleDataEventStatusNoEvent));
        expect(testStruct.driverCurtainAirbagDeployed).to(equal(SDLVehicleDataEventStatusNo));
        expect(testStruct.passengerAirbagDeployed).to(equal(SDLVehicleDataEventStatusNotSupported));
        expect(testStruct.passengerCurtainAirbagDeployed).to(equal(SDLVehicleDataEventStatusFault));
        expect(testStruct.driverKneeAirbagDeployed).to(equal(SDLVehicleDataEventStatusNo));
        expect(testStruct.passengerSideAirbagDeployed).to(equal(SDLVehicleDataEventStatusYes));
        expect(testStruct.passengerKneeAirbagDeployed).to(equal(SDLVehicleDataEventStatusNoEvent));
    });
    
    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary* dict = [@{SDLRPCParameterNameDriverAirbagDeployed:SDLVehicleDataEventStatusYes,
                                       SDLRPCParameterNameDriverSideAirbagDeployed:SDLVehicleDataEventStatusNoEvent,
                                       SDLRPCParameterNameDriverCurtainAirbagDeployed:SDLVehicleDataEventStatusNo,
                                       SDLRPCParameterNamePassengerAirbagDeployed:SDLVehicleDataEventStatusNotSupported,
                                       SDLRPCParameterNamePassengerCurtainAirbagDeployed:SDLVehicleDataEventStatusFault,
                                       SDLRPCParameterNameDriverKneeAirbagDeployed:SDLVehicleDataEventStatusNo,
                                       SDLRPCParameterNamePassengerSideAirbagDeployed:SDLVehicleDataEventStatusYes,
                                       SDLRPCParameterNamePassengerKneeAirbagDeployed:SDLVehicleDataEventStatusNoEvent} mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLAirbagStatus* testStruct = [[SDLAirbagStatus alloc] initWithDictionary:dict];
#pragma clang diagnostic pop
        
        expect(testStruct.driverAirbagDeployed).to(equal(SDLVehicleDataEventStatusYes));
        expect(testStruct.driverSideAirbagDeployed).to(equal(SDLVehicleDataEventStatusNoEvent));
        expect(testStruct.driverCurtainAirbagDeployed).to(equal(SDLVehicleDataEventStatusNo));
        expect(testStruct.passengerAirbagDeployed).to(equal(SDLVehicleDataEventStatusNotSupported));
        expect(testStruct.passengerCurtainAirbagDeployed).to(equal(SDLVehicleDataEventStatusFault));
        expect(testStruct.driverKneeAirbagDeployed).to(equal(SDLVehicleDataEventStatusNo));
        expect(testStruct.passengerSideAirbagDeployed).to(equal(SDLVehicleDataEventStatusYes));
        expect(testStruct.passengerKneeAirbagDeployed).to(equal(SDLVehicleDataEventStatusNoEvent));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLAirbagStatus* testStruct = [[SDLAirbagStatus alloc] init];
        
        expect(testStruct.driverAirbagDeployed).to(beNil());
        expect(testStruct.driverSideAirbagDeployed).to(beNil());
        expect(testStruct.driverCurtainAirbagDeployed).to(beNil());
        expect(testStruct.passengerAirbagDeployed).to(beNil());
        expect(testStruct.passengerCurtainAirbagDeployed).to(beNil());
        expect(testStruct.driverKneeAirbagDeployed).to(beNil());
        expect(testStruct.passengerSideAirbagDeployed).to(beNil());
        expect(testStruct.passengerKneeAirbagDeployed).to(beNil());
    });
});

QuickSpecEnd
