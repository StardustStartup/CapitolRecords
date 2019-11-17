//
//  SDLSetInteriorVehicleDataResponseSpec.m
//  SmartDeviceLink-iOS
//

#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLSetInteriorVehicleDataResponse.h"
#import "SDLModuleData.h"
#import "SDLRPCParameterNames.h"
#import "SDLRPCFunctionNames.h"

QuickSpecBegin(SDLSetInteriorVehicleDataResponseSpec)

describe(@"Getter/Setter Tests", ^ {
    __block SDLModuleData* someModuleData = nil;
    
    beforeEach(^{
        someModuleData = [[SDLModuleData alloc] init];
    });
    
    it(@"Should set and get correctly", ^ {
        SDLSetInteriorVehicleDataResponse* testResponse = [[SDLSetInteriorVehicleDataResponse alloc] init];
        testResponse.moduleData = someModuleData;
        
        expect(testResponse.moduleData).to(equal(someModuleData));
    });
    
    
    
    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary<NSString *, id> *dict = [@{SDLRPCParameterNameResponse:
                                                           @{SDLRPCParameterNameParameters:
                                                                 @{SDLRPCParameterNameModuleData:someModuleData},
                                                             SDLRPCParameterNameOperationName:SDLRPCFunctionNameSetInteriorVehicleData}} mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLSetInteriorVehicleDataResponse* testResponse = [[SDLSetInteriorVehicleDataResponse alloc] initWithDictionary:dict];
#pragma clang diagnostic pop
        
        expect(testResponse.moduleData).to(equal(someModuleData));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLSetInteriorVehicleDataResponse* testResponse = [[SDLSetInteriorVehicleDataResponse alloc] init];
        
        expect(testResponse.moduleData).to(beNil());
    });
});

QuickSpecEnd
