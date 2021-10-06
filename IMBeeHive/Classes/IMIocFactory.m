//
//  IMIocFactory.m
//  IMRouter
//
//  Created by 姚佩江 on 2021/9/26.
//

#import "IMIocFactory.h"
#import "IMServiceProtocol.h"
#import "IMApplicationContext.h"
#import <objc/runtime.h>
#import "IMModuleProtocol.h"

static NSString *const ProtocolStringID = @"Protocol";

#define APP_EXECUTE_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleExecutableKey]

@interface IMIocFactory()


@end

@implementation IMIocFactory

+ (instancetype)shareInstance {
    static dispatch_once_t p;
    static id IMInstance = nil;
    dispatch_once(&p, ^{
        IMInstance = [[self alloc] init];
    });
    return IMInstance;
}


-(NSArray *)allregisterClasss {
    return [[IMApplicationContext shareInstance] getServiceImplArray];;
}

-(NSArray *)allRegisterModules {
    NSArray *modules = [[IMApplicationContext shareInstance] getModulesImplArray];
    NSArray *sortedModules = [modules sortedArrayUsingComparator:^NSComparisonResult(Class class1, Class class2) {
        NSUInteger priority1 = IMModuleDefaultPriority;
        NSUInteger priority2 = IMModuleDefaultPriority;
        if ([class1 respondsToSelector:@selector(priority)]) {
            priority1 = [class1 priority];
        }
        if ([class2 respondsToSelector:@selector(priority)]) {
            priority2 = [class2 priority];
        }
        if(priority1 == priority2) {
            return NSOrderedSame;
        } else if(priority1 < priority2) {
            return NSOrderedDescending;
        } else {
            return NSOrderedAscending;
        }
    }];
    return sortedModules;
}


-(void)setupAllServices {
  
}

-(void)setupAllModules {
    NSArray *modules = [self allRegisterModules];
    for (id<IMModuleProtocol> implInstance in modules) {
        BOOL setupSync = NO;
        if ([implInstance respondsToSelector:@selector(setupModuleSynchronously)]) {
            setupSync = [implInstance setupModuleSynchronously];
        }
        if ([implInstance respondsToSelector:@selector(setup)]) {
            if (setupSync) {
                [implInstance setup];
            } else {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [implInstance setup];
                });
            }
        }
    }
    
}

- (void)registerPlist {
    NSString *configName = [IMApplicationContext shareInstance].configName;
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:configName ofType:@"plist"];
    if (!plistPath) {
        return;
    }
    
    NSArray *itemList = [[NSArray alloc] initWithContentsOfFile:plistPath];

    for (NSDictionary *dict in itemList) {
        NSString *protocolKey = [dict objectForKey:@"protocol"];
        NSString *impl = [dict objectForKey:@"impl"];
    
        id protocolImpl = [[IMApplicationContext shareInstance] getInstanceFromProtocolName:protocolKey];
        if (protocolImpl) {
            continue;
        }
        
        Class implClass = NSClassFromString(impl);
        Protocol *protocol = NSProtocolFromString(protocolKey);

        if ([self checkIfServiceProtocol:implClass protocol:protocol]) {
            [self registerImplInstance:implClass protocol:protocol];
        }
        
    }
   
}

-(id)getImplFromProtocol:(Protocol *)protocol {
    id implInstance = nil;
    NSString *protocolName = NSStringFromProtocol(protocol);
    
    //检查Context是否存在实例的缓存，直接从内存里面读取
    id protocolImpl = [[IMApplicationContext shareInstance] getInstanceFromProtocolName:protocolName];
    if (protocolImpl) {
        return protocolImpl;
    }
    Class implClass = [self registerImplFromProtocol:protocol];
    
    if (!implClass) {
        NSAssert(0, @"The class or protocol : %@ does not conform to the naming convention", protocolName);
    }
    
    //注册实例子并添加到IOC容器
    implInstance = [self registerImplInstance:implClass protocol:protocol];
    
    return implInstance;
}

/*
 * 检查是否实现了单例方法,已经实现单例方法直接返回shareInstance，否则使用init无参构造方法
 * 最后将对象加入到IOC容器里面
 */
-(id)registerImplInstance:(Class)implClass protocol:(Protocol *)protocol {
    id implInstance = nil;
    if ([[implClass class] respondsToSelector:@selector(shareInstance)]) {
        implInstance = [[implClass class] shareInstance];
    }else{
        NSAssert(0, @"The class : %@ must achieve shareInstance", NSStringFromClass(implClass));
    }
    //把Instance加入到Context
    [self addProtocolWithImplInstance:implInstance protocol:protocol];
    return implInstance;
}



#pragma mark - private


- (Class)registerImplFromProtocol:(Protocol *)protocol {
    NSParameterAssert(protocol != nil);
    Class implClass = nil;
        
    NSString *classString = [NSStringFromProtocol(protocol) stringByReplacingOccurrencesOfString:ProtocolStringID withString:@""];
    Class aClass = NSClassFromString(classString);
    implClass = [self registerClass:aClass protocol:protocol];
    if (implClass) {
        return implClass;
    }
//    //自动注册service
//    NSString *serviceClassString = [NSStringFromProtocol(protocol) stringByReplacingOccurrencesOfString:ProtocolStringID withString:ServiceClassStringID];
//    Class serviceClass = NSClassFromString(serviceClassString);
//    implClass = [self registerClass:serviceClass protocol:protocol];
//    if (implClass) {
//        return implClass;
//    }
//
//    //自动注册module
//    NSString *moduleClassString = [NSStringFromProtocol(protocol) stringByReplacingOccurrencesOfString:ProtocolStringID withString:ModuleClassStringID];
//    Class moduleClass = NSClassFromString(moduleClassString);
//    implClass = [self registerClass:moduleClass protocol:protocol];
//    if (implClass) {
//        return implClass;
//    }
    
    return nil;
}

- (Class)registerClass:(Class )impl protocol:(Protocol *)protocol {
    Class implClass = nil;
    if ([self checkIfServiceProtocol:impl protocol:protocol]) {
        implClass = impl;
    }
    return implClass;
}


/**
 * 校验合法性，并检查是否实现了IMServiceProtocol
 */
-(BOOL)checkIfServiceProtocol:(Class )impl protocol:(Protocol *)protocol {
    
    NSParameterAssert(protocol != nil);
    NSParameterAssert(impl != nil);
    
    if (![impl conformsToProtocol:@protocol(IMServiceProtocol)]) {
        NSLog(@"%@ not conformsToProtocol: IMServiceProtocol", impl);
        return NO;
    }
    
    if (!protocol_conformsToProtocol(protocol, @protocol(IMServiceProtocol))) {
        NSLog(@"%@ not conformsToProtocol: %@", impl,protocol);
        return NO;
    }
    return YES;
}


-(void)addProtocolWithImplInstance:(id)implInstance protocol:(Protocol *)protocol {
    NSString *protocolName = NSStringFromProtocol(protocol);
    if (protocol_conformsToProtocol(protocol, @protocol(IMModuleProtocol))) {
        [[IMApplicationContext shareInstance] addModuleWithImplInstance:implInstance moduleName:protocolName];
    }else{
        [[IMApplicationContext shareInstance] addServiceWithImplInstance:implInstance serviceName:protocolName];
    }
}

@end
