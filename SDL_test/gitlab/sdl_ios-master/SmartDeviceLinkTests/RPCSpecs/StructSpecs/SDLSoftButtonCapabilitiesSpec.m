//
//  SDLSoftButtonCapabilitiesSpec.m
//  SmartDeviceLink


#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLSoftButtonCapabilities.h"
#import "SDLRPCParameterNames.h"

QuickSpecBegin(SDLSoftButtonCapabilitiesSpec)

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLSoftButtonCapabilities* testStruct = [[SDLSoftButtonCapabilities alloc] init];
        
        testStruct.shortPressAvailable = @NO;
        testStruct.longPressAvailable = @YES;
        testStruct.upDownAvailable = @NO;
        testStruct.imageSupported = @NO;
        
        expect(testStruct.shortPressAvailable).to(equal(@NO));
        expect(testStruct.longPressAvailable).to(equal(@YES));
        expect(testStruct.upDownAvailable).to(equal(@NO));
        expect(testStruct.imageSupported).to(equal(@NO));
    });
    
    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary<NSString *, id> *dict = [@{SDLRPCParameterNameShortPressAvailable:@NO,
                                                       SDLRPCParameterNameLongPressAvailable:@YES,
                                                       SDLRPCParameterNameUpDownAvailable:@NO,
                                                       SDLRPCParameterNameImageSupported:@NO} mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLSoftButtonCapabilities* testStruct = [[SDLSoftButtonCapabilities alloc] initWithDictionary:dict];
#pragma clang diagnostic pop
        
        expect(testStruct.shortPressAvailable).to(equal(@NO));
        expect(testStruct.longPressAvailable).to(equal(@YES));
        expect(testStruct.upDownAvailable).to(equal(@NO));
        expect(testStruct.imageSupported).to(equal(@NO));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLSoftButtonCapabilities* testStruct = [[SDLSoftButtonCapabilities alloc] init];
        
        expect(testStruct.shortPressAvailable).to(beNil());
        expect(testStruct.longPressAvailable).to(beNil());
        expect(testStruct.upDownAvailable).to(beNil());
        expect(testStruct.imageSupported).to(beNil());
    });
});

QuickSpecEnd
