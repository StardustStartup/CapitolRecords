//
//  SDLECallInfoSpec.m
//  SmartDeviceLink


#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLVehicleDataNotificationStatus.h"
#import "SDLECallConfirmationStatus.h"
#import "SDLECallInfo.h"
#import "SDLRPCParameterNames.h"


QuickSpecBegin(SDLECallInfoSpec)

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLECallInfo* testStruct = [[SDLECallInfo alloc] init];
        
        testStruct.eCallNotificationStatus = SDLVehicleDataNotificationStatusNormal;
        testStruct.auxECallNotificationStatus = SDLVehicleDataNotificationStatusActive;
        testStruct.eCallConfirmationStatus = SDLECallConfirmationStatusInProgress;
        
        expect(testStruct.eCallNotificationStatus).to(equal(SDLVehicleDataNotificationStatusNormal));
        expect(testStruct.auxECallNotificationStatus).to(equal(SDLVehicleDataNotificationStatusActive));
        expect(testStruct.eCallConfirmationStatus).to(equal(SDLECallConfirmationStatusInProgress));
    });
    
    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary* dict = [@{SDLRPCParameterNameECallNotificationStatus:SDLVehicleDataNotificationStatusNormal,
                                       SDLRPCParameterNameAuxECallNotificationStatus:SDLVehicleDataNotificationStatusActive,
                                       SDLRPCParameterNameECallConfirmationStatus:SDLECallConfirmationStatusInProgress} mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLECallInfo* testStruct = [[SDLECallInfo alloc] initWithDictionary:dict];
#pragma clang diagnostic pop
        
        expect(testStruct.eCallNotificationStatus).to(equal(SDLVehicleDataNotificationStatusNormal));
        expect(testStruct.auxECallNotificationStatus).to(equal(SDLVehicleDataNotificationStatusActive));
        expect(testStruct.eCallConfirmationStatus).to(equal(SDLECallConfirmationStatusInProgress));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLECallInfo* testStruct = [[SDLECallInfo alloc] init];
        
        expect(testStruct.eCallNotificationStatus).to(beNil());
        expect(testStruct.auxECallNotificationStatus).to(beNil());
        expect(testStruct.eCallConfirmationStatus).to(beNil());
    });
});

QuickSpecEnd
