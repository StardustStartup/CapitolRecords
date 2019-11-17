#import <Quick/Quick.h>
#import <Nimble/Nimble.h>
#import <OCMock/OCMock.h>

#import "SDLLifecycleManager.h"

#import "SDLAppServiceData.h"
#import "SDLConfiguration.h"
#import "SDLConnectionManagerType.h"
#import "SDLError.h"
#import "SDLFileManager.h"
#import "SDLGlobals.h"
#import "SDLHMILevel.h"
#import "SDLLifecycleConfiguration.h"
#import "SDLLockScreenConfiguration.h"
#import "SDLLockScreenManager.h"
#import "SDLLogConfiguration.h"
#import "SDLManagerDelegate.h"
#import "SDLNotificationDispatcher.h"
#import "SDLOnAppInterfaceUnregistered.h"
#import "SDLOnAppServiceData.h"
#import "SDLOnHashChange.h"
#import "SDLOnHMIStatus.h"
#import "SDLPerformAppServiceInteractionResponse.h"
#import "SDLPermissionManager.h"
#import "SDLProxy.h"
#import "SDLProtocol.h"
#import "SDLRegisterAppInterface.h"
#import "SDLRegisterAppInterfaceResponse.h"
#import "SDLResult.h"
#import "SDLRPCNotificationNotification.h"
#import "SDLShow.h"
#import "SDLStateMachine.h"
#import "SDLStreamingMediaConfiguration.h"
#import "SDLStreamingMediaManager.h"
#import "SDLSystemCapabilityManager.h"
#import "SDLTextAlignment.h"
#import "SDLTTSChunk.h"
#import "SDLUnregisterAppInterface.h"
#import "SDLUnregisterAppInterfaceResponse.h"
#import "SDLVersion.h"


// Ignore the deprecated proxy methods
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface SDLLifecycleManager ()
// this private property is used for testing
@property (copy, nonatomic) dispatch_queue_t lifecycleQueue;
@property (assign, nonatomic) int32_t lastCorrelationId;
@end

QuickConfigurationBegin(SendingRPCsConfiguration)

+ (void)configure:(Configuration *)configuration {
    sharedExamples(@"unable to send an RPC", ^(QCKDSLSharedExampleContext exampleContext) {
        it(@"cannot publicly send RPCs", ^{
            SDLLifecycleManager *testManager = exampleContext()[@"manager"];
            SDLShow *testShow = [[SDLShow alloc] initWithMainField1:@"test" mainField2:nil alignment:nil];
            
            [testManager sendRequest:testShow withResponseHandler:^(__kindof SDLRPCRequest * _Nullable request, __kindof SDLRPCResponse * _Nullable response, NSError * _Nullable error) {
                expect(error).to(equal([NSError sdl_lifecycle_notReadyError]));
            }];
        });
    });
}

QuickConfigurationEnd


@interface SDLLifecycleManager ()
// reach the private property for testing
@property (strong, nonatomic, nullable) SDLSecondaryTransportManager *secondaryTransportManager;
@end


QuickSpecBegin(SDLLifecycleManagerSpec)

