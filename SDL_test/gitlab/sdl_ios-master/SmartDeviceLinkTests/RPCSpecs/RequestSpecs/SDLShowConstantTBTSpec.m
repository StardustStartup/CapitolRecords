//
//  SDLShowConstantTBTSpec.m
//  SmartDeviceLink


#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLImage.h"
#import "SDLRPCParameterNames.h"
#import "SDLRPCFunctionNames.h"
#import "SDLShowConstantTBT.h"
#import "SDLSoftButton.h"


QuickSpecBegin(SDLShowConstantTBTSpec)

SDLImage* image1 = [[SDLImage alloc] init];
SDLImage* image2 = [[SDLImage alloc] init];
SDLSoftButton* button = [[SDLSoftButton alloc] init];

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLShowConstantTBT* testRequest = [[SDLShowConstantTBT alloc] init];
        
        testRequest.navigationText1 = @"nav1";
        testRequest.navigationText2 = @"nav2";
        testRequest.eta = @"4/1/7015";
        testRequest.timeToDestination = @"5000 Years";
        testRequest.totalDistance = @"1 parsec";
        testRequest.turnIcon = image1;
        testRequest.nextTurnIcon = image2;
        testRequest.distanceToManeuver = @2;
        testRequest.distanceToManeuverScale = @4;
        testRequest.maneuverComplete = @NO;
        testRequest.softButtons = [@[button] mutableCopy];
        
        expect(testRequest.navigationText1).to(equal(@"nav1"));
        expect(testRequest.navigationText2).to(equal(@"nav2"));
        expect(testRequest.eta).to(equal(@"4/1/7015"));
        expect(testRequest.timeToDestination).to(equal(@"5000 Years"));
        expect(testRequest.totalDistance).to(equal(@"1 parsec"));
        expect(testRequest.turnIcon).to(equal(image1));
        expect(testRequest.nextTurnIcon).to(equal(image2));
        expect(testRequest.distanceToManeuver).to(equal(@2));
        expect(testRequest.distanceToManeuverScale).to(equal(@4));
        expect(testRequest.maneuverComplete).to(equal(@NO));
        expect(testRequest.softButtons).to(equal([@[button] mutableCopy]));
    });
    
    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary<NSString *, id> *dict = [@{SDLRPCParameterNameRequest:
                                                           @{SDLRPCParameterNameParameters:
                                                                 @{SDLRPCParameterNameNavigationText1:@"nav1",
                                                                   SDLRPCParameterNameNavigationText2:@"nav2",
                                                                   SDLRPCParameterNameETA:@"4/1/7015",
                                                                   SDLRPCParameterNameTimeToDestination:@"5000 Years",
                                                                   SDLRPCParameterNameTotalDistance:@"1 parsec",
                                                                   SDLRPCParameterNameTurnIcon:image1,
                                                                   SDLRPCParameterNameNextTurnIcon:image2,
                                                                   SDLRPCParameterNameDistanceToManeuver:@2,
                                                                   SDLRPCParameterNameDistanceToManeuverScale:@4,
                                                                   SDLRPCParameterNameManeuverComplete:@NO,
                                                                   SDLRPCParameterNameSoftButtons:[@[button] mutableCopy]},
                                                             SDLRPCParameterNameOperationName:SDLRPCFunctionNameShowConstantTBT}} mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLShowConstantTBT* testRequest = [[SDLShowConstantTBT alloc] initWithDictionary:dict];
#pragma clang diagnostic pop
        
        expect(testRequest.navigationText1).to(equal(@"nav1"));
        expect(testRequest.navigationText2).to(equal(@"nav2"));
        expect(testRequest.eta).to(equal(@"4/1/7015"));
        expect(testRequest.timeToDestination).to(equal(@"5000 Years"));
        expect(testRequest.totalDistance).to(equal(@"1 parsec"));
        expect(testRequest.turnIcon).to(equal(image1));
        expect(testRequest.nextTurnIcon).to(equal(image2));
        expect(testRequest.distanceToManeuver).to(equal(@2));
        expect(testRequest.distanceToManeuverScale).to(equal(@4));
        expect(testRequest.maneuverComplete).to(equal(@NO));
        expect(testRequest.softButtons).to(equal([@[button] mutableCopy]));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLShowConstantTBT* testRequest = [[SDLShowConstantTBT alloc] init];
        
        expect(testRequest.navigationText1).to(beNil());
        expect(testRequest.navigationText2).to(beNil());
        expect(testRequest.eta).to(beNil());
        expect(testRequest.timeToDestination).to(beNil());
        expect(testRequest.totalDistance).to(beNil());
        expect(testRequest.turnIcon).to(beNil());
        expect(testRequest.nextTurnIcon).to(beNil());
        expect(testRequest.distanceToManeuver).to(beNil());
        expect(testRequest.distanceToManeuverScale).to(beNil());
        expect(testRequest.maneuverComplete).to(beNil());
        expect(testRequest.softButtons).to(beNil());
    });
});

QuickSpecEnd
