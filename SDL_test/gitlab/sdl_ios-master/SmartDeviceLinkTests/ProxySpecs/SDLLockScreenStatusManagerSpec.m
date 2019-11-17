//
//  SDLLockScreenStatusManagerSpec
//  SmartDeviceLink-iOS

#import <Quick/Quick.h>
#import <Nimble/Nimble.h>

#import "SDLHMILevel.h"
#import "SDLOnLockScreenStatus.h"
#import "SDLLockScreenStatusManager.h"
#import "SDLLockScreenStatus.h"


QuickSpecBegin(SDLLockScreenStatusManagerSpec)

describe(@"the lockscreen status manager", ^{
    __block SDLLockScreenStatusManager *lockScreenManager;
    beforeEach(^{
        lockScreenManager = [[SDLLockScreenStatusManager alloc] init];
    });
    
    it(@"should properly initialize user selected app boolean to false", ^{
        expect(@(lockScreenManager.userSelected)).to(beFalse());
    });
    
    it(@"should properly initialize driver is distracted boolean to false", ^{
        expect(@(lockScreenManager.driverDistracted)).to(beFalse());
    });
    
    it(@"should properly initialize hmi level object to nil", ^{
        expect(lockScreenManager.hmiLevel).to(beNil());
    });
    
    describe(@"when setting HMI level", ^{
        context(@"to FULL", ^{
            beforeEach(^{
                lockScreenManager.userSelected = NO;
                lockScreenManager.hmiLevel = SDLHMILevelFull;
            });
            
            it(@"should set user selected to true", ^{
                expect(@(lockScreenManager.userSelected)).to(beTrue());
            });
        });
        
        context(@"to LIMITED", ^{
            beforeEach(^{
                lockScreenManager.userSelected = NO;
                lockScreenManager.hmiLevel = SDLHMILevelLimited;
            });
            
            it(@"should set user selected to true", ^{
                expect(@(lockScreenManager.userSelected)).to(beTrue());
            });
        });
        
        context(@"to BACKGROUND", ^{
            beforeEach(^{
                lockScreenManager.hmiLevel = SDLHMILevelBackground;
            });
            
            context(@"when user selected is false", ^{
                beforeEach(^{
                    lockScreenManager.userSelected = NO;
                });
                
                it(@"should not alter the value", ^{
                    expect(@(lockScreenManager.userSelected)).to(beFalse());
                });
            });
            
            context(@"when user selected is true", ^{
                beforeEach(^{
                    lockScreenManager.userSelected = YES;
                });
                
                it(@"should not alter the value", ^{
                    expect(@(lockScreenManager.userSelected)).to(beTrue());
                });
            });
        });
        
        context(@"to NONE", ^{
            beforeEach(^{
                lockScreenManager.userSelected = YES;
                lockScreenManager.hmiLevel = SDLHMILevelNone;
            });
            
            it(@"should set user selected to false", ^{
                expect(@(lockScreenManager.userSelected)).to(beFalse());
            });
        });
    });
    
    describe(@"when getting lock screen status", ^{
        context(@"when HMI level is nil", ^{
            beforeEach(^{
                lockScreenManager.hmiLevel = nil;
            });
            
            it(@"should return lock screen off", ^{
                expect(lockScreenManager.lockScreenStatus).to(equal(SDLLockScreenStatusOff));
            });
        });
        
        context(@"when HMI level is NONE", ^{
            beforeEach(^{
                lockScreenManager.hmiLevel = SDLHMILevelNone;
            });
            
            it(@"should return lock screen off", ^{
                expect(lockScreenManager.lockScreenStatus).to(equal(SDLLockScreenStatusOff));
            });
        });
        
        context(@"when HMI level is BACKGROUND", ^{
            beforeEach(^{
                lockScreenManager.hmiLevel = SDLHMILevelBackground;
            });
            
            context(@"when user selected is true", ^{
                beforeEach(^{
                    lockScreenManager.userSelected = YES;
                });

                context(@"if we do not set the driver distraction state", ^{
                    it(@"should return lock screen required", ^{
                        expect(lockScreenManager.lockScreenStatus).to(equal(SDLLockScreenStatusRequired));
                    });
                });

                context(@"if we set the driver distraction state to false", ^{
                    beforeEach(^{
                        lockScreenManager.driverDistracted = NO;
                    });

                    it(@"should return lock screen optional", ^{
                        expect(lockScreenManager.lockScreenStatus).to(equal(SDLLockScreenStatusOptional));
                    });
                });

                context(@"if we set the driver distraction state to true", ^{
                    beforeEach(^{
                        lockScreenManager.driverDistracted = YES;
                    });

                    it(@"should return lock screen required", ^{
                        expect(lockScreenManager.lockScreenStatus).to(equal(SDLLockScreenStatusRequired));
                    });
                });
            });
            
            context(@"when user selected is false", ^{
                beforeEach(^{
                    lockScreenManager.userSelected = NO;
                });
                
                it(@"should return lock screen off", ^{
                    expect(lockScreenManager.lockScreenStatus).to(equal(SDLLockScreenStatusOff));
                });
            });
        });
        
        context(@"when HMI level is LIMITED", ^{
            beforeEach(^{
                lockScreenManager.hmiLevel = SDLHMILevelLimited;
            });
            
            context(@"if we do not set the driver distraction state", ^{
                it(@"should return lock screen required", ^{
                    expect(lockScreenManager.lockScreenStatus).to(equal(SDLLockScreenStatusRequired));
                });
            });
            
            context(@"if we set the driver distraction state to false", ^{
                beforeEach(^{
                    lockScreenManager.driverDistracted = NO;
                });
                
                it(@"should return lock screen optional", ^{
                    expect(lockScreenManager.lockScreenStatus).to(equal(SDLLockScreenStatusOptional));
                });
            });
            
            context(@"if we set the driver distraction state to true", ^{
                beforeEach(^{
                    lockScreenManager.driverDistracted = YES;
                });
                
                it(@"should return lock screen required", ^{
                    expect(lockScreenManager.lockScreenStatus).to(equal(SDLLockScreenStatusRequired));
                });
            });
        });
        
        context(@"when HMI level is FULL", ^{
            beforeEach(^{
                lockScreenManager.hmiLevel = SDLHMILevelFull;
            });
            
            context(@"if we do not set the driver distraction state", ^{
                it(@"should return lock screen required", ^{
                    expect(lockScreenManager.lockScreenStatus).to(equal(SDLLockScreenStatusRequired));
                });
            });
            
            context(@"if we set the driver distraction state to false", ^{
                beforeEach(^{
                    lockScreenManager.driverDistracted = NO;
                });
                
                it(@"should return lock screen optional", ^{
                    expect(lockScreenManager.lockScreenStatus).to(equal(SDLLockScreenStatusOptional));
                });
            });
            
            context(@"if we set the driver distraction state to true", ^{
                beforeEach(^{
                    lockScreenManager.driverDistracted = YES;
                });
                
                it(@"should return lock screen required", ^{
                    expect(lockScreenManager.lockScreenStatus).to(equal(SDLLockScreenStatusRequired));
                });
            });
        });
    });
    
    describe(@"when getting lock screen status notification", ^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        __block SDLOnLockScreenStatus *onLockScreenStatusNotification = nil;
#pragma clang diagnostic pop
        
        beforeEach(^{
            lockScreenManager.userSelected = YES;
            lockScreenManager.driverDistracted = NO;
            lockScreenManager.hmiLevel = SDLHMILevelLimited;
            
            onLockScreenStatusNotification = lockScreenManager.lockScreenStatusNotification;
        });
        
        it(@"should properly return user selected", ^{
            expect(onLockScreenStatusNotification.userSelected).to(beTrue());
        });
        
        it(@"should properly return driver distraction status", ^{
            expect(onLockScreenStatusNotification.driverDistractionStatus).to(beFalse());
        });
        
        it(@"should properly return HMI level", ^{
            expect(onLockScreenStatusNotification.hmiLevel).to(equal(SDLHMILevelLimited));
        });
        
        it(@"should properly return lock screen status", ^{
            expect(onLockScreenStatusNotification.lockScreenStatus).to(equal(SDLLockScreenStatusOptional));
        });
    });
});

QuickSpecEnd
