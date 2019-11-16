#import "SDLEventEmitter.h"
#import "ProxyManager.h"
#import <React/RCTConvert.h>
#import <SmartDeviceLink/SmartDeviceLink.h>

@implementation SDLEventEmitter

RCT_EXPORT_MODULE()

- (instancetype)init {
    self = [super init];
    // Subscribe to event notifications sent from ProxyManager
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getDoActionNotification:) name:<#Notification Name#> object:nil];

    return self;
}

// Required Method defining known action names
- (NSArray<NSString *> *)supportedEvents {
    return @[@"DoAction"];
}

// Run this code when the subscribed event notification is received
- (void)getDoActionNotification:(NSNotification *)notification {
    if(self.sdlManager == nil) {
        self.sdlManager = notification.userInfo[@"sdlManager"];
    }

    // Send the event to your React Native code with a dictionary of information
    [self sendEventWithName:@"DoAction" body:@{@"type": @"actionType"}];
}


RCT_EXPORT_METHOD(eventCall:(NSDictionary *)dict) {
    [self.sdlManager.screenManager beginUpdates];

    self.sdlManager.screenManager.textField1 = [NSString stringWithFormat:@"Low: %@ ºF", [RCTConvert NSString:dict[@"data"][@"low"]]];
    self.sdlManager.screenManager.textField2 = [NSString stringWithFormat:@"High: %@ ºF", [RCTConvert NSString:dict[@"data"][@"high"]]];

    [self.sdlManager.screenManager endUpdatesWithCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            <#Error#>
        } else {
            <#Success#>
        }
    }];
}


@end