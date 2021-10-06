//
//  AppDelegate.m
//  IMAudioLive
//
//  Created by 姚佩江 on 2021/10/5.
//

#import "AppDelegate.h"
#import <IMBeeHive/IMBeeHive.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

//这个方法会在AppDelegate之前 +load之后执行
__attribute__((constructor)) void loadBeeHiveMoudle () {
    [IMBeeHive shareInstance].context.configName = @"IMBeeHive.bundle/IMBeeHive";//可选，默认为IMBeeHive.bundle/IMBeeHive
    [[IMBeeHive shareInstance] registerAll]; //从配置里面注册所有moudle或者service
    [[IMBeeHive shareInstance] setupAll]; //设置ioc容器里面所有的对象
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}



@end
