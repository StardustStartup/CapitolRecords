#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLImageResolution.h"
#import "SDLRPCParameterNames.h"

QuickSpecBegin(SDLImageResolutionSpec)

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLImageResolution *testStruct = [[SDLImageResolution alloc] init];

        testStruct.resolutionWidth = @245;
        testStruct.resolutionHeight = @42;

        expect(testStruct.resolutionHeight).to(equal(@42));
        expect(testStruct.resolutionWidth).to(equal(@245));
    });

    it(@"should correct initialize", ^{
        SDLImageResolution *testStruct = [[SDLImageResolution alloc] initWithWidth:1245 height:789];

        expect(testStruct.resolutionHeight).to(equal(@789));
        expect(testStruct.resolutionWidth).to(equal(@1245));
    });

    it(@"Should get correctly when initialized", ^ {
        NSDictionary *dict = @{SDLRPCParameterNameResolutionHeight:@69,
                                       SDLRPCParameterNameResolutionWidth:@869,
                                       };
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLImageResolution *testStruct = [[SDLImageResolution alloc] initWithDictionary:dict];
#pragma clang diagnostic pop

        expect(testStruct.resolutionWidth).to(equal(@869));
        expect(testStruct.resolutionHeight).to(equal(@69));
    });

    it(@"Should return nil if not set", ^ {
        SDLImageResolution *testStruct = [[SDLImageResolution alloc] init];

        expect(testStruct.resolutionHeight).to(beNil());
        expect(testStruct.resolutionWidth).to(beNil());
    });
});


QuickSpecEnd
