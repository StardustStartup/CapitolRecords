//
//  SDLGetDTCsResponseSpec.m
//  SmartDeviceLink


#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLGetDTCsResponse.h"
#import "SDLRPCParameterNames.h"
#import "SDLRPCFunctionNames.h"

QuickSpecBegin(SDLGetDTCsResponseSpec)

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLGetDTCsResponse* testResponse = [[SDLGetDTCsResponse alloc] init];
        
        testResponse.ecuHeader = @404;
        testResponse.dtc = [@[@"FFFF", @"FFFE", @"FFFD"] mutableCopy];
        
        expect(testResponse.ecuHeader).to(equal(@404));
        expect(testResponse.dtc).to(equal([@[@"FFFF", @"FFFE", @"FFFD"] mutableCopy]));
    });
    
    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary<NSString *, id> *dict = [@{SDLRPCParameterNameResponse:
                                                          @{SDLRPCParameterNameParameters:
                                                                @{SDLRPCParameterNameECUHeader:@404,
                                                                  SDLRPCParameterNameDTC:[@[@"FFFF", @"FFFE", @"FFFD"] mutableCopy]},
                                                            SDLRPCParameterNameOperationName:SDLRPCFunctionNameGetDTCs}} mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLGetDTCsResponse* testResponse = [[SDLGetDTCsResponse alloc] initWithDictionary:dict];
#pragma clang diagnostic pop
        
        expect(testResponse.ecuHeader).to(equal(@404));
        expect(testResponse.dtc).to(equal([@[@"FFFF", @"FFFE", @"FFFD"] mutableCopy]));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLGetDTCsResponse* testResponse = [[SDLGetDTCsResponse alloc] init];
        
        expect(testResponse.ecuHeader).to(beNil());
        expect(testResponse.dtc).to(beNil());
    });
});

QuickSpecEnd
