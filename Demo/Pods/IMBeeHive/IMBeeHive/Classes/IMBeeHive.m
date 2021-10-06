//
//  IMBeeHive.m
//  IMRouter
//
//  Created by 姚佩江 on 2021/9/26.
//

#import "IMBeeHive.h"
#import "IMIocFactory.h"

@implementation IMBeeHive

#pragma mark - public

+ (instancetype)shareInstance
{
    static dispatch_once_t p;
    static id IMInstance = nil;
    
    dispatch_once(&p, ^{
        IMInstance = [[self alloc] init];
    });
    
    return IMInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.context = [IMApplicationContext shareInstance];
    }
    return self;
}

- (id)createImplFromProtocol:(Protocol *)protocol {
    return [[IMIocFactory shareInstance] getImplFromProtocol:protocol];;
}

-(void)registerAll {
    [[IMIocFactory shareInstance] registerPlist];
}

-(void)setupAll {
    [[IMIocFactory shareInstance] setupAllServices];
    [[IMIocFactory shareInstance] setupAllModules];
}

-(void)registerImpl:(Class)impl protocol:(Protocol *)protocol {
    [[IMIocFactory shareInstance] registerImplInstance:impl protocol:protocol];
}


@end
