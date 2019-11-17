//
//  SDLMassageModeDataSpec.m
//  SmartDeviceLinkTests
//

#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLRPCParameterNames.h"
#import "SDLMassageModeData.h"

QuickSpecBegin(SDLMassageModeDataSpec)

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLMassageModeData* testStruct = [[SDLMassageModeData alloc] init];

        testStruct.massageMode = SDLMassageModeHigh;
        testStruct.massageZone = SDLMassageZoneLumbar;

        expect(testStruct.massageZone).to(equal(SDLMassageZoneLumbar));
        expect(testStruct.massageMode).to(equal(SDLMassageModeHigh));
    });

    it(@"Should set and get correctly", ^ {
        SDLMassageModeData* testStruct = [[SDLMassageModeData alloc] initWithMassageMode:SDLMassageZoneLumbar massageZone:SDLMassageModeHigh];

        expect(testStruct.massageZone).to(equal(SDLMassageModeHigh));
        expect(testStruct.massageMode).to(equal(SDLMassageZoneLumbar));
    });

    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary* dict = [@{SDLRPCParameterNameMassageMode:SDLMassageModeLow,
                                       SDLRPCParameterNameMassageZone:SDLMassageZoneLumbar
                                       } mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLMassageModeData* testStruct = [[SDLMassageModeData alloc] initWithDictionary:dict];
#pragma clang diagnostic pop

        expect(testStruct.massageZone).to(equal(SDLMassageZoneLumbar));
        expect(testStruct.massageMode).to(equal(SDLMassageModeLow));
    });

    it(@"Should return nil if not set", ^ {
        SDLMassageModeData* testStruct = [[SDLMassageModeData alloc] init];

        expect(testStruct.massageZone).to(beNil());
        expect(testStruct.massageMode).to(beNil());
    });
});

QuickSpecEnd

