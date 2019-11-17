//
//  SDLTurnSpec.m
//  SmartDeviceLink


#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLTurn.h"
#import "SDLRPCParameterNames.h"
#import "SDLImage.h"

QuickSpecBegin(SDLTurnSpec)

SDLImage* image = [[SDLImage alloc] init];

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLTurn* testStruct = [[SDLTurn alloc] init];
        
        testStruct.navigationText = @"NAVTEXT";
        testStruct.turnIcon = image;
        
        expect(testStruct.navigationText).to(equal(@"NAVTEXT"));
        expect(testStruct.turnIcon).to(equal(image));
    });
    
    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary<NSString *, id> *dict = [@{SDLRPCParameterNameNavigationText:@"NAVTEXT",
                                                       SDLRPCParameterNameTurnIcon:image} mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLTurn* testStruct = [[SDLTurn alloc] initWithDictionary:dict];
#pragma clang diagnostic pop
        
        expect(testStruct.navigationText).to(equal(@"NAVTEXT"));
        expect(testStruct.turnIcon).to(equal(image));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLTurn* testStruct = [[SDLTurn alloc] init];
        
        expect(testStruct.navigationText).to(beNil());
        expect(testStruct.turnIcon).to(beNil());
    });
});

QuickSpecEnd
