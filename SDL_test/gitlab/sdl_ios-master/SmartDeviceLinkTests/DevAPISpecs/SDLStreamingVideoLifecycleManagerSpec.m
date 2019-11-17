#import <Quick/Quick.h>
#import <Nimble/Nimble.h>
#import <OCMock/OCMock.h>

#import "SDLCarWindow.h"
#import "SDLCarWindowViewController.h"
#import "SDLConfiguration.h"
#import "SDLControlFramePayloadConstants.h"
#import "SDLControlFramePayloadNak.h"
#import "SDLControlFramePayloadVideoStartService.h"
#import "SDLControlFramePayloadVideoStartServiceAck.h"
#import "SDLDisplayCapabilities.h"
#import "SDLFakeStreamingManagerDataSource.h"
#import "SDLFileManagerConfiguration.h"
#import "SDLFocusableItemLocator.h"
#import "SDLGetSystemCapability.h"
#import "SDLGetSystemCapabilityResponse.h"
#import "SDLGenericResponse.h"
#import "SDLGlobals.h"
#import "SDLHMILevel.h"
#import "SDLImageResolution.h"
#import "SDLLifecycleConfiguration.h"
#import "SDLLockScreenConfiguration.h"
#import "SDLLogConfiguration.h"
#import "SDLOnHMIStatus.h"
#import "SDLProtocol.h"
#import "SDLRegisterAppInterfaceResponse.h"
#import "SDLRPCNotificationNotification.h"
#import "SDLRPCResponseNotification.h"
#import "SDLScreenParams.h"
#import "SDLStateMachine.h"
#import "SDLStreamingMediaConfiguration.h"
#import "SDLStreamingVideoLifecycleManager.h"
#import "SDLStreamingVideoScaleManager.h"
#import "SDLSystemCapability.h"
#import "SDLV2ProtocolHeader.h"
#import "SDLV2ProtocolMessage.h"
#import "SDLVideoStreamingCapability.h"
#import "SDLVideoStreamingState.h"
#import "TestConnectionManager.h"
#import "SDLVersion.h"
#import "SDLHMICapabilities.h"

@interface SDLStreamingVideoLifecycleManager ()
@property (copy, nonatomic, readonly) NSString *appName;
@property (copy, nonatomic, readonly) NSString *videoStreamBackgroundString;
@end

QuickSpecBegin(SDLStreamingVideoLifecycleManagerSpec)

