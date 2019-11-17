//
//  SDLSetGlobalPropertiesSpec.m
//  SmartDeviceLink


#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLImage.h"
#import "SDLKeyboardProperties.h"
#import "SDLRPCParameterNames.h"
#import "SDLRPCFunctionNames.h"
#import "SDLSetGlobalProperties.h"
#import "SDLTTSChunk.h"
#import "SDLVrHelpItem.h"
#import "SDLSeatLocation.h"


QuickSpecBegin(SDLSetGlobalPropertiesSpec)

SDLTTSChunk* chunk1 = [[SDLTTSChunk alloc] init];
SDLTTSChunk* chunk2 = [[SDLTTSChunk alloc] init];
SDLVRHelpItem* help = [[SDLVRHelpItem alloc] init];
SDLImage* image = [[SDLImage alloc] init];
SDLKeyboardProperties* keyboard = [[SDLKeyboardProperties alloc] init];
SDLSeatLocation *seatLocation = [[SDLSeatLocation alloc] init];

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLSetGlobalProperties* testRequest = [[SDLSetGlobalProperties alloc] init];
        
        testRequest.helpPrompt = [@[chunk1] mutableCopy];
        testRequest.timeoutPrompt = [@[chunk2] mutableCopy];
        testRequest.vrHelpTitle = @"vr";
        testRequest.vrHelp = [@[help] mutableCopy];
        testRequest.menuTitle = @"TheNewMenu";
        testRequest.menuIcon = image;
        testRequest.keyboardProperties = keyboard;
        testRequest.userLocation = seatLocation;
        
        expect(testRequest.helpPrompt).to(equal([@[chunk1] mutableCopy]));
        expect(testRequest.timeoutPrompt).to(equal([@[chunk2] mutableCopy]));
        expect(testRequest.vrHelpTitle).to(equal(@"vr"));
        expect(testRequest.vrHelp).to(equal([@[help] mutableCopy]));
        expect(testRequest.menuTitle).to(equal(@"TheNewMenu"));
        expect(testRequest.menuIcon).to(equal(image));
        expect(testRequest.keyboardProperties).to(equal(keyboard));
        expect(testRequest.userLocation).to(equal(seatLocation));
    });
    
    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary<NSString *, id> *dict = [@{SDLRPCParameterNameRequest:
                                                           @{SDLRPCParameterNameParameters:
                                                                 @{SDLRPCParameterNameHelpPrompt:[@[chunk1] mutableCopy],
                                                                   SDLRPCParameterNameTimeoutPrompt:[@[chunk2] mutableCopy],
                                                                   SDLRPCParameterNameVRHelpTitle:@"vr",
                                                                   SDLRPCParameterNameVRHelp:[@[help] mutableCopy],
                                                                   SDLRPCParameterNameMenuTitle:@"TheNewMenu",
                                                                   SDLRPCParameterNameUserLocation: seatLocation,
                                                                   SDLRPCParameterNameMenuIcon:image,
                                                                   SDLRPCParameterNameKeyboardProperties:keyboard},
                                                             SDLRPCParameterNameOperationName:SDLRPCFunctionNameSetGlobalProperties}} mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLSetGlobalProperties* testRequest = [[SDLSetGlobalProperties alloc] initWithDictionary:dict];
#pragma clang diagnostic pop
        
        expect(testRequest.helpPrompt).to(equal([@[chunk1] mutableCopy]));
        expect(testRequest.timeoutPrompt).to(equal([@[chunk2] mutableCopy]));
        expect(testRequest.vrHelpTitle).to(equal(@"vr"));
        expect(testRequest.vrHelp).to(equal([@[help] mutableCopy]));
        expect(testRequest.menuTitle).to(equal(@"TheNewMenu"));
        expect(testRequest.menuIcon).to(equal(image));
        expect(testRequest.keyboardProperties).to(equal(keyboard));
        expect(testRequest.userLocation).to(equal(seatLocation));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLSetGlobalProperties* testRequest = [[SDLSetGlobalProperties alloc] init];
        
        expect(testRequest.helpPrompt).to(beNil());
        expect(testRequest.timeoutPrompt).to(beNil());
        expect(testRequest.vrHelpTitle).to(beNil());
        expect(testRequest.vrHelp).to(beNil());
        expect(testRequest.menuTitle).to(beNil());
        expect(testRequest.menuIcon).to(beNil());
        expect(testRequest.keyboardProperties).to(beNil());
        expect(testRequest.userLocation).to(beNil());
    });
});

QuickSpecEnd
