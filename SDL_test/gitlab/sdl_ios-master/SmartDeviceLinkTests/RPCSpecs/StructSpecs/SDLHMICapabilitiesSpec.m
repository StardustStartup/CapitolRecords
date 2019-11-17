//
//  SDLHMICapabilitiesSpec.m
//  SmartDeviceLink-iOS
//

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLHMICapabilities.h"
#import "SDLRPCParameterNames.h"


QuickSpecBegin(SDLHMICapabilitiesSpec)

describe(@"SDLHMICapabilities struct", ^{
    __block SDLHMICapabilities *testStruct = nil;
    __block NSNumber *somePhoneCallState = @NO;
    __block NSNumber *someNavigationState = @YES;
    __block NSNumber *someVideoStreamState = @NO;
    __block NSNumber *someRemoteControlState = @YES;
    __block NSNumber *someAppServicesState = @YES;
         
    
    context(@"When initialized with properties", ^{
        beforeEach(^{
            testStruct = [[SDLHMICapabilities alloc] init];
            testStruct.phoneCall = somePhoneCallState;
            testStruct.navigation = someNavigationState;
            testStruct.videoStreaming = someVideoStreamState;
            testStruct.remoteControl = someRemoteControlState;
            testStruct.appServices = someAppServicesState;
        });
        
        it(@"should properly set properties", ^{
            expect(testStruct.phoneCall).to(equal(somePhoneCallState));
            expect(testStruct.navigation).to(equal(someNavigationState));
            expect(testStruct.videoStreaming).to(equal(someVideoStreamState));
            expect(testStruct.remoteControl).to(equal(someRemoteControlState));
            expect(testStruct.appServices).to(equal(someAppServicesState));
        });
    });
    
    context(@"When initialized with a dictionary", ^{
        beforeEach(^{
            NSDictionary<NSString *, NSNumber *> *structInitDict = @{
                                             SDLRPCParameterNameNavigation: someNavigationState,
                                             SDLRPCParameterNamePhoneCall: somePhoneCallState,
                                             SDLRPCParameterNameVideoStreaming: someVideoStreamState,
                                             SDLRPCParameterNameRemoteControl: someRemoteControlState,
                                             SDLRPCParameterNameAppServices: someAppServicesState
                                             };
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            testStruct = [[SDLHMICapabilities alloc] initWithDictionary:[structInitDict mutableCopy]];
#pragma clang diagnostic pop
        });
        
        it(@"should properly set properties", ^{
            expect(testStruct.phoneCall).to(equal(somePhoneCallState));
            expect(testStruct.navigation).to(equal(someNavigationState));
            expect(testStruct.videoStreaming).to(equal(someVideoStreamState));
            expect(testStruct.remoteControl).to(equal(someRemoteControlState));
            expect(testStruct.appServices).to(equal(someAppServicesState));
        });
    });
    
    context(@"When not initialized", ^{
        beforeEach(^{
            testStruct = nil;
        });
        
        it(@"properties should be nil", ^{
            expect(testStruct.phoneCall).to(beNil());
            expect(testStruct.navigation).to(beNil());
            expect(testStruct.videoStreaming).to(beNil());
            expect(testStruct.remoteControl).to(beNil());
            expect(testStruct.appServices).to(beNil());
        });
    });
});

QuickSpecEnd
