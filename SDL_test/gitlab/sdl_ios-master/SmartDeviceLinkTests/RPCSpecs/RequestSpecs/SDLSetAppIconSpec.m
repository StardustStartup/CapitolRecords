//
//  SDLSetAppIconSpec.m
//  SmartDeviceLink


#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLSetAppIcon.h"
#import "SDLRPCParameterNames.h"
#import "SDLRPCFunctionNames.h"

QuickSpecBegin(SDLSetAppIconSpec)

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLSetAppIcon* testRequest = [[SDLSetAppIcon alloc] init];
        
        testRequest.syncFileName = @"A/File/Name";
        
        expect(testRequest.syncFileName).to(equal(@"A/File/Name"));
    });
    
    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary<NSString *, id> *dict = [@{SDLRPCParameterNameRequest:
                                                           @{SDLRPCParameterNameParameters:
                                                                 @{SDLRPCParameterNameSyncFileName:@"A/File/Name"},
                                                             SDLRPCParameterNameOperationName:SDLRPCFunctionNameSetAppIcon}} mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLSetAppIcon* testRequest = [[SDLSetAppIcon alloc] initWithDictionary:dict];
#pragma clang diagnostic pop
        
        expect(testRequest.syncFileName).to(equal(@"A/File/Name"));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLSetAppIcon* testRequest = [[SDLSetAppIcon alloc] init];
        
        expect(testRequest.syncFileName).to(beNil());
    });
});

QuickSpecEnd
