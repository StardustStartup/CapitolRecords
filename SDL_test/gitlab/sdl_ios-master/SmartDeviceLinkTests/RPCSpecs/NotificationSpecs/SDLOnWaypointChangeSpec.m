//  SDLOnWayPointChangeSpec.m
//

#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLOnWayPointChange.h"

#import "SDLImage.h"
#import "SDLLocationCoordinate.h"
#import "SDLLocationDetails.h"
#import "SDLRPCParameterNames.h"
#import "SDLRPCFunctionNames.h"
#import "SDLOasisAddress.h"

QuickSpecBegin(SDLOnWayPointChangeSpec)

describe(@"Getter/Setter Tests", ^ {
    __block SDLOnWayPointChange* testNotification = nil;
    __block NSArray<SDLLocationDetails *>* someWaypoints = nil;
    
    describe(@"when initialized with init", ^{
        beforeEach(^{
            testNotification = [[SDLOnWayPointChange alloc] init];
        });
        
        context(@"when parameters are set correctly", ^{
            beforeEach(^{
                SDLLocationDetails* someLocation = [[SDLLocationDetails alloc] init];
                someLocation.coordinate = [[SDLLocationCoordinate alloc] init];
                someLocation.locationName = @"Livio";
                someLocation.locationDescription = @"A great place to work";
                someLocation.addressLines = @[@"3136 Hilton Rd", @"Ferndale, MI", @"48220"];
                someLocation.phoneNumber = @"248-591-0333";
                someLocation.locationImage = [[SDLImage alloc] init];
                someLocation.searchAddress = [[SDLOasisAddress alloc] init];
                
                someWaypoints = @[someLocation];
                
                testNotification.waypoints = someWaypoints;
            });
            
            // Since all the properties are immutable, a copy should be executed as a retain, which means they should be identical
            it(@"should get waypoints correctly", ^{
                expect(testNotification.waypoints).to(equal(someWaypoints));
                expect(testNotification.waypoints).to(beIdenticalTo(someWaypoints));
            });
        });
    });
    
    describe(@"when initialized with a dictionary", ^{
        context(@"when parameters are set correctly", ^{
            beforeEach(^{
                SDLLocationDetails* someLocation = [[SDLLocationDetails alloc] init];
                someLocation.coordinate = [[SDLLocationCoordinate alloc] init];
                someLocation.locationName = @"Livio";
                someLocation.locationDescription = @"A great place to work";
                someLocation.addressLines = @[@"3136 Hilton Rd", @"Ferndale, MI", @"48220"];
                someLocation.phoneNumber = @"248-591-0333";
                someLocation.locationImage = [[SDLImage alloc] init];
                someLocation.searchAddress = [[SDLOasisAddress alloc] init];
                
                someWaypoints = @[someLocation];
                
                NSDictionary *initDict = @{SDLRPCParameterNameNotification : @{
                                                   SDLRPCParameterNameParameters: @{
                                                           SDLRPCParameterNameWayPoints: someWaypoints
                                                           }
                                                   },
                                           SDLRPCParameterNameOperationName:SDLRPCFunctionNameOnWayPointChange
                                           };
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                testNotification = [[SDLOnWayPointChange alloc] initWithDictionary:[NSMutableDictionary dictionaryWithDictionary:initDict]];
#pragma clang diagnostic pop
            });
            
            // Since all the properties are immutable, a copy should be executed as a retain, which means they should be identical
            it(@"should get waypoints correctly", ^{
                expect(testNotification.waypoints).to(equal(someWaypoints));
                expect(testNotification.waypoints).to(beIdenticalTo(someWaypoints));
            });
        });
        
        context(@"when parameters are not set", ^{
            beforeEach(^{
                NSDictionary *initDict = @{
                                           SDLRPCParameterNameNotification: @{
                                                   SDLRPCParameterNameParameters: @{}
                                                   }
                                           };
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                testNotification = [[SDLOnWayPointChange alloc] initWithDictionary:[NSMutableDictionary dictionaryWithDictionary:initDict]];
#pragma clang diagnostic pop
            });
            
            it(@"should return nil for waypoints", ^{
                expect(testNotification.waypoints).to(beNil());
            });
        });
    });
});

QuickSpecEnd
