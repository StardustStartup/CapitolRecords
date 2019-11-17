//
//  SDLClimateControlDataSpec.m
//  SmartDeviceLink-iOS
//

#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLClimateControlData.h"
#import "SDLTemperature.h"
#import "SDLDefrostZone.h"
#import "SDLVentilationMode.h"
#import "SDLRPCParameterNames.h"

QuickSpecBegin(SDLClimateControlDataSpec)

describe(@"Getter/Setter Tests", ^ {
    __block SDLTemperature* currentTemp = nil;
    __block SDLTemperature* desiredTemp = nil;
    
    beforeEach(^{
        currentTemp = [[SDLTemperature alloc] init];
        desiredTemp = [[SDLTemperature alloc] init];
    });

    it(@"Should set and get correctly", ^ {
        SDLClimateControlData* testStruct = [[SDLClimateControlData alloc] init];
        
        testStruct.fanSpeed = @43;
        testStruct.currentTemperature = currentTemp;
        testStruct.desiredTemperature = desiredTemp;
        testStruct.acEnable = @YES;
        testStruct.circulateAirEnable = @YES;
        testStruct.autoModeEnable = @NO;
        testStruct.defrostZone = SDLDefrostZoneFront;
        testStruct.dualModeEnable = @NO;
        testStruct.acMaxEnable = @YES;
        testStruct.ventilationMode = SDLVentilationModeBoth;
        testStruct.heatedSteeringWheelEnable = @NO;
        testStruct.heatedWindshieldEnable = @YES;
        testStruct.heatedRearWindowEnable = @NO;
        testStruct.heatedMirrorsEnable = @YES;
        testStruct.climateEnable = @YES;
        
        expect(testStruct.fanSpeed).to(equal(@43));
        expect(testStruct.currentTemperature).to(equal(currentTemp));
        expect(testStruct.desiredTemperature).to(equal(desiredTemp));
        expect(testStruct.acEnable).to(equal(YES));
        expect(testStruct.circulateAirEnable).to(equal(YES));
        expect(testStruct.autoModeEnable).to(equal(NO));
        expect(testStruct.defrostZone).to(equal(SDLDefrostZoneFront));
        expect(testStruct.dualModeEnable).to(equal(NO));
        expect(testStruct.acMaxEnable).to(equal(YES));
        expect(testStruct.ventilationMode).to(equal(SDLVentilationModeBoth));
        expect(testStruct.heatedSteeringWheelEnable).to(equal(@NO));
        expect(testStruct.heatedWindshieldEnable).to(equal(@YES));
        expect(testStruct.heatedRearWindowEnable).to(equal(@NO));
        expect(testStruct.heatedMirrorsEnable).to(equal(@YES));
        expect(testStruct.climateEnable).to(equal(@YES));

    });

    it(@"Should get correctly when initialized with FanSpeed and other climate control parameters", ^ {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLClimateControlData* testStruct = [[SDLClimateControlData alloc] initWithFanSpeed:@43 desiredTemperature:desiredTemp acEnable:@YES circulateAirEnable:@YES autoModeEnable:@NO defrostZone:SDLDefrostZoneFront dualModeEnable:@NO acMaxEnable:@YES ventilationMode:SDLVentilationModeBoth];

        expect(testStruct.fanSpeed).to(equal(@43));
        expect(testStruct.desiredTemperature).to(equal(desiredTemp));
        expect(testStruct.acEnable).to(equal(YES));
        expect(testStruct.circulateAirEnable).to(equal(YES));
        expect(testStruct.autoModeEnable).to(equal(NO));
        expect(testStruct.defrostZone).to(equal(SDLDefrostZoneFront));
        expect(testStruct.dualModeEnable).to(equal(NO));
        expect(testStruct.acMaxEnable).to(equal(YES));
        expect(testStruct.ventilationMode).to(equal(SDLVentilationModeBoth));
        expect(testStruct.heatedSteeringWheelEnable).to(equal(NO));
        expect(testStruct.heatedWindshieldEnable).to(equal(NO));
        expect(testStruct.heatedRearWindowEnable).to(equal(NO));
        expect(testStruct.heatedMirrorsEnable).to(equal(NO));
        expect(testStruct.climateEnable).to(beNil());
        #pragma clang diagnostic pop
    });

    it(@"Should get correctly when initialized with FanSpeed and other climate control parameters", ^ {
        SDLClimateControlData* testStruct = [[SDLClimateControlData alloc] initWithFanSpeed:@43 desiredTemperature:desiredTemp acEnable:@YES circulateAirEnable:@YES autoModeEnable:@NO defrostZone:SDLDefrostZoneFront dualModeEnable:@NO acMaxEnable:@YES ventilationMode:SDLVentilationModeBoth heatedSteeringWheelEnable:@NO heatedWindshieldEnable:@YES heatedRearWindowEnable:@NO heatedMirrorsEnable:@YES climateEnable:@YES];

        expect(testStruct.fanSpeed).to(equal(@43));
        expect(testStruct.desiredTemperature).to(equal(desiredTemp));
        expect(testStruct.acEnable).to(equal(YES));
        expect(testStruct.circulateAirEnable).to(equal(YES));
        expect(testStruct.autoModeEnable).to(equal(NO));
        expect(testStruct.defrostZone).to(equal(SDLDefrostZoneFront));
        expect(testStruct.dualModeEnable).to(equal(NO));
        expect(testStruct.acMaxEnable).to(equal(YES));
        expect(testStruct.ventilationMode).to(equal(SDLVentilationModeBoth));
        expect(testStruct.heatedSteeringWheelEnable).to(equal(@NO));
        expect(testStruct.heatedWindshieldEnable).to(equal(@YES));
        expect(testStruct.heatedRearWindowEnable).to(equal(@NO));
        expect(testStruct.heatedMirrorsEnable).to(equal(@YES));
        expect(testStruct.climateEnable).to(equal(@YES));
    });

    it(@"Should get correctly when initialized with a dictionary", ^ {
        NSMutableDictionary<NSString *, id> *dict = [@{SDLRPCParameterNameFanSpeed : @43,
                                                       SDLRPCParameterNameCurrentTemperature : currentTemp,
                                                       SDLRPCParameterNameDesiredTemperature : desiredTemp,
                                                       SDLRPCParameterNameACEnable : @YES,
                                                       SDLRPCParameterNameCirculateAirEnable : @YES,
                                                       SDLRPCParameterNameAutoModeEnable : @NO,
                                                       SDLRPCParameterNameDefrostZone : SDLDefrostZoneFront,
                                                       SDLRPCParameterNameDualModeEnable : @NO,
                                                       SDLRPCParameterNameACMaxEnable : @YES,
                                                       SDLRPCParameterNameVentilationMode :SDLVentilationModeBoth,
                                                       SDLRPCParameterNameHeatedSteeringWheelEnable:@NO,
                                                       SDLRPCParameterNameHeatedWindshieldEnable:@YES,
                                                       SDLRPCParameterNameHeatedRearWindowEnable:@NO,
                                                       SDLRPCParameterNameHeatedMirrorsEnable:@YES,
                                                       SDLRPCParameterNameClimateEnable:@YES,
                                                       } mutableCopy];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLClimateControlData* testStruct = [[SDLClimateControlData alloc] initWithDictionary:dict];
#pragma clang diagnostic pop
        
        expect(testStruct.fanSpeed).to(equal(@43));
        expect(testStruct.currentTemperature).to(equal(currentTemp));
        expect(testStruct.desiredTemperature).to(equal(desiredTemp));
        expect(testStruct.acEnable).to(equal(YES));
        expect(testStruct.circulateAirEnable).to(equal(YES));
        expect(testStruct.autoModeEnable).to(equal(NO));
        expect(testStruct.defrostZone).to(equal(SDLDefrostZoneFront));
        expect(testStruct.dualModeEnable).to(equal(NO));
        expect(testStruct.acMaxEnable).to(equal(YES));
        expect(testStruct.ventilationMode).to(equal(SDLVentilationModeBoth));
        expect(testStruct.heatedSteeringWheelEnable).to(equal(@NO));
        expect(testStruct.heatedWindshieldEnable).to(equal(@YES));
        expect(testStruct.heatedRearWindowEnable).to(equal(@NO));
        expect(testStruct.heatedMirrorsEnable).to(equal(@YES));
        expect(testStruct.climateEnable).to(equal(@YES));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLClimateControlData* testStruct = [[SDLClimateControlData alloc] init];
        
        expect(testStruct.fanSpeed).to(beNil());
        expect(testStruct.currentTemperature).to(beNil());
        expect(testStruct.desiredTemperature).to(beNil());
        expect(testStruct.acEnable).to(beNil());
        expect(testStruct.circulateAirEnable).to(beNil());
        expect(testStruct.autoModeEnable).to(beNil());
        expect(testStruct.defrostZone).to(beNil());
        expect(testStruct.dualModeEnable).to(beNil());
        expect(testStruct.acMaxEnable).to(beNil());
        expect(testStruct.ventilationMode).to(beNil());
        expect(testStruct.heatedSteeringWheelEnable).to(beNil());
        expect(testStruct.heatedWindshieldEnable).to(beNil());
        expect(testStruct.heatedRearWindowEnable).to(beNil());
        expect(testStruct.heatedMirrorsEnable).to(beNil());
        expect(testStruct.climateEnable).to(beNil());
    });
    
});

QuickSpecEnd