describe(@"a lifecycle manager", ^{
    __block SDLLifecycleManager *testManager = nil;
    __block SDLConfiguration *testConfig = nil;
    
    __block id protocolMock = OCMClassMock([SDLProtocol class]);
    __block id proxyMock = OCMClassMock([SDLProxy class]);
    __block id lockScreenManagerMock = OCMClassMock([SDLLockScreenManager class]);
    __block id fileManagerMock = OCMClassMock([SDLFileManager class]);
    __block id permissionManagerMock = OCMClassMock([SDLPermissionManager class]);
    __block id streamingManagerMock = OCMClassMock([SDLStreamingMediaManager class]);
    __block id systemCapabilityMock = OCMClassMock([SDLSystemCapabilityManager class]);
    
    void (^transitionToState)(SDLState *) = ^(SDLState *state) {
        dispatch_sync(testManager.lifecycleQueue, ^{
            [testManager.lifecycleStateMachine transitionToState:state];
        });
    };

    void (^setToStateWithEnterTransition)(SDLState *, SDLState *) = ^(SDLState *oldState, SDLState *newState) {
        dispatch_sync(testManager.lifecycleQueue, ^{
            [testManager.lifecycleStateMachine setToState:newState fromOldState:oldState callEnterTransition:YES];
        });
    };

    beforeEach(^{
        OCMStub([proxyMock iapProxyWithListener:[OCMArg any] secondaryTransportManager:[OCMArg any] encryptionLifecycleManager:[OCMArg any]]).andReturn(proxyMock);
        OCMStub([(SDLProxy*)proxyMock protocol]).andReturn(protocolMock);
        
        SDLLifecycleConfiguration *testLifecycleConfig = [SDLLifecycleConfiguration defaultConfigurationWithAppName:@"Test App" appId:@"Test Id"];
        testLifecycleConfig.shortAppName = @"Short Name";
        testLifecycleConfig.appType = SDLAppHMITypeNavigation;
        
        testConfig = [SDLConfiguration configurationWithLifecycle:testLifecycleConfig lockScreen:[SDLLockScreenConfiguration disabledConfiguration] logging:[SDLLogConfiguration defaultConfiguration] streamingMedia:[SDLStreamingMediaConfiguration insecureConfiguration]];
        testConfig.lifecycleConfig.languagesSupported = @[SDLLanguageEnUs, SDLLanguageEnGb];
        testConfig.lifecycleConfig.language = SDLLanguageEnUs;
        testManager = [[SDLLifecycleManager alloc] initWithConfiguration:testConfig delegate:OCMProtocolMock(@protocol(SDLManagerDelegate))];
        testManager.lockScreenManager = lockScreenManagerMock;
        testManager.fileManager = fileManagerMock;
        testManager.permissionManager = permissionManagerMock;
        testManager.streamManager = streamingManagerMock;
        testManager.systemCapabilityManager = systemCapabilityMock;
    });
    
    it(@"should initialize properties", ^{
        expect(testManager.configuration).toNot(equal(testConfig)); // This is copied
        expect(testManager.delegate).toNot(beNil());
        expect(testManager.lifecycleState).to(match(SDLLifecycleStateStopped));
        expect(@(testManager.lastCorrelationId)).to(equal(@0));
        expect(testManager.fileManager).toNot(beNil());
        expect(testManager.permissionManager).toNot(beNil());
        expect(testManager.streamManager).toNot(beNil());
        expect(testManager.proxy).to(beNil());
        expect(testManager.registerResponse).to(beNil());
        expect(testManager.lockScreenManager).toNot(beNil());
        expect(testManager.notificationDispatcher).toNot(beNil());
        expect(testManager.responseDispatcher).toNot(beNil());
        expect(testManager.streamManager).toNot(beNil());
        expect(testManager.systemCapabilityManager).toNot(beNil());
        expect(testManager.rpcOperationQueue).toNot(beNil());
        expect(@([testManager conformsToProtocol:@protocol(SDLConnectionManagerType)])).to(equal(@YES));
        expect(testManager.authToken).to(beNil());
    });
    
    itBehavesLike(@"unable to send an RPC", ^{ return @{ @"manager": testManager }; });
    
    describe(@"after receiving an HMI Status", ^{
        __block SDLOnHMIStatus *testHMIStatus = nil;
        __block SDLHMILevel testHMILevel = nil;
        
        beforeEach(^{
            testHMIStatus = [[SDLOnHMIStatus alloc] init];
        });
        
        context(@"a non-none hmi level", ^{
            beforeEach(^{
                testHMILevel = SDLHMILevelNone;
                testHMIStatus.hmiLevel = testHMILevel;
                
                [testManager.notificationDispatcher postRPCNotificationNotification:SDLDidChangeHMIStatusNotification notification:testHMIStatus];
            });
            
            it(@"should set the hmi level", ^{
                expect(testManager.hmiLevel).toEventually(equal(testHMILevel));
            });
        });
        
        context(@"a non-full, non-none hmi level", ^{
            beforeEach(^{
                testHMILevel = SDLHMILevelBackground;
                testHMIStatus.hmiLevel = testHMILevel;
                
                [testManager.notificationDispatcher postRPCNotificationNotification:SDLDidChangeHMIStatusNotification notification:testHMIStatus];
            });
            
            it(@"should set the hmi level", ^{
                expect(testManager.hmiLevel).toEventually(equal(testHMILevel));
            });
        });
        
        context(@"a full hmi level", ^{
            beforeEach(^{
                testHMILevel = SDLHMILevelFull;
                testHMIStatus.hmiLevel = testHMILevel;
                
                [testManager.notificationDispatcher postRPCNotificationNotification:SDLDidChangeHMIStatusNotification notification:testHMIStatus];
            });
            
            it(@"should set the hmi level", ^{
                expect(testManager.hmiLevel).toEventually(equal(testHMILevel));
            });
        });
    });
    
    describe(@"calling stop", ^{
        beforeEach(^{
            [testManager stop];
        });
        
        it(@"should do nothing", ^{
            expect(testManager.lifecycleState).to(match(SDLLifecycleStateStopped));
            expect(testManager.lifecycleState).toEventuallyNot(match(SDLLifecycleStateStarted));
        });
    });
    
    describe(@"when started", ^{
        __block BOOL readyHandlerSuccess = NO;
        __block NSError *readyHandlerError = nil;

        beforeEach(^{
            readyHandlerSuccess = NO;
            readyHandlerError = nil;

            [testManager startWithReadyHandler:^(BOOL success, NSError * _Nullable error) {
                readyHandlerSuccess = success;
                readyHandlerError = error;
            }];
        });
        
        it(@"should initialize the proxy property", ^{
            expect(testManager.proxy).toNot(beNil());
            expect(testManager.lifecycleState).to(match(SDLLifecycleStateStarted));
        });

        it(@"should initialize secondary transport manager if not in tcpDebugMode", ^{
            if (!testManager.configuration.lifecycleConfig.tcpDebugMode) {
                expect(testManager.secondaryTransportManager).toNot(beNil());
            }
        });

        describe(@"after receiving a connect notification", ^{
            beforeEach(^{
                // When we connect, we should be creating an sending an RAI
                OCMExpect([proxyMock sendRPC:[OCMArg isKindOfClass:[SDLRegisterAppInterface class]]]);
                
                [testManager.notificationDispatcher postNotificationName:SDLTransportDidConnect infoObject:nil];
                [NSThread sleepForTimeInterval:0.1];
            });
            
            it(@"should send a register app interface request and be in the connected state", ^{
                OCMVerifyAllWithDelay(proxyMock, 0.5);
                expect(testManager.lifecycleState).to(match(SDLLifecycleStateConnected));
            });
            
            itBehavesLike(@"unable to send an RPC", ^{ return @{ @"manager": testManager }; });
            
            describe(@"after receiving a disconnect notification", ^{
                beforeEach(^{
                    [testManager.notificationDispatcher postNotificationName:SDLTransportDidDisconnect infoObject:nil];
                    [NSThread sleepForTimeInterval:0.1];
                });
                
                it(@"should be in the started state", ^{
                    expect(testManager.lifecycleState).to(match(SDLLifecycleStateReconnecting));
                });
            });
            
            describe(@"stopping the manager", ^{
                it(@"should simply stop", ^{
                    [testManager stop];
                    
                    expect(testManager.lifecycleState).toEventually(match(SDLLifecycleStateStopped));
                });
            });
        });

        describe(@"in the connected state when the minimum protocol version is in effect", ^{
            beforeEach(^{
                SDLVersion *oldVersion = [SDLVersion versionWithMajor:0 minor:0 patch:0];
                id globalMock = OCMPartialMock([SDLGlobals sharedGlobals]);
                OCMStub([globalMock protocolVersion]).andReturn(oldVersion);
                OCMExpect([protocolMock endServiceWithType:SDLServiceTypeRPC]);
                [testManager.lifecycleStateMachine setToState:SDLLifecycleStateConnected fromOldState:nil callEnterTransition:YES];
            });

            it(@"should disconnect", ^{
                OCMVerifyAll(protocolMock);
            });
        });
        
        describe(@"in the connected state", ^{
            beforeEach(^{
                [testManager.lifecycleStateMachine setToState:SDLLifecycleStateConnected fromOldState:nil callEnterTransition:NO];
            });
            
            describe(@"after receiving a register app interface response", ^{
                __block NSError *fileManagerStartError = [NSError errorWithDomain:@"testDomain" code:0 userInfo:nil];
                __block NSError *permissionManagerStartError = [NSError errorWithDomain:@"testDomain" code:0 userInfo:nil];
                
                beforeEach(^{
                    OCMStub([(SDLLockScreenManager *)lockScreenManagerMock start]);
                    OCMStub([fileManagerMock startWithCompletionHandler:([OCMArg invokeBlockWithArgs:@(YES), fileManagerStartError, nil])]);
                    OCMStub([permissionManagerMock startWithCompletionHandler:([OCMArg invokeBlockWithArgs:@(YES), permissionManagerStartError, nil])]);
                    if (testConfig.lifecycleConfig.tcpDebugMode) {
                        OCMStub([streamingManagerMock startWithProtocol:protocolMock]);
                    }

                    // Send an RAI response & make sure we have an HMI status to move the lifecycle forward
                    testManager.hmiLevel = SDLHMILevelFull;
                    transitionToState(SDLLifecycleStateRegistered);
                    [NSThread sleepForTimeInterval:0.3];
                });
                
                it(@"should eventually reach the ready state", ^{
                    expect(testManager.lifecycleState).toEventually(equal(SDLLifecycleStateReady));
                    OCMVerify([(SDLLockScreenManager *)lockScreenManagerMock start]);
                    OCMVerify([fileManagerMock startWithCompletionHandler:[OCMArg any]]);
                    OCMVerify([permissionManagerMock startWithCompletionHandler:[OCMArg any]]);
                    if (testManager.configuration.lifecycleConfig.tcpDebugMode) {
                        OCMVerify([streamingManagerMock startWithProtocol:[OCMArg any]]);
                    }
                });
                
                itBehavesLike(@"unable to send an RPC", ^{ return @{ @"manager": testManager }; });
            });
            
            describe(@"after receiving a disconnect notification", ^{
                beforeEach(^{
                    [testManager.notificationDispatcher postNotificationName:SDLTransportDidDisconnect infoObject:nil];
                });
                
                it(@"should enter the started state", ^{
                    expect(testManager.lifecycleState).toEventually(match(SDLLifecycleStateStarted));
                });
            });
            
            describe(@"stopping the manager", ^{
                beforeEach(^{
                    [testManager stop];
                });
                
                it(@"should enter the stopped state", ^{
                    expect(testManager.lifecycleState).to(match(SDLLifecycleStateStopped));
                });
            });
        });

        describe(@"transitioning to the registered state when the minimum RPC version is in effect", ^{
            beforeEach(^{
                SDLVersion *oldVersion = [SDLVersion versionWithMajor:0 minor:0 patch:0];
                id globalMock = OCMPartialMock([SDLGlobals sharedGlobals]);
                OCMStub([globalMock rpcVersion]).andReturn(oldVersion);

                [testManager.lifecycleStateMachine setToState:SDLLifecycleStateRegistered fromOldState:nil callEnterTransition:YES];
            });

            it(@"should disconnect", ^{
                expect(testManager.lifecycleState).to(equal(SDLLifecycleStateUnregistering));
            });
        });
        
        describe(@"transitioning to the Setting Up HMI state", ^{
            context(@"before register response is a success", ^{
                it(@"ready handler should not be called yet", ^{
                    SDLRegisterAppInterfaceResponse *response = [[SDLRegisterAppInterfaceResponse alloc] init];
                    response.resultCode = SDLResultSuccess;
                    testManager.registerResponse = response;
                    
                    setToStateWithEnterTransition(nil, SDLLifecycleStateSettingUpHMI);

                    expect(@(readyHandlerSuccess)).to(equal(@NO));
                    expect(readyHandlerError).to(beNil());
                });
            });
            
            context(@"assume hmi status is nil", ^{
                it(@"mock notification and ensure state changes to ready", ^{
                    __block SDLOnHMIStatus *testHMIStatus = nil;
                    __block SDLHMILevel testHMILevel = nil;
                    testHMIStatus = [[SDLOnHMIStatus alloc] init];
                    
                    SDLRegisterAppInterfaceResponse *response = [[SDLRegisterAppInterfaceResponse alloc] init];
                    response.resultCode = SDLResultSuccess;
                    testManager.registerResponse = response;
                    
                    setToStateWithEnterTransition(nil, SDLLifecycleStateSettingUpHMI);
                    
                    testHMILevel = SDLHMILevelFull;
                    testHMIStatus.hmiLevel = testHMILevel;
                    
                    [testManager.notificationDispatcher postRPCNotificationNotification:SDLDidChangeHMIStatusNotification notification:testHMIStatus];

                    expect(testManager.lifecycleState).toEventually(equal(SDLLifecycleStateReady));
                    expect(@(readyHandlerSuccess)).toEventually(equal(@YES));
                    expect(readyHandlerError).toEventually(beNil());
                });
            });
        });

        describe(@"transitioning to the ready state", ^{
            context(@"when the register response is a success", ^{
                it(@"should call the ready handler with success", ^{
                    SDLRegisterAppInterfaceResponse *response = [[SDLRegisterAppInterfaceResponse alloc] init];
                    response.resultCode = SDLResultSuccess;
                    testManager.registerResponse = response;
                    
                    setToStateWithEnterTransition(nil, SDLLifecycleStateReady);

                    expect(@(readyHandlerSuccess)).toEventually(equal(@YES));
                    expect(readyHandlerError).toEventually(beNil());
                });
            });

            context(@"when the register response is a warning", ^{
                it(@"should call the ready handler with success but error", ^{
                    SDLRegisterAppInterfaceResponse *response = [[SDLRegisterAppInterfaceResponse alloc] init];
                    response.resultCode = SDLResultWarnings;
                    response.info = @"some info";
                    testManager.registerResponse = response;

                    setToStateWithEnterTransition(nil, SDLLifecycleStateReady);

                    expect(@(readyHandlerSuccess)).toEventually(equal(@YES));
                    expect(readyHandlerError).toEventuallyNot(beNil());
                    expect(@(readyHandlerError.code)).toEventually(equal(@(SDLManagerErrorRegistrationSuccessWithWarning)));
                    expect(readyHandlerError.userInfo[NSLocalizedFailureReasonErrorKey]).toEventually(match(response.info));
                });
            });
            
            context(@"when the register response returns different language than the one passed with the lifecycle configuration", ^{
                beforeEach(^{
                     expect(testManager.configuration.lifecycleConfig.appName).to(equal(testConfig.lifecycleConfig.appName));
                     expect(testManager.configuration.lifecycleConfig.shortAppName).to(equal(testConfig.lifecycleConfig.shortAppName));
                     expect(testManager.configuration.lifecycleConfig.ttsName).to(beNil());
                     expect(testManager.configuration.lifecycleConfig.language).to(equal(testConfig.lifecycleConfig.language));
                     expect(testManager.configuration.lifecycleConfig.languagesSupported).to(equal(testConfig.lifecycleConfig.languagesSupported));
                 });

                it(@"should should update the configuration when the app supports the head unit language", ^{
                    SDLRegisterAppInterfaceResponse *registerAppInterfaceResponse = [[SDLRegisterAppInterfaceResponse alloc] init];
                    registerAppInterfaceResponse.success = @YES;
                    registerAppInterfaceResponse.resultCode = SDLResultWrongLanguage;
                    registerAppInterfaceResponse.info = @"Language mismatch";
                    registerAppInterfaceResponse.language = SDLLanguageEnGb;
                    testManager.registerResponse = registerAppInterfaceResponse;

                    SDLLifecycleConfigurationUpdate *update = [[SDLLifecycleConfigurationUpdate alloc] initWithAppName:@"EnGb" shortAppName:@"E" ttsName:[SDLTTSChunk textChunksFromString:@"EnGb ttsName"] voiceRecognitionCommandNames:nil];
                    OCMStub([testManager.delegate managerShouldUpdateLifecycleToLanguage:[OCMArg any]]).andReturn(update);

                    setToStateWithEnterTransition(SDLLifecycleStateRegistered, SDLLifecycleStateUpdatingConfiguration);
                    // Transition to StateSettingUpManagers to prevent assert error from the lifecycle machine
                    [testManager.lifecycleStateMachine setToState:SDLLifecycleStateSettingUpManagers fromOldState:SDLLifecycleStateUpdatingConfiguration callEnterTransition:NO];

                    expect(testManager.configuration.lifecycleConfig.language).toEventually(equal(SDLLanguageEnGb));
                    expect(testManager.configuration.lifecycleConfig.appName).toEventually(equal(@"EnGb"));
                    expect(testManager.configuration.lifecycleConfig.shortAppName).toEventually(equal(@"E"));
                    expect(testManager.configuration.lifecycleConfig.ttsName).toEventually(equal([SDLTTSChunk textChunksFromString:@"EnGb ttsName"]));

                    OCMVerify([testManager.delegate managerShouldUpdateLifecycleToLanguage:[OCMArg any]]);
                });

                it(@"should not update the configuration when the app does not support the head unit language", ^{
                    SDLRegisterAppInterfaceResponse *registerAppInterfaceResponse = [[SDLRegisterAppInterfaceResponse alloc] init];
                    registerAppInterfaceResponse.success = @YES;
                    registerAppInterfaceResponse.resultCode = SDLResultWrongLanguage;
                    registerAppInterfaceResponse.info = @"Language mismatch";
                    registerAppInterfaceResponse.language = SDLLanguageDeDe;
                    testManager.registerResponse = registerAppInterfaceResponse;

                    OCMStub([testManager.delegate managerShouldUpdateLifecycleToLanguage:[OCMArg any]]).andReturn(nil);

                    setToStateWithEnterTransition(SDLLifecycleStateRegistered, SDLLifecycleStateUpdatingConfiguration);
                    // Transition to StateSettingUpManagers to prevent assert error from the lifecycle machine
                    [testManager.lifecycleStateMachine setToState:SDLLifecycleStateSettingUpManagers fromOldState:SDLLifecycleStateUpdatingConfiguration callEnterTransition:NO];

                    expect(testManager.configuration.lifecycleConfig.language).toEventually(equal(SDLLanguageEnUs));
                    expect(testManager.configuration.lifecycleConfig.appName).toEventually(equal(@"Test App"));
                    expect(testManager.configuration.lifecycleConfig.shortAppName).toEventually(equal(@"Short Name"));
                    expect(testManager.configuration.lifecycleConfig.ttsName).toEventually(beNil());

                    OCMVerify([testManager.delegate managerShouldUpdateLifecycleToLanguage:[OCMArg any]]);
                });
            });
        });
        
        describe(@"in the ready state", ^{
            beforeEach(^{
                [testManager.lifecycleStateMachine setToState:SDLLifecycleStateReady fromOldState:nil callEnterTransition:NO];
            });

            it(@"can send an RPC of type Request", ^{
                SDLShow *testShow = [[SDLShow alloc] initWithMainField1:@"test" mainField2:nil alignment:nil];
                [testManager sendRPC:testShow];

                [NSThread sleepForTimeInterval:0.1];

                OCMVerify([proxyMock sendRPC:[OCMArg isKindOfClass:SDLShow.class]]);
            });

            it(@"can send an RPC of type Response", ^{
                SDLPerformAppServiceInteractionResponse *testResponse = [[SDLPerformAppServiceInteractionResponse alloc] init];
                [testManager sendRPC:testResponse];
                testResponse.correlationID = @(2);
                testResponse.success = @(true);
                testResponse.resultCode = SDLResultSuccess;
                testResponse.info = @"testResponse info";

                [NSThread sleepForTimeInterval:0.1];

                OCMVerify([proxyMock sendRPC:[OCMArg isKindOfClass:SDLPerformAppServiceInteractionResponse.class]]);
            });

            it(@"can send an RPC of type Notification", ^{
                SDLOnAppServiceData *testNotification = [[SDLOnAppServiceData alloc] initWithServiceData:[[SDLAppServiceData alloc] init]];
                [testManager sendRPC:testNotification];

                [NSThread sleepForTimeInterval:0.1];

                OCMVerify([proxyMock sendRPC:[OCMArg isKindOfClass:SDLOnAppServiceData.class]]);
            });

            it(@"should throw an exception if the RPC is not of type `Request`, `Response` or `Notification`", ^{
                SDLRPCMessage *testMessage = [[SDLRPCMessage alloc] init];
                expectAction(^{
                    [testManager sendRPC:testMessage];
                }).to(raiseException());
            });
            
            describe(@"stopping the manager on certain SDLAppInterfaceUnregisteredReason", ^{
                it(@"should attempt to stop the manager when a PROTOCOL_VIOLATION notification is recieved", ^{

                    SDLOnAppInterfaceUnregistered *unreg = [[SDLOnAppInterfaceUnregistered alloc] init];
                    unreg.reason = SDLAppInterfaceUnregisteredReasonProtocolViolation;
                    
                    SDLRPCNotificationNotification *notification = [[SDLRPCNotificationNotification alloc] initWithName:SDLDidReceiveAppUnregisteredNotification object:testManager.notificationDispatcher rpcNotification:unreg];
                    
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    expect(testManager.lifecycleState).toEventually(equal(SDLLifecycleStateStopped));
                });
       
                it(@"should attempt to stop the manager when an APP_UNAUTHORIZED notification is recieved", ^{
                    
                    SDLOnAppInterfaceUnregistered *unreg = [[SDLOnAppInterfaceUnregistered alloc] init];
                    unreg.reason = SDLAppInterfaceUnregisteredReasonAppUnauthorized;
                    
                    SDLRPCNotificationNotification *notification = [[SDLRPCNotificationNotification alloc] initWithName:SDLDidReceiveAppUnregisteredNotification object:testManager.notificationDispatcher rpcNotification:unreg];
                    
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    expect(testManager.lifecycleState).toEventually(equal(SDLLifecycleStateStopped));
                });
            });
            
            
            describe(@"stopping the manager", ^{
                beforeEach(^{
                    [testManager stop];
                });
                
                it(@"should attempt to unregister", ^{
                    OCMVerify([proxyMock sendRPC:[OCMArg isKindOfClass:[SDLUnregisterAppInterface class]]]);
                    expect(testManager.lifecycleState).toEventually(match(SDLLifecycleStateUnregistering));
                });
                
                describe(@"when receiving an unregister response", ^{
                    __block SDLUnregisterAppInterfaceResponse *testUnregisterResponse = nil;
                    
                    beforeEach(^{
                        testUnregisterResponse = [[SDLUnregisterAppInterfaceResponse alloc] init];
                        testUnregisterResponse.success = @YES;
                        testUnregisterResponse.correlationID = @(testManager.lastCorrelationId);
                        
                        // This should run on `com.sdl.rpcProcessingQueue` to simulate the real case.
                        [testManager.notificationDispatcher postRPCResponseNotification:SDLDidReceiveUnregisterAppInterfaceResponse response:testUnregisterResponse];
                    });
                    
                    it(@"should stop", ^{
                        expect(testManager.lifecycleState).toEventually(match(SDLLifecycleStateStopped));
                    });
                });
            });
            
            describe(@"receiving an HMI level change", ^{
                __block SDLOnHMIStatus *testHMIStatus = nil;
                __block SDLHMILevel testHMILevel = nil;
                __block SDLHMILevel oldHMILevel = nil;
                
                beforeEach(^{
                    oldHMILevel = testManager.hmiLevel;
                    testHMIStatus = [[SDLOnHMIStatus alloc] init];
                });
                
                context(@"a full hmi level", ^{
                    beforeEach(^{
                        testHMILevel = SDLHMILevelFull;
                        testHMIStatus.hmiLevel = testHMILevel;
                        
                        [testManager.notificationDispatcher postRPCNotificationNotification:SDLDidChangeHMIStatusNotification notification:testHMIStatus];
                    });
                    
                    it(@"should set the hmi level", ^{
                        expect(testManager.hmiLevel).toEventually(equal(testHMILevel));
                    });
                    
                    it(@"should call the delegate", ^{
                        // Since notifications are sent to SDLManagerDelegate observers on the main thread, force the block to execute manually on the main thread. If this is not done, the test case may fail.
                        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
                        OCMVerify([testManager.delegate hmiLevel:[OCMArg any] didChangeToLevel:[OCMArg any]]);
                    });
                });
            });
            
            describe(@"receiving an audio state change", ^{
                __block SDLOnHMIStatus *testHMIStatus = nil;
                __block SDLAudioStreamingState testAudioStreamingState = nil;
                __block SDLAudioStreamingState oldAudioStreamingState = nil;
                
                beforeEach(^{
                    oldAudioStreamingState = testManager.audioStreamingState;
                    testHMIStatus = [[SDLOnHMIStatus alloc] init];
                });
                
                context(@"a not audible audio state", ^{
                    beforeEach(^{
                        testAudioStreamingState = SDLAudioStreamingStateNotAudible;
                        testHMIStatus.audioStreamingState = testAudioStreamingState;
                        
                        [testManager.notificationDispatcher postRPCNotificationNotification:SDLDidChangeHMIStatusNotification notification:testHMIStatus];
                    });
                    
                    it(@"should set the audio state", ^{
                        expect(testManager.audioStreamingState).toEventually(equal(testAudioStreamingState));
                    });
                    
                    it(@"should call the delegate", ^{
                        // Since notifications are sent to SDLManagerDelegate observers on the main thread, force the block to execute manually on the main thread. If this is not done, the test case may fail.
                        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];

                        OCMVerify([testManager.delegate audioStreamingState:oldAudioStreamingState didChangeToState:testAudioStreamingState]);
                    });
                });
            });
            
            describe(@"receiving a system context change", ^{
                __block SDLOnHMIStatus *testHMIStatus = nil;
                __block SDLSystemContext testSystemContext = nil;
                __block SDLSystemContext oldSystemContext = nil;

                beforeEach(^{
                    oldSystemContext = testManager.systemContext;
                    testHMIStatus = [[SDLOnHMIStatus alloc] init];
                });
                
                context(@"a alert system context state", ^{
                    beforeEach(^{
                        expect(testManager.lifecycleStateMachine.currentState).to(equal(SDLLifecycleStateReady));
                        expect(testManager.systemContext).to(beNil());

                        testSystemContext = SDLSystemContextAlert;
                        testHMIStatus.systemContext = testSystemContext;
                        
                        [testManager.notificationDispatcher postRPCNotificationNotification:SDLDidChangeHMIStatusNotification notification:testHMIStatus];
                    });
                    
                    it(@"should set the system context", ^{
                        expect(testManager.systemContext).toEventually(equal(testSystemContext));
                    });
                    
                    it(@"should call the delegate", ^{
                        // Since notifications are sent to SDLManagerDelegate observers on the main thread, force the block to execute manually on the main thread. If this is not done, the test case may fail.
                        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
                        OCMVerify([testManager.delegate systemContext:[OCMArg any] didChangeToContext:[OCMArg any]]);
                    });

                    afterEach(^{
                        expect(testManager.delegate).toNot(beNil());
                    });
                });
            });
         });
    });
});

describe(@"configuring the lifecycle manager", ^{
    __block SDLLifecycleConfiguration *lifecycleConfig = nil;
    __block SDLLifecycleManager *testManager = nil;

    beforeEach(^{
        lifecycleConfig = [SDLLifecycleConfiguration defaultConfigurationWithAppName:@"Test app" fullAppId:@"Test ID"];
    });

    context(@"if no secondary transport is allowed", ^{
        beforeEach(^{
            lifecycleConfig.allowedSecondaryTransports = SDLSecondaryTransportsNone;

            SDLConfiguration *config = [[SDLConfiguration alloc] initWithLifecycle:lifecycleConfig lockScreen:nil logging:nil fileManager:nil];
            testManager = [[SDLLifecycleManager alloc] initWithConfiguration:config delegate:nil];
        });

        it(@"should not create a secondary transport manager", ^{
            expect(testManager.secondaryTransportManager).to(beNil());
        });
    });
});

QuickSpecEnd

#pragma clang diagnostic pop
