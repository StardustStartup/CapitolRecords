
#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLControlFramePayloadConstants.h"
#import "SDLControlFramePayloadRPCStartServiceAck.h"

QuickSpecBegin(SDLControlFramePayloadRPCStartServiceAckSpec)

describe(@"Test encoding data", ^{
    __block SDLControlFramePayloadRPCStartServiceAck *testPayload = nil;
    __block int32_t testHashId = 0;
    __block int64_t testMTU = 0;
    __block NSString *testProtocolVersion = nil;
    __block NSArray<NSString *> *testSecondaryTransports = nil;
    __block NSArray<NSNumber *> *testAudioServiceTransports = nil;
    __block NSArray<NSNumber *> *testVideoServiceTransports = nil;

    context(@"with parameters", ^{
        beforeEach(^{
            testHashId = 1457689;
            testMTU = 5984649;
            testProtocolVersion = @"1.32.32";

            testPayload = [[SDLControlFramePayloadRPCStartServiceAck alloc] initWithHashId:testHashId mtu:testMTU authToken:nil protocolVersion:testProtocolVersion secondaryTransports:nil audioServiceTransports:nil videoServiceTransports:nil];
        });

        it(@"should create the correct data", ^{
            NSString *base64Encoded = [testPayload.data base64EncodedStringWithOptions:0];
            expect(base64Encoded).to(equal(@"OwAAABBoYXNoSWQAGT4WABJtdHUAiVFbAAAAAAACcHJvdG9jb2xWZXJzaW9uAAgAAAAxLjMyLjMyAAA="));
        });
    });

    context(@"with secondary transport parameters", ^{
        beforeEach(^{
            testHashId = 987654;
            testMTU = 4096;
            testProtocolVersion = @"5.10.01";
            testSecondaryTransports = @[@"TCP_WIFI", @"IAP_USB"];
            testAudioServiceTransports = @[@(2)];
            testVideoServiceTransports = @[(@2), @(1)];

            testPayload = [[SDLControlFramePayloadRPCStartServiceAck alloc] initWithHashId:testHashId mtu:testMTU authToken:nil protocolVersion:testProtocolVersion secondaryTransports:testSecondaryTransports audioServiceTransports:testAudioServiceTransports videoServiceTransports:testVideoServiceTransports];
        });

        it(@"should create the correct data", ^{
            NSString *base64Encoded = [testPayload.data base64EncodedStringWithOptions:0];
            expect(base64Encoded).to(equal(@"wwAAAAR2aWRlb1NlcnZpY2VUcmFuc3BvcnRzABMAAAAQMAACAAAAEDEAAQAAAAAQaGFzaElkAAYSDwASbXR1AAAQAAAAAAAABHNlY29uZGFyeVRyYW5zcG9ydHMAJAAAAAIwAAkAAABUQ1BfV0lGSQACMQAIAAAASUFQX1VTQgAABGF1ZGlvU2VydmljZVRyYW5zcG9ydHMADAAAABAwAAIAAAAAAnByb3RvY29sVmVyc2lvbgAIAAAANS4xMC4wMQAA"));
        });
    });

    context(@"without parameters", ^{
        beforeEach(^{
            testHashId = SDLControlFrameInt32NotFound;
            testMTU = SDLControlFrameInt64NotFound;

            testPayload = [[SDLControlFramePayloadRPCStartServiceAck alloc] initWithHashId:testHashId mtu:testMTU authToken:nil protocolVersion:nil secondaryTransports:nil audioServiceTransports:nil videoServiceTransports:nil];
        });

        it(@"should create no data", ^{
            expect(testPayload.data.length).to(equal(0));
        });
    });
});

describe(@"Test decoding data", ^{
    __block SDLControlFramePayloadRPCStartServiceAck *testPayload = nil;
    __block NSData *testData = nil;
    __block int32_t testHashId = 0;
    __block int64_t testMTU = 0;
    __block NSString *testAuthToken = nil;
    __block NSString *testProtocolVersion = nil;
    __block NSArray<NSString *> *testSecondaryTransports = nil;
    __block NSArray<NSNumber *> *testAudioServiceTransports = nil;
    __block NSArray<NSNumber *> *testVideoServiceTransports = nil;

    context(@"with parameters", ^{
        beforeEach(^{
            testHashId = 1545784;
            testMTU = 989786483;
            testAuthToken = @"testAuthToken";
            testProtocolVersion = @"3.89.5";

            SDLControlFramePayloadRPCStartServiceAck *firstPayload = [[SDLControlFramePayloadRPCStartServiceAck alloc] initWithHashId:testHashId mtu:testMTU authToken:testAuthToken protocolVersion:testProtocolVersion secondaryTransports:nil audioServiceTransports:nil videoServiceTransports:nil];
            testData = firstPayload.data;

            testPayload = [[SDLControlFramePayloadRPCStartServiceAck alloc] initWithData:testData];
        });

        it(@"should output the correct params", ^{
            expect(testPayload.hashId).to(equal(testHashId));
            expect(testPayload.mtu).to(equal(testMTU));
            expect(testPayload.authToken).to(equal(testAuthToken));
            expect(testPayload.protocolVersion).to(equal(testProtocolVersion));
            expect(testPayload.secondaryTransports).to(beNil());
            expect(testPayload.audioServiceTransports).to(beNil());
            expect(testPayload.videoServiceTransports).to(beNil());
        });
    });

    context(@"with secondary transport parameters", ^{
        beforeEach(^{
            testHashId = 17999024;
            testMTU = 1798250;
            testAuthToken = @"testAuthToken";
            testProtocolVersion = @"6.01.00";
            testSecondaryTransports = @[@"TCP_WIFI"];
            testAudioServiceTransports = @[@(2), @(1)];
            testVideoServiceTransports = @[@(1)];

            SDLControlFramePayloadRPCStartServiceAck *firstPayload = [[SDLControlFramePayloadRPCStartServiceAck alloc] initWithHashId:testHashId mtu:testMTU authToken:testAuthToken protocolVersion:testProtocolVersion secondaryTransports:testSecondaryTransports audioServiceTransports:testAudioServiceTransports videoServiceTransports:testVideoServiceTransports];
            testData = firstPayload.data;

            testPayload = [[SDLControlFramePayloadRPCStartServiceAck alloc] initWithData:testData];
        });

        it(@"should output the correct params", ^{
            expect(testPayload.hashId).to(equal(testHashId));
            expect(testPayload.mtu).to(equal(testMTU));
            expect(testPayload.authToken).to(equal(testAuthToken));
            expect(testPayload.protocolVersion).to(equal(testProtocolVersion));
            expect(testPayload.secondaryTransports).to(equal(testSecondaryTransports));
            expect(testPayload.audioServiceTransports).to(equal(testAudioServiceTransports));
            expect(testPayload.videoServiceTransports).to(equal(testVideoServiceTransports));
        });
    });
});

describe(@"Test nil data", ^{
    __block SDLControlFramePayloadRPCStartServiceAck *testPayload = nil;
    __block NSData *testData = nil;

    beforeEach(^{
        testPayload = [[SDLControlFramePayloadRPCStartServiceAck alloc] initWithData:testData];
    });

    it(@"should output the correct params", ^{
        expect(testPayload.data.length).to(equal(0));
    });
});

QuickSpecEnd
