//
//  SDLListFilesResponseSpec.m
//  SmartDeviceLink


#import <Foundation/Foundation.h>

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLListFilesResponse.h"
#import "SDLRPCParameterNames.h"
#import "SDLRPCFunctionNames.h"

QuickSpecBegin(SDLListFilesResponseSpec)

describe(@"Getter/Setter Tests", ^ {
    it(@"Should set and get correctly", ^ {
        SDLListFilesResponse* testResponse = [[SDLListFilesResponse alloc] init];
        
        testResponse.filenames = [@[@"Music/music.mp3", @"Documents/document.txt", @"Downloads/format.exe"] mutableCopy];
        testResponse.spaceAvailable = @500000000;
        
        expect(testResponse.filenames).to(equal([@[@"Music/music.mp3", @"Documents/document.txt", @"Downloads/format.exe"] mutableCopy]));
        expect(testResponse.spaceAvailable).to(equal(@500000000));
    });
    
    it(@"Should get correctly when initialized", ^ {
        NSMutableDictionary<NSString *, id> *dict = [@{SDLRPCParameterNameResponse:
                                                           @{SDLRPCParameterNameParameters:
                                                                 @{SDLRPCParameterNameFilenames:[@[@"Music/music.mp3", @"Documents/document.txt", @"Downloads/format.exe"] mutableCopy],
                                                                   SDLRPCParameterNameSpaceAvailable:@500000000},
                                                             SDLRPCParameterNameOperationName:SDLRPCFunctionNameListFiles}} mutableCopy];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        SDLListFilesResponse* testResponse = [[SDLListFilesResponse alloc] initWithDictionary:dict];
#pragma clang diagnostic pop
        
        expect(testResponse.filenames).to(equal([@[@"Music/music.mp3", @"Documents/document.txt", @"Downloads/format.exe"] mutableCopy]));
        expect(testResponse.spaceAvailable).to(equal(@500000000));
    });
    
    it(@"Should return nil if not set", ^ {
        SDLListFilesResponse* testResponse = [[SDLListFilesResponse alloc] init];
        
        expect(testResponse.filenames).to(beNil());
        expect(testResponse.spaceAvailable).to(beNil());
    });
});

QuickSpecEnd
