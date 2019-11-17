//
//  SDLHapticRectSpec.m
//  SmartDeviceLink-iOS
//
//  Created by Nicole on 8/3/17.
//  Copyright © 2017 smartdevicelink. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLRPCParameterNames.h"
#import "SDLHapticRect.h"
#import "SDLRectangle.h"

QuickSpecBegin(SDLHapticRectSpec)

describe(@"Getter/Setter Tests", ^{
    __block SDLRectangle *testRect = nil;
    beforeEach(^{
        testRect = [[SDLRectangle alloc] initWithX:1.2 y:42.3 width:78.9 height:69];
    });

    it(@"Should set and get correctly", ^{
        SDLHapticRect *testStruct = [[SDLHapticRect alloc] init];

        testStruct.id = @1;
        testStruct.rect = testRect;

        expect(testStruct.id).to(equal(@1));
        expect(testStruct.rect).to(equal(testRect));
    });

    it(@"Should get correctly when initialized with parameters", ^{
        SDLHapticRect *testStruct = [[SDLHapticRect alloc] initWithId:23 rect:testRect];

        expect(testStruct.id).to(equal(@23));
        expect(testStruct.rect).to(equal(testRect));
    });

    it(@"Should get correctly when initialized with a dict", ^{
        NSMutableDictionary *dict = [@{SDLRPCParameterNameId:@2,
                                       SDLRPCParameterNameRect: @{
                                               SDLRPCParameterNameX:@20,
                                               SDLRPCParameterNameY:@200,
                                               SDLRPCParameterNameWidth:@2000,
                                               SDLRPCParameterNameHeight:@3000
                                               }
                                       } mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLHapticRect *testStruct = [[SDLHapticRect alloc] initWithDictionary:dict];
#pragma clang diagnostic pop

        expect(testStruct.id).to(equal(@2));
        expect(testStruct.rect.x).to(equal(@20));
        expect(testStruct.rect.y).to(equal(@200));
        expect(testStruct.rect.width).to(equal(@2000));
        expect(testStruct.rect.height).to(equal(@3000));
    });

    it(@"Should return nil if not set", ^{
        SDLHapticRect *testStruct = [[SDLHapticRect alloc] init];

        expect(testStruct.id).to(beNil());
        expect(testStruct.rect).to(beNil());
    });
});

QuickSpecEnd
