#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLRPCParameterNames.h"
#import "SDLRectangle.h"

QuickSpecBegin(SDLRectangleSpec)

describe(@"Rectangle Tests", ^{
    it(@"Should set and get correctly", ^{
        SDLRectangle *testStruct = [[SDLRectangle alloc] init];

        testStruct.x = @10;
        testStruct.y = @100;
        testStruct.width = @1000;
        testStruct.height = @2000;

        expect(testStruct.x).to(equal(@10));
        expect(testStruct.y).to(equal(@100));
        expect(testStruct.width).to(equal(@1000));
        expect(testStruct.height).to(equal(@2000));
    });

    it(@"Should get correctly when initialized with parameters", ^{
        SDLRectangle *testStruct = [[SDLRectangle alloc] initWithX:50.5 y:60.2 width:500 height:600];

        expect(testStruct.x).to(beCloseTo(@50.5));
        expect(testStruct.y).to(beCloseTo(@60.2));
        expect(testStruct.width).to(equal(@500.0));
        expect(testStruct.height).to(equal(@600.0));
    });

    it(@"Should get correctly when initialized with a dict", ^{
        NSDictionary *dict = @{SDLRPCParameterNameX:@20,
                                SDLRPCParameterNameY:@200,
                                SDLRPCParameterNameWidth:@2000,
                                SDLRPCParameterNameHeight:@3000};
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLRectangle *testStruct = [[SDLRectangle alloc] initWithDictionary:dict];
#pragma clang diagnostic pop

        expect(testStruct.x).to(equal(@20));
        expect(testStruct.y).to(equal(@200));
        expect(testStruct.width).to(equal(@2000));
        expect(testStruct.height).to(equal(@3000));
    });

    it(@"Should return nil if not set", ^{
        SDLRectangle *testStruct = [[SDLRectangle alloc] init];

        expect(testStruct.x).to(beNil());
        expect(testStruct.y).to(beNil());
        expect(testStruct.width).to(beNil());
        expect(testStruct.height).to(beNil());
    });
});

QuickSpecEnd
