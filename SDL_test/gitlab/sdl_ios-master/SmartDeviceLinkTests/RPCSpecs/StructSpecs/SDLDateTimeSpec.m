//
//  SDLDateTimeSpec.m
//  SmartDeviceLink-iOS
//
//  Created by Muller, Alexander (A.) on 11/1/16.
//  Copyright © 2016 smartdevicelink. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLDateTime.h"
#import "SDLRPCParameterNames.h"

QuickSpecBegin(SDLDateTimeSpec)

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLDateTime* testStruct = [[SDLDateTime alloc] init];
        
        testStruct.millisecond = @100;
        testStruct.second = @4;
        testStruct.minute = @12;
        testStruct.hour = @20;
        testStruct.day = @30;
        testStruct.month = @1;
        testStruct.year = @4000;
        testStruct.timezoneMinuteOffset = @0;
        testStruct.timezoneHourOffset = @1000;
        
        expect(testStruct.millisecond).to(equal(@100));
        expect(testStruct.second).to(equal(@4));
        expect(testStruct.minute).to(equal(@12));
        expect(testStruct.hour).to(equal(@20));
        expect(testStruct.day).to(equal(@30));
        expect(testStruct.month).to(equal(@1));
        expect(testStruct.year).to(equal(@4000));
        expect(testStruct.timezoneMinuteOffset).to(equal(@0));
        expect(testStruct.timezoneHourOffset).to(equal(@1000));
    });
    
    it(@"Should get correctly when initialized with dictionary", ^{
        NSMutableDictionary* dict = [@{SDLRPCParameterNameMillisecond:@100,
                                       SDLRPCParameterNameSecond:@4,
                                       SDLRPCParameterNameMinute:@12,
                                       SDLRPCParameterNameHour:@20,
                                       SDLRPCParameterNameDay:@30,
                                       SDLRPCParameterNameMonth:@1,
                                       SDLRPCParameterNameYear:@4000,
                                       SDLRPCParameterNameTimezoneMinuteOffset:@0,
                                       SDLRPCParameterNameTimezoneHourOffset:@1000} mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLDateTime* testStruct = [[SDLDateTime alloc] initWithDictionary:dict];
#pragma clang diagnostic pop
        
        expect(testStruct.millisecond).to(equal(@100));
        expect(testStruct.second).to(equal(@4));
        expect(testStruct.minute).to(equal(@12));
        expect(testStruct.hour).to(equal(@20));
        expect(testStruct.day).to(equal(@30));
        expect(testStruct.month).to(equal(@1));
        expect(testStruct.year).to(equal(@4000));
        expect(testStruct.timezoneMinuteOffset).to(equal(@0));
        expect(testStruct.timezoneHourOffset).to(equal(@1000));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLDateTime* testStruct = [[SDLDateTime alloc] init];
        
        expect(testStruct.millisecond).to(beNil());
        expect(testStruct.second).to(beNil());
        expect(testStruct.minute).to(beNil());
        expect(testStruct.hour).to(beNil());
        expect(testStruct.day).to(beNil());
        expect(testStruct.month).to(beNil());
        expect(testStruct.year).to(beNil());
        expect(testStruct.timezoneMinuteOffset).to(beNil());
        expect(testStruct.timezoneHourOffset).to(beNil());
    });
});

QuickSpecEnd
