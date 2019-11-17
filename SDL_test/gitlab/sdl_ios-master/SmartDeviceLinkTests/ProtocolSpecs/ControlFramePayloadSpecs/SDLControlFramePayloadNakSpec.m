
#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLControlFramePayloadNak.h"

QuickSpecBegin(SDLControlFramePayloadNakSpec)

describe(@"Test encoding data", ^{
    __block SDLControlFramePayloadNak *testPayload = nil;
    __block NSArray<NSString *> *testParams = nil;

    context(@"with paramaters", ^{
        beforeEach(^{
            testParams = @[@"testParam1", @"testParam2"];
            testPayload = [[SDLControlFramePayloadNak alloc] initWithRejectedParams:testParams];
        });

        it(@"should create the correct data", ^{
            NSString *base64Encoded = [testPayload.data base64EncodedStringWithOptions:0];
            expect(base64Encoded).to(equal(@"PgAAAARyZWplY3RlZFBhcmFtcwApAAAAAjAACwAAAHRlc3RQYXJhbTEAAjEACwAAAHRlc3RQYXJhbTIAAAA="));
        });
    });

    context(@"without parameters", ^{
        beforeEach(^{
            testParams = nil;
            testPayload = [[SDLControlFramePayloadNak alloc] initWithRejectedParams:testParams];
        });

        it(@"should create no data", ^{
            expect(testPayload.data.length).to(equal(0));
        });
    });
});

describe(@"Test decoding data", ^{
    __block SDLControlFramePayloadNak *testPayload = nil;
    __block NSData *testData = nil;
    __block NSArray<NSString *> *testParams = nil;

    beforeEach(^{
        testParams = @[@"testParam1", @"testParam2"];

        SDLControlFramePayloadNak *firstPayload = [[SDLControlFramePayloadNak alloc] initWithRejectedParams:testParams];
        testData = firstPayload.data;

        testPayload = [[SDLControlFramePayloadNak alloc] initWithData:testData];
    });

    it(@"should output the correct params", ^{
        expect(testPayload.rejectedParams).to(equal(testParams));
    });
});

describe(@"Test nil data", ^{
    __block SDLControlFramePayloadNak *testPayload = nil;
    __block NSData *testData = nil;

    beforeEach(^{
        testPayload = [[SDLControlFramePayloadNak alloc] initWithData:testData];
    });

    it(@"should output the correct params", ^{
        expect(testPayload.rejectedParams).to(beNil());
    });
});


QuickSpecEnd
