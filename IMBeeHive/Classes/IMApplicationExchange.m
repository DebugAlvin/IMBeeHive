//
//  IMApplicationExchange.m
//
//  Created by 姚佩江 on 2019/4/15.
//

#import "IMApplicationExchange.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "IMDispatcherManager.h"

@implementation IMApplicationExchange

#pragma mark - AppDelegate
- (void)module_applicationDidFinishLaunching:(UIApplication *)application
{
    [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:application, nil];
}

- (BOOL)module_application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions
{
    return [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:application, launchOptions?:[NSNull null], nil];
}

- (BOOL)module_application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions
{
    return [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:application, launchOptions?:[NSNull null], nil];
}

- (void)module_applicationDidBecomeActive:(UIApplication *)application
{
    [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:application, nil];
}
- (void)module_applicationWillResignActive:(UIApplication *)application
{
    [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:application, nil];
}
- (BOOL)module_application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options NS_AVAILABLE_IOS(9_0); // no equiv. notification. return NO if the application can't open for some reaso
{
    return [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:app,url,options, nil];
}

- (BOOL)module_application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:application,url, nil];
}

- (BOOL)module_application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:application,url,sourceApplication,annotation, nil];
}

- (void)module_applicationDidReceiveMemoryWarning:(UIApplication *)application;      // try to clean up as much memory as possible. next step is to terminate ap
{
    [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:application, nil];
}
- (void)module_applicationWillTerminate:(UIApplication *)application
{
    [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:application, nil];
}
- (void)module_applicationSignificantTimeChange:(UIApplication *)application;        // midnight, carrier time update, daylight savings time chang
{
    [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:application, nil];
}
- (void)module_application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken NS_AVAILABLE_IOS(3_0)
{
    [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:application,deviceToken, nil];
}
- (void)module_application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error NS_AVAILABLE_IOS(3_0)
{
    [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:application,error, nil];
}
- (void)module_application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo NS_AVAILABLE_IOS(3_0)
{
    [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:application,userInfo, nil];
}
- (void)module_application:(UIApplication *)application didReceiveLocalNotification:(NSDictionary *)userInfo NS_AVAILABLE_IOS(3_0)
{
    [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:application,userInfo, nil];
}
- (void)module_application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler NS_AVAILABLE_IOS(7_0)
{
    [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:application,identifier,completionHandler, nil];
}
- (void)module_application:(UIApplication *)application handleWatchKitExtensionRequest:(nullable NSDictionary *)userInfo reply:(void(^)(NSDictionary * __nullable replyInfo))reply NS_AVAILABLE_IOS(8_2)
{
    [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:application,userInfo,reply, nil];
}

- (void)module_applicationShouldRequestHealthAuthorization:(UIApplication *)application NS_AVAILABLE_IOS(9_0)
{
    [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:application, nil];
}
- (void)module_applicationDidEnterBackground:(UIApplication *)application NS_AVAILABLE_IOS(4_0)
{
    [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:application, nil];
}
- (void)module_applicationWillEnterForeground:(UIApplication *)application NS_AVAILABLE_IOS(4_0)
{
    [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:application, nil];
}
- (void)module_applicationProtectedDataWillBecomeUnavailable:(UIApplication *)application NS_AVAILABLE_IOS(4_0)
{
    [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:application, nil];
}
- (void)module_applicationProtectedDataDidBecomeAvailable:(UIApplication *)application    NS_AVAILABLE_IOS(4_0)
{
    [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:application, nil];
}

- (void)module_remoteControlReceivedWithEvent:(UIEvent *)event
{
    [[IMDispatcherManager shareInstance] performTarget:[IMApplicationExchange class] action:_cmd params:event, nil];
}

@end