describe(@"the streaming video manager", ^{
    __block SDLStreamingVideoLifecycleManager *streamingLifecycleManager = nil;
    __block SDLStreamingMediaConfiguration *testConfiguration = [SDLStreamingMediaConfiguration insecureConfiguration];
    __block SDLCarWindowViewController *testViewController = [[SDLCarWindowViewController alloc] init];
    __block SDLFakeStreamingManagerDataSource *testDataSource = [[SDLFakeStreamingManagerDataSource alloc] init];
    __block TestConnectionManager *testConnectionManager = nil;
    __block NSString *testAppName = @"Test App";
    __block SDLLifecycleConfiguration *testLifecycleConfiguration = [SDLLifecycleConfiguration defaultConfigurationWithAppName:testAppName fullAppId:@""];

    __block SDLConfiguration *testConfig = nil;

    __block void (^sendNotificationForHMILevel)(SDLHMILevel hmiLevel, SDLVideoStreamingState streamState) = ^(SDLHMILevel hmiLevel, SDLVideoStreamingState streamState) {
        SDLOnHMIStatus *hmiStatus = [[SDLOnHMIStatus alloc] init];
        hmiStatus.hmiLevel = hmiLevel;
        hmiStatus.videoStreamingState = streamState;
        SDLRPCNotificationNotification *notification = [[SDLRPCNotificationNotification alloc] initWithName:SDLDidChangeHMIStatusNotification object:self rpcNotification:hmiStatus];
        [[NSNotificationCenter defaultCenter] postNotification:notification];

        [NSThread sleepForTimeInterval:0.3];
    };

    beforeEach(^{
        testConfiguration.customVideoEncoderSettings = @{
                                                         (__bridge NSString *)kVTCompressionPropertyKey_ExpectedFrameRate : @1
                                                         };
        testConfiguration.dataSource = testDataSource;
        testConfiguration.rootViewController = testViewController;
        testConnectionManager = [[TestConnectionManager alloc] init];

        testLifecycleConfiguration.appType = SDLAppHMITypeNavigation;

        testConfig = [SDLConfiguration configurationWithLifecycle:testLifecycleConfiguration lockScreen:SDLLockScreenConfiguration.enabledConfiguration logging:SDLLogConfiguration.debugConfiguration streamingMedia:testConfiguration fileManager:SDLFileManagerConfiguration.defaultConfiguration];

        streamingLifecycleManager = [[SDLStreamingVideoLifecycleManager alloc] initWithConnectionManager:testConnectionManager configuration:testConfig];
    });

    it(@"should initialize properties", ^{
        expect(streamingLifecycleManager.videoScaleManager.scale).to(equal([[SDLStreamingVideoScaleManager alloc] init].scale));
        expect(streamingLifecycleManager.touchManager).toNot(beNil());
        expect(streamingLifecycleManager.focusableItemManager).toNot(beNil());
        expect(@(streamingLifecycleManager.isStreamingSupported)).to(equal(@NO));
        expect(@(streamingLifecycleManager.isVideoConnected)).to(equal(@NO));
        expect(@(streamingLifecycleManager.isVideoEncrypted)).to(equal(@NO));
        expect(@(streamingLifecycleManager.isVideoStreamingPaused)).to(equal(@YES));
        expect(@(CGSizeEqualToSize(streamingLifecycleManager.videoScaleManager.displayViewportResolution, CGSizeZero))).to(equal(@YES));
        expect(@(streamingLifecycleManager.pixelBufferPool == NULL)).to(equal(@YES));
        expect(@(streamingLifecycleManager.requestedEncryptionType)).to(equal(@(SDLStreamingEncryptionFlagNone)));
        expect(@(streamingLifecycleManager.showVideoBackgroundDisplay)).to(equal(@YES));
        expect(streamingLifecycleManager.currentAppState).to(equal(SDLAppStateActive));
        expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateStopped));
        expect(streamingLifecycleManager.videoFormat).to(beNil());
        expect(streamingLifecycleManager.dataSource).to(equal(testDataSource));
        expect(streamingLifecycleManager.supportedFormats).to(haveCount(2));
        expect(streamingLifecycleManager.preferredFormats).to(beNil());
        expect(streamingLifecycleManager.preferredResolutions).to(beNil());
        expect(streamingLifecycleManager.preferredFormatIndex).to(equal(0));
        expect(streamingLifecycleManager.preferredResolutionIndex).to(equal(0));
    });

    describe(@"when started", ^{
        __block BOOL readyHandlerSuccess = NO;
        __block NSError *readyHandlerError = nil;

        __block SDLProtocol *protocolMock = OCMClassMock([SDLProtocol class]);

        beforeEach(^{
            readyHandlerSuccess = NO;
            readyHandlerError = nil;

            [streamingLifecycleManager startWithProtocol:protocolMock];
        });

        it(@"should be ready to stream", ^{
            expect(@(streamingLifecycleManager.isStreamingSupported)).to(equal(@NO));
            expect(@(streamingLifecycleManager.isVideoConnected)).to(equal(@NO));
            expect(@(streamingLifecycleManager.isVideoEncrypted)).to(equal(@NO));
            expect(@(streamingLifecycleManager.isVideoStreamingPaused)).to(equal(@YES));
            expect(@(CGSizeEqualToSize(streamingLifecycleManager.videoScaleManager.displayViewportResolution, CGSizeZero))).to(equal(@YES));
            expect(@(streamingLifecycleManager.pixelBufferPool == NULL)).to(equal(@YES));
            expect(streamingLifecycleManager.currentAppState).to(equal(SDLAppStateActive));
            expect(streamingLifecycleManager.currentVideoStreamState).to(match(SDLVideoStreamManagerStateStopped));
        });

        describe(@"after receiving a register app interface notification", ^{
            __block SDLRegisterAppInterfaceResponse *someRegisterAppInterfaceResponse = nil;
            __block SDLDisplayCapabilities *someDisplayCapabilities = nil;
            __block SDLScreenParams *someScreenParams = nil;
            __block SDLImageResolution *someImageResolution = nil;
            __block SDLHMICapabilities *someHMICapabilities = nil;

            beforeEach(^{
                someImageResolution = [[SDLImageResolution alloc] init];
                someImageResolution.resolutionWidth = @(600);
                someImageResolution.resolutionHeight = @(100);

                someScreenParams = [[SDLScreenParams alloc] init];
                someScreenParams.resolution = someImageResolution;
            });

            context(@"that does not support video streaming", ^{
                beforeEach(^{
                    SDLVersion *version = [SDLVersion versionWithMajor:6 minor:0 patch:0];
                    id globalMock = OCMPartialMock([SDLGlobals sharedGlobals]);
                    OCMStub([globalMock rpcVersion]).andReturn(version);

                    someHMICapabilities = [[SDLHMICapabilities alloc] init];
                    someHMICapabilities.videoStreaming = @NO;

                    someRegisterAppInterfaceResponse = [[SDLRegisterAppInterfaceResponse alloc] init];
                    someRegisterAppInterfaceResponse.hmiCapabilities = someHMICapabilities;

                    SDLRPCResponseNotification *notification = [[SDLRPCResponseNotification alloc] initWithName:SDLDidReceiveRegisterAppInterfaceResponse object:self rpcResponse:someRegisterAppInterfaceResponse];

                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    [NSThread sleepForTimeInterval:0.1];
                });

                it(@"should not support streaming", ^{
                    expect(@(streamingLifecycleManager.isStreamingSupported)).to(equal(@NO));
                });
            });

            context(@"that supports video streaming", ^{
                beforeEach(^{
                    SDLVersion *version = [SDLVersion versionWithMajor:6 minor:0 patch:0];
                    id globalMock = OCMPartialMock([SDLGlobals sharedGlobals]);
                    OCMStub([globalMock rpcVersion]).andReturn(version);

                    someHMICapabilities = [[SDLHMICapabilities alloc] init];
                    someHMICapabilities.videoStreaming = @YES;

                    someDisplayCapabilities = [[SDLDisplayCapabilities alloc] init];
                    someDisplayCapabilities.screenParams = someScreenParams;

                    someRegisterAppInterfaceResponse = [[SDLRegisterAppInterfaceResponse alloc] init];
                    someRegisterAppInterfaceResponse.hmiCapabilities = someHMICapabilities;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
                    someRegisterAppInterfaceResponse.displayCapabilities = someDisplayCapabilities;
#pragma clang diagnostic pop

                    SDLRPCResponseNotification *notification = [[SDLRPCResponseNotification alloc] initWithName:SDLDidReceiveRegisterAppInterfaceResponse object:self rpcResponse:someRegisterAppInterfaceResponse];

                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    [NSThread sleepForTimeInterval:0.1];
                });

                it(@"should support streaming", ^{
                    expect(@(streamingLifecycleManager.isStreamingSupported)).to(equal(@YES));
                    expect(@(CGSizeEqualToSize(streamingLifecycleManager.videoScaleManager.displayViewportResolution, CGSizeMake(600, 100)))).to(equal(@YES));
                });
            });

            context(@"version is less then 4.5.0", ^{
                beforeEach(^{
                    SDLVersion *version = [SDLVersion versionWithMajor:4 minor:0 patch:0];
                    id globalMock = OCMPartialMock([SDLGlobals sharedGlobals]);
                    OCMStub([globalMock rpcVersion]).andReturn(version);

                    someDisplayCapabilities = [[SDLDisplayCapabilities alloc] init];
                    someDisplayCapabilities.screenParams = someScreenParams;

                    someRegisterAppInterfaceResponse = [[SDLRegisterAppInterfaceResponse alloc] init];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated"
                    someRegisterAppInterfaceResponse.displayCapabilities = someDisplayCapabilities;
#pragma clang diagnostic pop
                    SDLRPCResponseNotification *notification = [[SDLRPCResponseNotification alloc] initWithName:SDLDidReceiveRegisterAppInterfaceResponse object:self rpcResponse:someRegisterAppInterfaceResponse];

                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    [NSThread sleepForTimeInterval:0.1];
                });

                it(@"should support streaming even though hmiCapabilities.videoStreaming is nil", ^{
                    expect(@(streamingLifecycleManager.isStreamingSupported)).to(equal(@YES));
                    expect(@(CGSizeEqualToSize(streamingLifecycleManager.videoScaleManager.displayViewportResolution, CGSizeMake(600, 100)))).to(equal(@YES));
                });
            });
        });

        describe(@"if the app state is active", ^{
            __block SDLStreamingVideoLifecycleManager *streamStub = nil;

            beforeEach(^{
                streamStub = OCMPartialMock(streamingLifecycleManager);
                OCMStub([streamStub isStreamingSupported]).andReturn(YES);

                [streamingLifecycleManager.appStateMachine setToState:SDLAppStateActive fromOldState:nil callEnterTransition:NO];
            });

            context(@"and the stream is open", ^{
                beforeEach(^{
                    [streamingLifecycleManager.videoStreamStateMachine setToState:SDLVideoStreamManagerStateReady fromOldState:nil callEnterTransition:NO];
                });

                context(@"and the hmi state is limited", ^{
                    beforeEach(^{
                        streamingLifecycleManager.hmiLevel = SDLHMILevelLimited;
                    });

                    describe(@"and the hmi state changes to", ^{
                        context(@"none", ^{
                            beforeEach(^{
                                sendNotificationForHMILevel(SDLHMILevelNone, SDLVideoStreamingStateStreamable);
                            });

                            it(@"should close the stream", ^{
                                expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateShuttingDown));
                            });
                        });

                        context(@"background", ^{
                            beforeEach(^{
                                sendNotificationForHMILevel(SDLHMILevelBackground, SDLVideoStreamingStateStreamable);
                            });

                            it(@"should close the stream", ^{
                                expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateShuttingDown));
                            });
                        });

                        context(@"limited", ^{
                            beforeEach(^{
                                sendNotificationForHMILevel(SDLHMILevelLimited, SDLVideoStreamingStateStreamable);
                            });

                            it(@"should not close the stream", ^{
                                expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateReady));
                            });
                        });

                        context(@"full", ^{
                            beforeEach(^{
                                sendNotificationForHMILevel(SDLHMILevelFull, SDLVideoStreamingStateStreamable);
                            });

                            it(@"should not close the stream", ^{
                                expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateReady));
                            });
                        });

                        context(@"full but not streamable", ^{
                            beforeEach(^{
                                sendNotificationForHMILevel(SDLHMILevelFull, SDLVideoStreamingStateNotStreamable);
                            });

                            it(@"should close the stream", ^{
                                expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateShuttingDown));
                            });
                        });
                    });

                    describe(@"and the app state changes to", ^{
                        context(@"inactive", ^{
                            beforeEach(^{
                                [streamingLifecycleManager.appStateMachine setToState:SDLAppStateInactive fromOldState:nil callEnterTransition:YES];
                            });

                            it(@"should suspend the video stream", ^{
                                expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateSuspended));
                            });
                        });
                    });
                });

                context(@"and the hmi state is full", ^{
                    beforeEach(^{
                        streamingLifecycleManager.hmiLevel = SDLHMILevelFull;
                    });

                    context(@"and hmi state changes to none", ^{
                        beforeEach(^{
                            sendNotificationForHMILevel(SDLHMILevelNone, SDLVideoStreamingStateStreamable);
                        });

                        it(@"should close the streams", ^{
                            expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateShuttingDown));
                        });
                    });

                    context(@"and hmi state changes to background", ^{
                        beforeEach(^{
                            sendNotificationForHMILevel(SDLHMILevelBackground, SDLVideoStreamingStateStreamable);
                        });

                        it(@"should close the stream", ^{
                            expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateShuttingDown));
                        });
                    });

                    context(@"and hmi state changes to limited", ^{
                        beforeEach(^{
                            sendNotificationForHMILevel(SDLHMILevelLimited, SDLVideoStreamingStateStreamable);
                        });

                        it(@"should not close the stream", ^{
                            expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateReady));
                        });
                    });

                    context(@"and hmi state changes to full", ^{
                        beforeEach(^{
                            sendNotificationForHMILevel(SDLHMILevelFull, SDLVideoStreamingStateStreamable);
                        });

                        it(@"should not close the stream", ^{
                            expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateReady));
                        });
                    });

                    context(@"full but not streamable", ^{
                        beforeEach(^{
                            sendNotificationForHMILevel(SDLHMILevelFull, SDLVideoStreamingStateNotStreamable);
                        });

                        it(@"should close the stream", ^{
                            expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateShuttingDown));
                        });
                    });

                    context(@"and hmi state changes to background after app becomes inactive", ^{
                        beforeEach(^{
                            [streamingLifecycleManager.appStateMachine setToState:SDLAppStateInactive fromOldState:nil callEnterTransition:YES];
                            sendNotificationForHMILevel(SDLHMILevelBackground, SDLVideoStreamingStateNotStreamable);
                        });

                        it(@"should close the stream", ^{
                            expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateShuttingDown));
                        });
                    });

                    context(@"and hmi state changes to background after app becomes inactive", ^{
                        beforeEach(^{
                            [streamingLifecycleManager.appStateMachine setToState:SDLAppStateInactive fromOldState:nil callEnterTransition:YES];
                            sendNotificationForHMILevel(SDLHMILevelBackground, SDLVideoStreamingStateNotStreamable);
                        });

                        it(@"should close the stream", ^{
                            expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateShuttingDown));
                        });
                    });
                });
            });

            context(@"and both streams are closed", ^{
                beforeEach(^{
                    [streamingLifecycleManager.videoStreamStateMachine setToState:SDLVideoStreamManagerStateStopped fromOldState:nil callEnterTransition:NO];
                });

                context(@"and the hmi state is none", ^{
                    beforeEach(^{
                        streamingLifecycleManager.hmiLevel = SDLHMILevelNone;
                    });

                    context(@"and hmi state changes to none", ^{
                        beforeEach(^{
                            sendNotificationForHMILevel(SDLHMILevelNone, SDLVideoStreamingStateStreamable);
                        });

                        it(@"should not start the stream", ^{
                            expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateStopped));
                        });
                    });

                    context(@"and hmi state changes to background", ^{
                        beforeEach(^{
                            sendNotificationForHMILevel(SDLHMILevelBackground, SDLVideoStreamingStateStreamable);
                        });

                        it(@"should not start the stream", ^{
                            expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateStopped));
                        });
                    });

                    context(@"and hmi state changes to limited", ^{
                        beforeEach(^{
                            sendNotificationForHMILevel(SDLHMILevelLimited, SDLVideoStreamingStateStreamable);
                        });

                        it(@"should start the streams", ^{
                            expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateStarting));
                        });
                    });

                    context(@"and hmi state changes to full", ^{
                        beforeEach(^{
                            sendNotificationForHMILevel(SDLHMILevelFull, SDLVideoStreamingStateStreamable);
                        });

                        it(@"should start the streams", ^{
                            expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateStarting));
                        });
                    });

                    context(@"full but not streamable", ^{
                        beforeEach(^{
                            sendNotificationForHMILevel(SDLHMILevelFull, SDLVideoStreamingStateNotStreamable);
                        });

                        it(@"should not start the stream", ^{
                            expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateStopped));
                        });
                    });
                });
            });
        });

        describe(@"sending a video capabilities request", ^{
            __block SDLImageResolution *resolution = [[SDLImageResolution alloc] initWithWidth:42 height:69];
            __block int32_t maxBitrate = 12345;
            __block NSArray<SDLVideoStreamingFormat *> *testFormats = @[[[SDLVideoStreamingFormat alloc] initWithCodec:SDLVideoStreamingCodecH265 protocol:SDLVideoStreamingProtocolRTMP], [[SDLVideoStreamingFormat alloc] initWithCodec:SDLVideoStreamingCodecH264 protocol:SDLVideoStreamingProtocolRTP]];
            __block BOOL testHapticsSupported = YES;

            beforeEach(^{
                [streamingLifecycleManager.videoStreamStateMachine setToState:SDLVideoStreamManagerStateStarting fromOldState:nil callEnterTransition:YES];
            });

            it(@"should send out a video capabilities request", ^{
                expect(testConnectionManager.receivedRequests.lastObject).to(beAnInstanceOf([SDLGetSystemCapability class]));

                SDLGetSystemCapability *getCapability = (SDLGetSystemCapability *)testConnectionManager.receivedRequests.lastObject;
                expect(getCapability.systemCapabilityType).to(equal(SDLSystemCapabilityTypeVideoStreaming));
            });

            describe(@"after sending GetSystemCapabilities", ^{
                context(@"and receiving an error response", ^{
                    // This happens if the HU doesn't understand GetSystemCapabilities
                    beforeEach(^{
                        SDLGenericResponse *genericResponse = [[SDLGenericResponse alloc] init];
                        genericResponse.resultCode = SDLResultInvalidData;

                        [testConnectionManager respondToLastRequestWithResponse:genericResponse];
                    });

                    it(@"should have correct format and resolution", ^{
                        expect(streamingLifecycleManager.preferredFormats).to(haveCount(1));
                        expect(streamingLifecycleManager.preferredFormats.firstObject.codec).to(equal(SDLVideoStreamingCodecH264));
                        expect(streamingLifecycleManager.preferredFormats.firstObject.protocol).to(equal(SDLVideoStreamingProtocolRAW));

                        expect(streamingLifecycleManager.preferredResolutions).to(haveCount(1));
                        expect(streamingLifecycleManager.preferredResolutions.firstObject.resolutionWidth).to(equal(0));
                        expect(streamingLifecycleManager.preferredResolutions.firstObject.resolutionHeight).to(equal(0));
                    });

                    context(@"and receiving a response", ^{
                        __block SDLVideoStreamingCapability *testVideoStreamingCapability = nil;

                        beforeEach(^{
                            SDLGetSystemCapabilityResponse *response = [[SDLGetSystemCapabilityResponse alloc] init];
                            response.success = @YES;
                            response.systemCapability = [[SDLSystemCapability alloc] init];
                            response.systemCapability.systemCapabilityType = SDLSystemCapabilityTypeVideoStreaming;

                            testVideoStreamingCapability = [[SDLVideoStreamingCapability alloc] initWithPreferredResolution:resolution maxBitrate:maxBitrate supportedFormats:testFormats hapticDataSupported:testHapticsSupported diagonalScreenSize:8.5 pixelPerInch:117 scale:1.25];
                            response.systemCapability.videoStreamingCapability = testVideoStreamingCapability;
                            [testConnectionManager respondToLastRequestWithResponse:response];
                        });

                        it(@"should have correct data from the data source", ^{
                            // Correct formats should be retrieved from the data source
                            expect(streamingLifecycleManager.preferredResolutions).to(haveCount(1));
                            expect(streamingLifecycleManager.preferredResolutions.firstObject.resolutionWidth).to(equal(resolution.resolutionWidth));
                            expect(streamingLifecycleManager.preferredResolutions.firstObject.resolutionHeight).to(equal(resolution.resolutionHeight));

                            expect(streamingLifecycleManager.preferredFormats).to(haveCount(streamingLifecycleManager.supportedFormats.count + 1));
                            expect(streamingLifecycleManager.preferredFormats.firstObject.codec).to(equal(testDataSource.extraFormat.codec));
                            expect(streamingLifecycleManager.preferredFormats.firstObject.protocol).to(equal(testDataSource.extraFormat.protocol));

                            // The haptic manager should be enabled
                            expect(streamingLifecycleManager.focusableItemManager.enableHapticDataRequests).to(equal(YES));
                        });

                        it(@"should have decided upon the correct preferred format and resolution", ^{
                            SDLVideoStreamingFormat *preferredFormat = streamingLifecycleManager.preferredFormats[streamingLifecycleManager.preferredFormatIndex];
                            expect(preferredFormat.codec).to(equal(SDLVideoStreamingCodecH264));
                            expect(preferredFormat.protocol).to(equal(SDLVideoStreamingProtocolRTP));

                            SDLImageResolution *preferredResolution = streamingLifecycleManager.preferredResolutions[streamingLifecycleManager.preferredResolutionIndex];
                            expect(preferredResolution.resolutionHeight).to(equal(@69));
                            expect(preferredResolution.resolutionWidth).to(equal(@42));
                        });

                        it(@"should set the correct scale value", ^{
                            expect(streamingLifecycleManager.videoScaleManager.scale).to(equal(testVideoStreamingCapability.scale));
                        });
                    });
                });
            });

            describe(@"after receiving a Video Start ACK", ^{
                __block SDLProtocolHeader *testVideoHeader = nil;
                __block SDLProtocolMessage *testVideoMessage = nil;
                __block SDLControlFramePayloadVideoStartServiceAck *testVideoStartServicePayload = nil;
                __block int64_t testMTU = 789456;
                __block int32_t testVideoHeight = 42;
                __block int32_t testVideoWidth = 32;
                __block SDLVideoStreamingCodec testVideoCodec = SDLVideoStreamingCodecH264;
                __block SDLVideoStreamingProtocol testVideoProtocol = SDLVideoStreamingProtocolRTP;

                beforeEach(^{
                    [streamingLifecycleManager.videoStreamStateMachine setToState:SDLVideoStreamManagerStateStarting fromOldState:nil callEnterTransition:NO];

                    testVideoHeader = [[SDLV2ProtocolHeader alloc] initWithVersion:5];
                    testVideoHeader.frameType = SDLFrameTypeSingle;
                    testVideoHeader.frameData = SDLFrameInfoStartServiceACK;
                    testVideoHeader.encrypted = YES;
                    testVideoHeader.serviceType = SDLServiceTypeVideo;
                });

                context(@"with data", ^{
                    beforeEach(^{
                        testVideoStartServicePayload = [[SDLControlFramePayloadVideoStartServiceAck alloc] initWithMTU:testMTU height:testVideoHeight width:testVideoWidth protocol:testVideoProtocol codec:testVideoCodec];
                        testVideoMessage = [[SDLV2ProtocolMessage alloc] initWithHeader:testVideoHeader andPayload:testVideoStartServicePayload.data];
                        [streamingLifecycleManager handleProtocolStartServiceACKMessage:testVideoMessage];
                    });

                    it(@"should have set all the right properties", ^{
                        expect([[SDLGlobals sharedGlobals] mtuSizeForServiceType:SDLServiceTypeVideo]).to(equal(testMTU));
                        expect(@(CGSizeEqualToSize(streamingLifecycleManager.videoScaleManager.displayViewportResolution, CGSizeMake(testVideoWidth, testVideoHeight)))).to(beTrue());
                        expect(streamingLifecycleManager.videoEncrypted).to(equal(YES));
                        expect(streamingLifecycleManager.videoFormat).to(equal([[SDLVideoStreamingFormat alloc] initWithCodec:testVideoCodec protocol:testVideoProtocol]));
                        expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateReady));
                    });
                });

                context(@"with missing data", ^{
                    beforeEach(^{
                        testVideoStartServicePayload = [[SDLControlFramePayloadVideoStartServiceAck alloc] initWithMTU:testMTU height:testVideoHeight width:testVideoWidth protocol:nil codec:nil];
                        testVideoMessage = [[SDLV2ProtocolMessage alloc] initWithHeader:testVideoHeader andPayload:testVideoStartServicePayload.data];
                        [streamingLifecycleManager handleProtocolStartServiceACKMessage:testVideoMessage];
                    });

                    it(@"should fall back correctly", ^{
                        expect(@(CGSizeEqualToSize(streamingLifecycleManager.videoScaleManager.displayViewportResolution, CGSizeMake(testVideoWidth, testVideoHeight)))).to(beTrue());
                        expect(streamingLifecycleManager.videoFormat).to(equal([[SDLVideoStreamingFormat alloc] initWithCodec:SDLVideoStreamingCodecH264 protocol:SDLVideoStreamingProtocolRAW]));
                        expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateReady));
                    });
                });

                context(@"with missing screen height and screen width values", ^{
                    beforeEach(^{
                        streamingLifecycleManager.preferredResolutions = @[];
                        
                        testVideoStartServicePayload = [[SDLControlFramePayloadVideoStartServiceAck alloc] initWithMTU:testMTU height:SDLControlFrameInt32NotFound width:SDLControlFrameInt32NotFound protocol:nil codec:nil];
                        testVideoMessage = [[SDLV2ProtocolMessage alloc] initWithHeader:testVideoHeader andPayload:testVideoStartServicePayload.data];
                        expect(@(CGSizeEqualToSize(streamingLifecycleManager.videoScaleManager.displayViewportResolution, CGSizeZero))).to(equal(@YES));
                    });
                    context(@"If no preferred resolutions were set in the data source", ^{
                        beforeEach(^{
                            streamingLifecycleManager.dataSource = nil;
                            [streamingLifecycleManager handleProtocolStartServiceACKMessage:testVideoMessage];
                        });
                        it(@"should not replace the existing screen resolution", ^{
                            expect(@(CGSizeEqualToSize(streamingLifecycleManager.videoScaleManager.displayViewportResolution, CGSizeZero))).to(beTrue());
                            expect(streamingLifecycleManager.dataSource).to(beNil());
                        });
                    });
                    context(@"If the preferred resolution was set in the data source", ^{
                        __block SDLImageResolution *preferredResolutionLow = nil;
                        __block SDLImageResolution *preferredResolutionHigh = nil;
                        
                        beforeEach(^{
                            preferredResolutionLow = [[SDLImageResolution alloc] initWithWidth:10 height:10];
                            preferredResolutionHigh = [[SDLImageResolution alloc] initWithWidth:100 height:100];
                            streamingLifecycleManager.dataSource = testDataSource;
                            streamingLifecycleManager.preferredResolutions = @[preferredResolutionLow, preferredResolutionHigh];
                            
                            [streamingLifecycleManager handleProtocolStartServiceACKMessage:testVideoMessage];
                        });
                        it(@"should set the screen size using the first provided preferred resolution", ^{
                            CGSize preferredFormat = CGSizeMake(preferredResolutionLow.resolutionWidth.floatValue, preferredResolutionLow.resolutionHeight.floatValue);
                            expect(@(CGSizeEqualToSize(streamingLifecycleManager.videoScaleManager.displayViewportResolution, preferredFormat))).to(beTrue());
                            expect(streamingLifecycleManager.dataSource).toNot(beNil());
                        });
                    });
                });
            });

            describe(@"after receiving a Video Start NAK", ^{
                __block SDLProtocolHeader *testVideoHeader = nil;
                __block SDLProtocolMessage *testVideoMessage = nil;
                __block SDLControlFramePayloadNak *testVideoStartNakPayload = nil;

                beforeEach(^{
                    [streamingLifecycleManager.videoStreamStateMachine setToState:SDLVideoStreamManagerStateStarting fromOldState:nil callEnterTransition:NO];

                    testVideoHeader = [[SDLV2ProtocolHeader alloc] initWithVersion:5];
                    testVideoHeader.frameType = SDLFrameTypeSingle;
                    testVideoHeader.frameData = SDLFrameInfoStartServiceACK;
                    testVideoHeader.encrypted = YES;
                    testVideoHeader.serviceType = SDLServiceTypeVideo;
                });

                context(@"with data", ^{
                    beforeEach(^{
                        testVideoStartNakPayload = [[SDLControlFramePayloadNak alloc] initWithRejectedParams:@[[NSString stringWithUTF8String:SDLControlFrameHeightKey], [NSString stringWithUTF8String:SDLControlFrameVideoCodecKey]]];
                        testVideoMessage = [[SDLV2ProtocolMessage alloc] initWithHeader:testVideoHeader andPayload:testVideoStartNakPayload.data];
                        [streamingLifecycleManager handleProtocolStartServiceNAKMessage:testVideoMessage];
                    });

                    it(@"should have retried with new properties", ^{
                        expect(streamingLifecycleManager.preferredResolutionIndex).to(equal(1));
                        expect(streamingLifecycleManager.preferredFormatIndex).to(equal(1));
                    });
                });

                context(@"with missing data", ^{
                    beforeEach(^{
                        testVideoStartNakPayload = [[SDLControlFramePayloadNak alloc] initWithRejectedParams:nil];
                        testVideoMessage = [[SDLV2ProtocolMessage alloc] initWithHeader:testVideoHeader andPayload:testVideoStartNakPayload.data];
                        [streamingLifecycleManager handleProtocolStartServiceNAKMessage:testVideoMessage];
                    });

                    it(@"should end the service", ^{
                        expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateStopped));
                    });
                });
            });

            describe(@"after receiving a video end ACK", ^{
                __block SDLProtocolHeader *testVideoHeader = nil;
                __block SDLProtocolMessage *testVideoMessage = nil;

                beforeEach(^{
                    [streamingLifecycleManager.videoStreamStateMachine setToState:SDLVideoStreamManagerStateStarting fromOldState:nil callEnterTransition:NO];

                    testVideoHeader = [[SDLV2ProtocolHeader alloc] initWithVersion:5];
                    testVideoHeader.frameType = SDLFrameTypeSingle;
                    testVideoHeader.frameData = SDLFrameInfoEndServiceACK;
                    testVideoHeader.encrypted = NO;
                    testVideoHeader.serviceType = SDLServiceTypeVideo;

                    testVideoMessage = [[SDLV2ProtocolMessage alloc] initWithHeader:testVideoHeader andPayload:nil];
                    [streamingLifecycleManager handleProtocolEndServiceACKMessage:testVideoMessage];
                });

                it(@"should have set all the right properties", ^{
                    expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateStopped));
                });
            });

            describe(@"after receiving a video end NAK", ^{
                __block SDLProtocolHeader *testVideoHeader = nil;
                __block SDLProtocolMessage *testVideoMessage = nil;

                beforeEach(^{
                    [streamingLifecycleManager.videoStreamStateMachine setToState:SDLVideoStreamManagerStateStarting fromOldState:nil callEnterTransition:NO];

                    testVideoHeader = [[SDLV2ProtocolHeader alloc] initWithVersion:5];
                    testVideoHeader.frameType = SDLFrameTypeSingle;
                    testVideoHeader.frameData = SDLFrameInfoEndServiceNACK;
                    testVideoHeader.encrypted = NO;
                    testVideoHeader.serviceType = SDLServiceTypeVideo;

                    testVideoMessage = [[SDLV2ProtocolMessage alloc] initWithHeader:testVideoHeader andPayload:nil];
                    [streamingLifecycleManager handleProtocolEndServiceNAKMessage:testVideoMessage];
                });

                it(@"should have set all the right properties", ^{
                    expect(streamingLifecycleManager.currentVideoStreamState).to(equal(SDLVideoStreamManagerStateStopped));
                });
            });
        });
    });

    describe(@"Creating a background video stream string", ^{
        __block NSString *expectedVideoStreamBackgroundString = [NSString stringWithFormat:@"When it is safe to do so, open %@ on your phone", testAppName];

        it(@"Should return the correct video stream background string for the screen size", ^{
            expect(streamingLifecycleManager.videoStreamBackgroundString).to(match(expectedVideoStreamBackgroundString));
        });
    });
});

QuickSpecEnd
