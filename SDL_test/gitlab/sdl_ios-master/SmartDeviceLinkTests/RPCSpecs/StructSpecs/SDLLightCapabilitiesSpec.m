//
//  SDLLightCapabilitiesSpec.m
//  SmartDeviceLinkTests
//

#import <Foundation/Foundation.h>
#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLRPCParameterNames.h"
#import "SDLLightName.h"
#import "SDLLightCapabilities.h"

QuickSpecBegin( SDLLightCapabilitiesSpec)

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLLightCapabilities* testStruct = [[SDLLightCapabilities alloc] init];

        testStruct.name = SDLLightNameFogLights;
        testStruct.densityAvailable = @YES;
        testStruct.colorAvailable = @NO;

        expect(testStruct.name).to(equal(SDLLightNameFogLights));
        expect(testStruct.densityAvailable).to(equal(@YES));
        expect(testStruct.colorAvailable).to(equal(@NO));
    });

    it(@"Should set and get correctly", ^ {
        SDLLightCapabilities* testStruct = [[SDLLightCapabilities alloc] initWithName:SDLLightNameFogLights densityAvailable:YES colorAvailable:NO statusAvailable:NO];

        expect(testStruct.name).to(equal(SDLLightNameFogLights));
        expect(testStruct.densityAvailable).to(equal(@YES));
        expect(testStruct.colorAvailable).to(equal(@NO));
        expect(testStruct.statusAvailable).to(equal(@NO));

    });

    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary* dict = [@{SDLRPCParameterNameName:SDLLightNameFogLights,
                                       SDLRPCParameterNameDensityAvailable:@YES,
                                       SDLRPCParameterNameRGBColorSpaceAvailable:@NO
                                       } mutableCopy];

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLLightCapabilities* testStruct = [[SDLLightCapabilities alloc] initWithDictionary:dict];
#pragma clang diagnostic pop

        expect(testStruct.name).to(equal(SDLLightNameFogLights));
        expect(testStruct.densityAvailable).to(equal(@YES));
        expect(testStruct.colorAvailable).to(equal(@NO));
    });

    it(@"Should return nil if not set", ^ {
        SDLLightCapabilities* testStruct = [[SDLLightCapabilities alloc] init];

        expect(testStruct.name).to(beNil());
        expect(testStruct.densityAvailable).to(beNil());
        expect(testStruct.colorAvailable).to(beNil());

    });
});

QuickSpecEnd
