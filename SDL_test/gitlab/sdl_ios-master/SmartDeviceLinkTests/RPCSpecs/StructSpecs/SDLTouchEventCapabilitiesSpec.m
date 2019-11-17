//
//  SDLTouchEventCapabilitiesSpec.m
//  SmartDeviceLink


#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLTouchEventCapabilities.h"
#import "SDLRPCParameterNames.h"

QuickSpecBegin(SDLTouchEventCapabilitiesSpec)

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLTouchEventCapabilities* testStruct = [[SDLTouchEventCapabilities alloc] init];
        
        testStruct.pressAvailable = @YES;
        testStruct.multiTouchAvailable = @NO;
        testStruct.doublePressAvailable = @YES;
        
        expect(testStruct.pressAvailable).to(equal(@YES));
        expect(testStruct.multiTouchAvailable).to(equal(@NO));
        expect(testStruct.doublePressAvailable).to(equal(@YES));
    });
    
    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary<NSString *, id> *dict = [@{SDLRPCParameterNamePressAvailable:@YES,
                                                       SDLRPCParameterNameMultiTouchAvailable:@NO,
                                                       SDLRPCParameterNameDoublePressAvailable:@NO} mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLTouchEventCapabilities* testStruct = [[SDLTouchEventCapabilities alloc] initWithDictionary:dict];
#pragma clang diagnostic pop
        
        expect(testStruct.pressAvailable).to(equal(@YES));
        expect(testStruct.multiTouchAvailable).to(equal(@NO));
        expect(testStruct.doublePressAvailable).to(equal(@NO));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLTouchEventCapabilities* testStruct = [[SDLTouchEventCapabilities alloc] init];
        
        expect(testStruct.pressAvailable).to(beNil());
        expect(testStruct.multiTouchAvailable).to(beNil());
        expect(testStruct.doublePressAvailable).to(beNil());
    });
});

QuickSpecEnd
