@implementation ProxyManager

RCT_EXPORT_MODULE();

SDLSoftButtonObject *softButton = [[SDLSoftButtonObject alloc] initWithName:@"Button" state:[[SDLSoftButtonState alloc] initWithStateName:@"State 1" text:@"Data" artwork:nil] handler:^(SDLOnButtonPress * _Nullable buttonPress, SDLOnButtonEvent * _Nullable buttonEvent) {
    if (buttonPress == nil) { return; }

    NSDictionary *userInfo = @{@"sdlManager": self.sdlManager};
    [[NSNotificationCenter defaultCenter] postNotificationName:<#Notification Name#> object:nil userInfo:managers];
}];

self.sdlManager.screenManager.softButtonObjects = @[softButton];

@end