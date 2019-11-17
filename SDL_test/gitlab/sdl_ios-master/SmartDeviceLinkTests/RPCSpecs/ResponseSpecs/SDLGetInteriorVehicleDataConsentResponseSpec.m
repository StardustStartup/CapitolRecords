//
//  SDLGetInteriorVehicleDataConsent.m
//  SmartDeviceLinkTests
//
//  Created by standa1 on 7/29/19.
//  Copyright © 2019 smartdevicelink. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLGetInteriorVehicleDataConsentResponse.h"
#import "SDLModuleData.h"
#import "SDLRPCParameterNames.h"
#import "SDLRPCFunctionNames.h"

QuickSpecBegin(SDLGetInteriorVehicleDataConsentResponseSpec)

describe(@"Getter/Setter Tests", ^ {
    __block NSArray<NSNumber<SDLBool> *> *allowed = nil;
    
    beforeEach(^{
        allowed = @[@YES, @NO];
    });
    
    it(@"Should set and get correctly", ^ {
        SDLGetInteriorVehicleDataConsentResponse *testResponse = [[SDLGetInteriorVehicleDataConsentResponse alloc] init];
        
        testResponse.allowed = allowed;
        
        expect(testResponse.allowed).to(equal(allowed));
    });
    
    
    
    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary<NSString *, id> *dict = [@{SDLRPCParameterNameResponse:
                                                           @{SDLRPCParameterNameParameters:
                                                                 @{SDLRPCParameterNameAllowed:allowed},
                                                             SDLRPCParameterNameOperationName:SDLRPCFunctionNameGetInteriorVehicleData}} mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLGetInteriorVehicleDataConsentResponse *testResponse = [[SDLGetInteriorVehicleDataConsentResponse alloc] initWithDictionary:dict];
#pragma clang diagnostic pop
        
        expect(testResponse.allowed).to(equal(allowed));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLGetInteriorVehicleDataConsentResponse *testResponse = [[SDLGetInteriorVehicleDataConsentResponse alloc] init];

        expect(testResponse.allowed).to(beNil());
    });
});

QuickSpecEnd
