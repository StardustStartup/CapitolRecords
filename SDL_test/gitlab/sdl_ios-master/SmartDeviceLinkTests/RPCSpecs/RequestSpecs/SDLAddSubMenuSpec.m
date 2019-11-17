//
//  SDLAddSubMenuSpec.m
//  SmartDeviceLink


#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLAddSubMenu.h"
#import "SDLImage.h"
#import "SDLRPCParameterNames.h"
#import "SDLRPCFunctionNames.h"

QuickSpecBegin(SDLAddSubMenuSpec)

describe(@"Getter/Setter Tests", ^ {
    __block UInt32 menuId = 4345645;
    __block UInt8 position = 27;
    __block NSString *menuName = @"Welcome to the menu";
    __block SDLImage *image = nil;
    __block SDLMenuLayout testLayout = SDLMenuLayoutList;

    beforeEach(^{
        image = [[SDLImage alloc] initWithName:@"Test" isTemplate:false];
    });

    it(@"should correctly initialize with initWithId:menuName:", ^{
        SDLAddSubMenu *testRequest = [[SDLAddSubMenu alloc] initWithId:menuId menuName:menuName];

        expect(testRequest.menuID).to(equal(@(menuId)));
        expect(testRequest.position).to(beNil());
        expect(testRequest.menuName).to(equal(menuName));
        expect(testRequest.menuIcon).to(beNil());
    });

    it(@"should correctly initialize with initWithId:menuName:position:", ^{
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLAddSubMenu *testRequest = [[SDLAddSubMenu alloc] initWithId:menuId menuName:menuName position:position];

        expect(testRequest.menuID).to(equal(@(menuId)));
        expect(testRequest.position).to(equal(@(position)));
        expect(testRequest.menuName).to(equal(menuName));
        expect(testRequest.menuIcon).to(beNil());
        #pragma clang diagnostic pop
    });

    it(@"should correctly initialize with initWithId:menuName:menuIcon:position:", ^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLAddSubMenu *testRequest = [[SDLAddSubMenu alloc] initWithId:menuId menuName:menuName menuIcon:image position:position];

        expect(testRequest.menuID).to(equal(@(menuId)));
        expect(testRequest.position).to(equal(@(position)));
        expect(testRequest.menuName).to(equal(menuName));
        expect(testRequest.menuIcon).to(equal(image));
#pragma clang diagnostic pop
    });

    it(@"should correctly initialize with initWithId:menuName:menuLayout:menuIcon:position:", ^{
        SDLAddSubMenu *testRequest = [[SDLAddSubMenu alloc] initWithId:menuId menuName:menuName menuLayout:testLayout menuIcon:image position:position];

        expect(testRequest.menuID).to(equal(@(menuId)));
        expect(testRequest.position).to(equal(@(position)));
        expect(testRequest.menuName).to(equal(menuName));
        expect(testRequest.menuIcon).to(equal(image));
        expect(testRequest.menuLayout).to(equal(testLayout));
    });

    it(@"Should set and get correctly", ^ {
        SDLAddSubMenu* testRequest = [[SDLAddSubMenu alloc] init];
        
        testRequest.menuID = @4345645;
        testRequest.position = @27;
        testRequest.menuName = @"Welcome to the menu";
        testRequest.menuIcon = image;
        testRequest.menuLayout = testLayout;
        
        expect(testRequest.menuID).to(equal(@(menuId)));
        expect(testRequest.position).to(equal(@(position)));
        expect(testRequest.menuName).to(equal(menuName));
        expect(testRequest.menuIcon).to(equal(image));
        expect(testRequest.menuLayout).to(equal(testLayout));
    });
    
    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary<NSString *, id> *dict = [@{SDLRPCParameterNameRequest:
                                                           @{SDLRPCParameterNameParameters:
                                                                 @{SDLRPCParameterNameMenuId:@4345645,
                                                                   SDLRPCParameterNamePosition:@27,
                                                                   SDLRPCParameterNameMenuName:@"Welcome to the menu",
                                                                   SDLRPCParameterNameMenuIcon: @{
                                                                           SDLRPCParameterNameValue: @"Test"
                                                                           },
                                                                   SDLRPCParameterNameMenuLayout: testLayout
                                                                   },
                                                             SDLRPCParameterNameOperationName:SDLRPCFunctionNameAddSubMenu}} mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLAddSubMenu* testRequest = [[SDLAddSubMenu alloc] initWithDictionary:dict];
#pragma clang diagnostic pop

        expect(testRequest.menuID).to(equal(@(menuId)));
        expect(testRequest.position).to(equal(@(position)));
        expect(testRequest.menuName).to(equal(menuName));
        expect(testRequest.menuIcon.value).to(equal(@"Test"));
        expect(testRequest.menuLayout).to(equal(testLayout));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLAddSubMenu* testRequest = [[SDLAddSubMenu alloc] init];
        
        expect(testRequest.menuID).to(beNil());
        expect(testRequest.position).to(beNil());
        expect(testRequest.menuName).to(beNil());
        expect(testRequest.menuIcon).to(beNil());
        expect(testRequest.menuLayout).to(beNil());
    });
});

QuickSpecEnd
