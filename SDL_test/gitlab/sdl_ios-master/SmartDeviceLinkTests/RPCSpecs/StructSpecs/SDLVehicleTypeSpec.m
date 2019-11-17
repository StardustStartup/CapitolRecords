//
//  SDLVehicleTypeSpec.m
//  SmartDeviceLink


#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLVehicleType.h"
#import "SDLRPCParameterNames.h"

QuickSpecBegin(SDLVehicleTypeSpec)

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLVehicleType* testStruct = [[SDLVehicleType alloc] init];
        
        testStruct.make = @"Make";
        testStruct.model = @"Model";
        testStruct.modelYear = @"3.141*10^36";
        testStruct.trim = @"AE";
        
        expect(testStruct.make).to(equal(@"Make"));
        expect(testStruct.model).to(equal(@"Model"));
        expect(testStruct.modelYear).to(equal(@"3.141*10^36"));
        expect(testStruct.trim).to(equal(@"AE"));
    });
    
    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary<NSString *, id> *dict = [@{SDLRPCParameterNameMake:@"Make",
                                                       SDLRPCParameterNameModel:@"Model",
                                                       SDLRPCParameterNameModelYear:@"3.141*10^36",
                                                       SDLRPCParameterNameTrim:@"AE"} mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLVehicleType* testStruct = [[SDLVehicleType alloc] initWithDictionary:dict];
#pragma clang diagnostic pop
        
        expect(testStruct.make).to(equal(@"Make"));
        expect(testStruct.model).to(equal(@"Model"));
        expect(testStruct.modelYear).to(equal(@"3.141*10^36"));
        expect(testStruct.trim).to(equal(@"AE"));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLVehicleType* testStruct = [[SDLVehicleType alloc] init];
        
        expect(testStruct.make).to(beNil());
        expect(testStruct.model).to(beNil());
        expect(testStruct.modelYear).to(beNil());
        expect(testStruct.trim).to(beNil());
    });
});

QuickSpecEnd
