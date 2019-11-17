//
//  SDLChangeRegistrationSpec.m
//  SmartDeviceLink


#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLChangeRegistration.h"
#import "SDLLanguage.h"
#import "SDLRPCParameterNames.h"
#import "SDLRPCFunctionNames.h"
#import "SDLTTSChunk.h"


QuickSpecBegin(SDLChangeRegistrationSpec)

describe(@"change registration", ^ {
    __block SDLChangeRegistration *testRequest = nil;
    __block SDLLanguage someLanguage = nil;
    __block SDLLanguage someOtherLanguage = nil;
    __block NSString *someAppName = nil;
    __block NSArray<SDLTTSChunk *> *someTTSChunks = nil;
    __block NSString *someNGNMediaAppName = nil;
    __block NSArray<NSString *> *someVRSynonyms = nil;
    
    describe(@"when initializing with properites", ^{
        context(@"when parameters are set", ^{
            beforeEach(^{
                testRequest = [[SDLChangeRegistration alloc] init];
                
                someLanguage = SDLLanguageItIt;
                someOtherLanguage = SDLLanguageKoKr;
                someAppName = @"someAppName";
                someTTSChunks = @[[[SDLTTSChunk alloc] init]];
                someNGNMediaAppName = @"some media app name";
                someVRSynonyms = @[@"some1", @"some2"];
                
                testRequest.language = someLanguage;
                testRequest.hmiDisplayLanguage = someOtherLanguage;
                testRequest.appName = someAppName;
                testRequest.ttsName = someTTSChunks;
                testRequest.ngnMediaScreenAppName = someNGNMediaAppName;
                testRequest.vrSynonyms = someVRSynonyms;
            });
            
            // Since the properties are immutable, a copy should be executed as a retain, so they should be identical
            it(@"should get language correctly", ^{
                expect(testRequest.language).to(beIdenticalTo(someLanguage));
            });
            
            it(@"should get hmi display language correctly", ^{
                expect(testRequest.hmiDisplayLanguage).to(beIdenticalTo(someOtherLanguage));
            });
            
            it(@"should get app name correctly", ^{
                expect(testRequest.appName).to(beIdenticalTo(someAppName));
            });
            
            it(@"should get tts chuncks correctly", ^{
                expect(testRequest.ttsName).to(beIdenticalTo(someTTSChunks));
            });
            
            it(@"should get ngn media app name correctly", ^{
                expect(testRequest.ngnMediaScreenAppName).to(beIdenticalTo(someNGNMediaAppName));
            });
            
            it(@"should get vr synonyms correctly", ^{
                expect(testRequest.vrSynonyms).to(beIdenticalTo(someVRSynonyms));
            });
        });
        
        context(@"when no parameters are set", ^{
            beforeEach(^{
                testRequest = [[SDLChangeRegistration alloc] init];
            });
            
            it(@"Should return nil if for language", ^ {
                expect(testRequest.language).to(beNil());
            });
            
            it(@"should return nil for hmi display language", ^{
                expect(testRequest.hmiDisplayLanguage).to(beNil());
            });
            
            it(@"should return nil for app name", ^{
                expect(testRequest.appName).to(beNil());
            });
            
            it(@"should return nil for tts name", ^{
                expect(testRequest.ttsName).to(beNil());
            });
            
            it(@"should return nil for ngn media screen app name", ^{
                expect(testRequest.ngnMediaScreenAppName).to(beNil());
            });
            
            it(@"should return nil for vr synonyms", ^{
                expect(testRequest.vrSynonyms).to(beNil());
            });
        });
    });
    
    describe(@"when initializing with a dictionary", ^{
        context(@"when parameters are set", ^{
            beforeEach(^{
                someLanguage = SDLLanguageItIt;
                someOtherLanguage = SDLLanguageKoKr;
                someAppName = @"someAppName";
                someTTSChunks = @[[[SDLTTSChunk alloc] init]];
                someNGNMediaAppName = @"some media app name";
                someVRSynonyms = @[@"some1", @"some2"];
                
                NSMutableDictionary<NSString *, id> *dict = [@{SDLRPCParameterNameRequest:
                                                                   @{SDLRPCParameterNameParameters:
                                                                         @{SDLRPCParameterNameLanguage:someLanguage,
                                                                           SDLRPCParameterNameHMIDisplayLanguage:someOtherLanguage,
                                                                           SDLRPCParameterNameAppName:someAppName,
                                                                           SDLRPCParameterNameTTSName:someTTSChunks,
                                                                           SDLRPCParameterNameNGNMediaScreenAppName:someNGNMediaAppName,
                                                                           SDLRPCParameterNameVRSynonyms:someVRSynonyms},
                                                                     SDLRPCParameterNameOperationName:SDLRPCFunctionNameChangeRegistration}} mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                testRequest = [[SDLChangeRegistration alloc] initWithDictionary:dict];
#pragma clang diagnostic pop
            });
            
            // Since the properties are immutable, a copy should be executed as a retain, so they should be identical
            it(@"should get language correctly", ^{
                expect(testRequest.language).to(beIdenticalTo(someLanguage));
            });
            
            it(@"should get hmi display language correctly", ^{
                expect(testRequest.hmiDisplayLanguage).to(beIdenticalTo(someOtherLanguage));
            });
            
            it(@"should get app name correctly", ^{
                expect(testRequest.appName).to(beIdenticalTo(someAppName));
            });
            
            it(@"should get tts chuncks correctly", ^{
                expect(testRequest.ttsName).to(beIdenticalTo(someTTSChunks));
            });
            
            it(@"should get ngn media app name correctly", ^{
                expect(testRequest.ngnMediaScreenAppName).to(beIdenticalTo(someNGNMediaAppName));
            });
            
            it(@"should get vr synonyms correctly", ^{
                expect(testRequest.vrSynonyms).to(beIdenticalTo(someVRSynonyms));
            });
        });
        
        context(@"when no parameters are set", ^{
            beforeEach(^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                testRequest = [[SDLChangeRegistration alloc] initWithDictionary:[NSMutableDictionary dictionary]];
#pragma clang diagnostic pop
            });
            
            it(@"Should return nil if for language", ^ {
                expect(testRequest.language).to(beNil());
            });
            
            it(@"should return nil for hmi display language", ^{
                expect(testRequest.hmiDisplayLanguage).to(beNil());
            });
            
            it(@"should return nil for app name", ^{
                expect(testRequest.appName).to(beNil());
            });
            
            it(@"should return nil for tts name", ^{
                expect(testRequest.ttsName).to(beNil());
            });
            
            it(@"should return nil for ngn media screen app name", ^{
                expect(testRequest.ngnMediaScreenAppName).to(beNil());
            });
            
            it(@"should return nil for vr synonyms", ^{
                expect(testRequest.vrSynonyms).to(beNil());
            });
        });
    });
});

QuickSpecEnd
