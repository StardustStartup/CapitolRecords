//
//  SDLVideoStreamingFormatSpec.m
//  SmartDeviceLink-iOS
//
//  Created by Brett McIsaac on 7/28/17.
//  Copyright © 2017 smartdevicelink. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLRPCParameterNames.h"
#import "SDLVideoStreamingCodec.h"
#import "SDLVideoStreamingFormat.h"
#import "SDLVideoStreamingProtocol.h"

QuickSpecBegin(SDLVideoStreamingFormatSpec)

describe(@"Initialization tests", ^{
    it(@"Should get correctly when initialized with a dictionary", ^ {
        NSMutableDictionary* dict = [@{SDLRPCParameterNameVideoProtocol: SDLVideoStreamingProtocolRAW,
                                       SDLRPCParameterNameVideoCodec: SDLVideoStreamingCodecH264} mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLVideoStreamingFormat* testStruct = [[SDLVideoStreamingFormat alloc] initWithDictionary:dict];
#pragma clang diagnostic pop

        expect(testStruct.protocol).to(equal(SDLVideoStreamingProtocolRAW));
        expect(testStruct.codec).to(equal(SDLVideoStreamingCodecH264));
    });

    it(@"Should return nil if not set", ^ {
        SDLVideoStreamingFormat* testStruct = [[SDLVideoStreamingFormat alloc] init];

        expect(testStruct.protocol).to(beNil());
        expect(testStruct.codec).to(beNil());
    });
});

QuickSpecEnd
