//
//  SDLRDSDataSpec.m
//  SmartDeviceLink-iOS
//

#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLRDSData.h"
#import "SDLRPCParameterNames.h"

QuickSpecBegin(SDLRDSDataSpec)

describe(@"Initialization tests", ^{
    
    it(@"should properly initialize init", ^{
        SDLRDSData* testStruct = [[SDLRDSData alloc] init];

        expect(testStruct.programService).to(beNil());
        expect(testStruct.radioText).to(beNil());
        expect(testStruct.clockText).to(beNil());
        expect(testStruct.programIdentification).to(beNil());
        expect(testStruct.programType).to(beNil());
        expect(testStruct.trafficProgramIdentification).to(beNil());
        expect(testStruct.trafficAnnouncementIdentification).to(beNil());
        expect(testStruct.region).to(beNil());
    });
    
    it(@"should properly initialize initWithDictionary", ^{
        
        NSMutableDictionary* dict = [@{SDLRPCParameterNameProgramService : @"ps",
                                       SDLRPCParameterNameRadioText : @"rt",
                                       SDLRPCParameterNameClockText : @"2017-07-25T19:20:30-5:00",
                                       SDLRPCParameterNameProgramIdentification : @"pi",
                                       SDLRPCParameterNameProgramType : @5,
                                       SDLRPCParameterNameTrafficProgramIdentification : @NO,
                                       SDLRPCParameterNameTrafficAnnouncementIdentification : @YES,
                                       SDLRPCParameterNameRegion : @"reg"} mutableCopy];
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLRDSData* testStruct = [[SDLRDSData alloc] initWithDictionary:dict];
#pragma clang diagnostic pop

        expect(testStruct.programService).to(equal(@"ps"));
        expect(testStruct.radioText).to(equal(@"rt"));
        expect(testStruct.clockText).to(equal(@"2017-07-25T19:20:30-5:00"));
        expect(testStruct.programIdentification).to(equal(@"pi"));
        expect(testStruct.programType).to(equal(@5));
        expect(testStruct.trafficProgramIdentification).to(equal(@NO));
        expect(testStruct.trafficAnnouncementIdentification).to(equal(@YES));
        expect(testStruct.region).to(equal(@"reg"));
    });
    
    it(@"Should set and get correctly", ^{
        SDLRDSData* testStruct = [[SDLRDSData alloc] init];
        
        testStruct.programService = @"ps";
        testStruct.radioText = @"rt";
        testStruct.clockText = @"2017-07-25T19:20:30-5:00";
        testStruct.programIdentification = @"pi";
        testStruct.programType = @5;
        testStruct.trafficProgramIdentification = @NO;
        testStruct.trafficAnnouncementIdentification = @YES;
        testStruct.region = @"reg";
        
        expect(testStruct.programService).to(equal(@"ps"));
        expect(testStruct.radioText).to(equal(@"rt"));
        expect(testStruct.clockText).to(equal(@"2017-07-25T19:20:30-5:00"));
        expect(testStruct.programIdentification).to(equal(@"pi"));
        expect(testStruct.programType).to(equal(@5));
        expect(testStruct.trafficProgramIdentification).to(equal(@NO));
        expect(testStruct.trafficAnnouncementIdentification).to(equal(@YES));
        expect(testStruct.region).to(equal(@"reg"));
    });

    it(@"Should get correctly when initialized with Program serive and other RDS parameters", ^ {
        SDLRDSData* testStruct = [[SDLRDSData alloc] initWithProgramService:@"ps" radioText:@"rt" clockText:@"2017-07-25T19:20:30-5:00" programIdentification:@"pi" programType:@5 trafficProgramIdentification:@NO trafficAnnouncementIdentification:@YES region:@"reg"];

        expect(testStruct.programService).to(equal(@"ps"));
        expect(testStruct.radioText).to(equal(@"rt"));
        expect(testStruct.clockText).to(equal(@"2017-07-25T19:20:30-5:00"));
        expect(testStruct.programIdentification).to(equal(@"pi"));
        expect(testStruct.programType).to(equal(@5));
        expect(testStruct.trafficProgramIdentification).to(equal(@NO));
        expect(testStruct.trafficAnnouncementIdentification).to(equal(@YES));
        expect(testStruct.region).to(equal(@"reg"));
    });
});

QuickSpecEnd
