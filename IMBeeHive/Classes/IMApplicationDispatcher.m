//
//  IMApplicationDispatcher.m
//  IMRouter
//
//  Created by 姚佩江 on 2021/9/28.
//

#import "IMApplicationDispatcher.h"
#import <objc/runtime.h>
@implementation UIApplication(Dispatcher)
static inline void
dispatcherHook(Class class,Method oriMethod,Method newMethod)
{
    BOOL isAddedMethod = class_addMethod(class, method_getName(oriMethod), method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        class_replaceMethod(class, method_getName(newMethod), method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}

static inline void
dispatcherMethod(Class class,SEL selector)
{
    Method oriMethod = class_getInstanceMethod(class, selector);
    NSString *oriSelName = NSStringFromSelector(method_getName(oriMethod));
    
    // 在IMApplicationExchange实现
    Method newMethod = class_getInstanceMethod([IMApplicationExchange class], NSSelectorFromString([NSString stringWithFormat:@"module_%@",oriSelName]));
    
    dispatcherHook(class, oriMethod, newMethod);
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oriMethod = class_getInstanceMethod([self class], @selector(setDelegate:));
        Method newMethod = class_getInstanceMethod([self class], @selector(dispatcher_setDelegate:));
        dispatcherHook([self class], oriMethod, newMethod);
    });
}

- (void)dispatcher_setDelegate:(id<UIApplicationDelegate>) delegate
{
    static dispatch_once_t delegateOnceToken;
    dispatch_once(&delegateOnceToken, ^{
        dispatcherMethod([delegate class], @selector(applicationDidFinishLaunching:));
        dispatcherMethod([delegate class], @selector(application:willFinishLaunchingWithOptions:));
        dispatcherMethod([delegate class], @selector(application:didFinishLaunchingWithOptions:));
        dispatcherMethod([delegate class], @selector(applicationWillResignActive:));
        dispatcherMethod([delegate class], @selector(applicationDidBecomeActive:));
        dispatcherMethod([delegate class], @selector(application:openURL:options:));
        dispatcherMethod([delegate class], @selector(application:handleOpenURL:));
        dispatcherMethod([delegate class], @selector(application:openURL:sourceApplication:annotation:));
        dispatcherMethod([delegate class], @selector(applicationDidReceiveMemoryWarning:));
        dispatcherMethod([delegate class], @selector(applicationWillTerminate:));
        dispatcherMethod([delegate class], @selector(applicationSignificantTimeChange:));
        dispatcherMethod([delegate class], @selector(application:didRegisterForRemoteNotificationsWithDeviceToken:));
        dispatcherMethod([delegate class], @selector(application:didFailToRegisterForRemoteNotificationsWithError:));
        dispatcherMethod([delegate class], @selector(application:didReceiveRemoteNotification:));
        dispatcherMethod([delegate class], @selector(application:didReceiveLocalNotification:));
        dispatcherMethod([delegate class], @selector(application:handleEventsForBackgroundURLSession:completionHandler:));
        dispatcherMethod([delegate class], @selector(application:handleWatchKitExtensionRequest:reply:));
        dispatcherMethod([delegate class], @selector(applicationShouldRequestHealthAuthorization:));
        dispatcherMethod([delegate class], @selector(applicationDidEnterBackground:));
        dispatcherMethod([delegate class], @selector(applicationWillEnterForeground:));
        dispatcherMethod([delegate class], @selector(applicationProtectedDataWillBecomeUnavailable:));
        dispatcherMethod([delegate class], @selector(applicationProtectedDataDidBecomeAvailable:));
        dispatcherMethod([delegate class], @selector(remoteControlReceivedWithEvent:));
    });
    [self dispatcher_setDelegate:delegate];
}
@end
