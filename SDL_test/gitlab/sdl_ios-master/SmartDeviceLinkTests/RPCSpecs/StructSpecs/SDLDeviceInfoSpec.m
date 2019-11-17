//
//  SDLDeviceInfoSpec.m
//  SmartDeviceLink


#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLDeviceInfo.h"
#import "SDLRPCParameterNames.h"

QuickSpecBegin(SDLDeviceInfoSpec)

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLDeviceInfo* testStruct = [[SDLDeviceInfo alloc] init];
        
        testStruct.hardware = @"GDFR34F";
        testStruct.firmwareRev = @"4.2a";
        testStruct.os = @"Robot";
        testStruct.osVersion = @"9.9";
        testStruct.carrier = @"ThatOneWirelessCompany";
        testStruct.maxNumberRFCOMMPorts = @20;
        
        expect(testStruct.hardware).to(equal(@"GDFR34F"));
        expect(testStruct.firmwareRev).to(equal(@"4.2a"));
        expect(testStruct.os).to(equal(@"Robot"));
        expect(testStruct.osVersion).to(equal(@"9.9"));
        expect(testStruct.carrier).to(equal(@"ThatOneWirelessCompany"));
        expect(testStruct.maxNumberRFCOMMPorts).to(equal(@20));
    });
    
    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary<NSString *, id> *dict = [@{SDLRPCParameterNameHardware:@"GDFR34F",
                                                       SDLRPCParameterNameFirmwareRevision:@"4.2a",
                                                       SDLRPCParameterNameOS:@"Robot",
                                                       SDLRPCParameterNameOSVersion:@"9.9",
                                                       SDLRPCParameterNameCarrier:@"ThatOneWirelessCompany",
                                                       SDLRPCParameterNameMaxNumberRFCOMMPorts:@20} mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLDeviceInfo* testStruct = [[SDLDeviceInfo alloc] initWithDictionary:dict];
#pragma clang diagnostic pop
        
        expect(testStruct.hardware).to(equal(@"GDFR34F"));
        expect(testStruct.firmwareRev).to(equal(@"4.2a"));
        expect(testStruct.os).to(equal(@"Robot"));
        expect(testStruct.osVersion).to(equal(@"9.9"));
        expect(testStruct.carrier).to(equal(@"ThatOneWirelessCompany"));
        expect(testStruct.maxNumberRFCOMMPorts).to(equal(@20));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLDeviceInfo* testStruct = [[SDLDeviceInfo alloc] init];
        
        expect(testStruct.hardware).to(beNil());
        expect(testStruct.firmwareRev).to(beNil());
        expect(testStruct.os).to(beNil());
        expect(testStruct.osVersion).to(beNil());
        expect(testStruct.carrier).to(beNil());
        expect(testStruct.maxNumberRFCOMMPorts).to(beNil());
    });
});

QuickSpecEnd
