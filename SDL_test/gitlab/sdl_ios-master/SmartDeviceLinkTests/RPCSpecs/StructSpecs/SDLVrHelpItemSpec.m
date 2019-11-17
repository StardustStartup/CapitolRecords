//
//  SDLVrHelpItemSpec.m
//  SmartDeviceLink


#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLImage.h"
#import "SDLRPCParameterNames.h"
#import "SDLVrHelpItem.h"


QuickSpecBegin(SDLVrHelpItemSpec)

SDLImage* image = [[SDLImage alloc] init];

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLVRHelpItem* testStruct = [[SDLVRHelpItem alloc] init];
        
        testStruct.text = @"DON'T PANIC";
        testStruct.image = image;
        testStruct.position = @42;
        
        expect(testStruct.text).to(equal(@"DON'T PANIC"));
        expect(testStruct.image).to(equal(image));
        expect(testStruct.position).to(equal(@42));
    });
    
    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary<NSString *, id> *dict = [@{SDLRPCParameterNameText:@"DON'T PANIC",
                                                       SDLRPCParameterNameImage:image,
                                                       SDLRPCParameterNamePosition:@42} mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLVRHelpItem* testStruct = [[SDLVRHelpItem alloc] initWithDictionary:dict];
#pragma clang diagnostic pop
        
        expect(testStruct.text).to(equal(@"DON'T PANIC"));
        expect(testStruct.image).to(equal(image));
        expect(testStruct.position).to(equal(@42));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLVRHelpItem* testStruct = [[SDLVRHelpItem alloc] init];
        
        expect(testStruct.text).to(beNil());
        expect(testStruct.image).to(beNil());
        expect(testStruct.position).to(beNil());
    });
});

QuickSpecEnd
