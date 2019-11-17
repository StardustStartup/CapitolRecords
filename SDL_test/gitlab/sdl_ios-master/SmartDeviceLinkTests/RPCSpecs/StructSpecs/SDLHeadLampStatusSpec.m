//
//  SDLHeadLampStatusSpec.m
//  SmartDeviceLink


#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLAmbientLightStatus.h"
#import "SDLHeadLampStatus.h"
#import "SDLRPCParameterNames.h"


QuickSpecBegin(SDLHeadLampStatusSpec)

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLHeadLampStatus* testStruct = [[SDLHeadLampStatus alloc] init];
        
        testStruct.lowBeamsOn = @YES;
        testStruct.highBeamsOn = @NO;
        testStruct.ambientLightSensorStatus = SDLAmbientLightStatusTwilight3;
        
        expect(testStruct.lowBeamsOn).to(equal(@YES));
        expect(testStruct.highBeamsOn).to(equal(@NO));
        expect(testStruct.ambientLightSensorStatus).to(equal(SDLAmbientLightStatusTwilight3));
    });
    
    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary* dict = [@{SDLRPCParameterNameLowBeamsOn:@YES,
                                       SDLRPCParameterNameHighBeamsOn:@NO,
                                       SDLRPCParameterNameAmbientLightSensorStatus:SDLAmbientLightStatusTwilight3} mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLHeadLampStatus* testStruct = [[SDLHeadLampStatus alloc] initWithDictionary:dict];
#pragma clang diagnostic pop
        
        expect(testStruct.lowBeamsOn).to(equal(@YES));
        expect(testStruct.highBeamsOn).to(equal(@NO));
        expect(testStruct.ambientLightSensorStatus).to(equal(SDLAmbientLightStatusTwilight3));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLHeadLampStatus* testStruct = [[SDLHeadLampStatus alloc] init];
        
        expect(testStruct.lowBeamsOn).to(beNil());
        expect(testStruct.highBeamsOn).to(beNil());
        expect(testStruct.ambientLightSensorStatus).to(beNil());
    });
});

QuickSpecEnd
