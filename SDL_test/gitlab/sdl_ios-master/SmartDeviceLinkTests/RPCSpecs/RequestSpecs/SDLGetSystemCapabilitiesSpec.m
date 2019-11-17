#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLGetSystemCapability.h"

#import "SDLSystemCapabilityType.h"
#import "SDLRPCParameterNames.h"

QuickSpecBegin(SDLGetSystemCapabilitiesSpec)

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLGetSystemCapability *testRequest = [[SDLGetSystemCapability alloc] init];

        testRequest.systemCapabilityType = SDLSystemCapabilityTypeNavigation;

        expect(testRequest.systemCapabilityType).to(equal(SDLSystemCapabilityTypeNavigation));
    });
});

describe(@"Initialization tests", ^{
    it(@"Should get correctly when initialized with a dictionary", ^ {
        NSDictionary *dict = @{SDLRPCParameterNameRequest: @{
                                       SDLRPCParameterNameParameters: @{
                                               SDLRPCParameterNameSystemCapabilityType: @"PHONE_CALL"
                                               }
                                       }
                               };
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLGetSystemCapability *testRequest = [[SDLGetSystemCapability alloc] initWithDictionary:dict];
#pragma clang diagnostic pop

        expect(testRequest.systemCapabilityType).to(equal(SDLSystemCapabilityTypePhoneCall));
    });

    it(@"Should return nil if not set", ^ {
        SDLGetSystemCapability *testRequest = [[SDLGetSystemCapability alloc] init];

        expect(testRequest.systemCapabilityType).to(beNil());
    });

    it(@"Should get correctly when initialized with systemCapabilityType", ^ {
        SDLGetSystemCapability* testRequest = [[SDLGetSystemCapability alloc] initWithType:SDLSystemCapabilityTypePhoneCall];

        expect(testRequest.systemCapabilityType).to(equal(SDLSystemCapabilityTypePhoneCall));
    });
});


QuickSpecEnd
