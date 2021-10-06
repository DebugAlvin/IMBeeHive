//
//  IMApplicationContext.m
//  IMRouter
//
//  Created by 姚佩江 on 2021/9/26.
//

#import "IMApplicationContext.h"

@interface IMApplicationContext()
@property(nonatomic, strong) NSMutableDictionary *servicesDict;
@property(nonatomic, strong) NSMutableDictionary *modulesDict;
@property(nonatomic, strong) NSMutableDictionary *allDict;
@end

@implementation IMApplicationContext

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
        self.configName = @"IMBeeHive.bundle/IMBeeHive";
        self.servicesDict  = [[NSMutableDictionary alloc] initWithCapacity:1];
        self.allDict = [[NSMutableDictionary alloc] initWithCapacity:1];
        self.modulesDict = [[NSMutableDictionary alloc] initWithCapacity:1];
    }

    return self;
}

- (id)getServiceInstanceFromServiceName:(NSString *)serviceName {
    return [self.servicesDict objectForKey:serviceName];
}

- (id)getInstanceFromProtocolName:(NSString *)protocolName {
    return [self.allDict objectForKey:protocolName];
}

- (NSArray *)getServiceImplArray {
    return self.servicesDict.allValues;
}

- (void)addServiceWithImplInstance:(id)implInstance serviceName:(NSString *)serviceName{
    [self.servicesDict setObject:implInstance forKey:serviceName];
    [self.allDict setObject:implInstance forKey:serviceName];
}


-(id)getModuleInstanceFromModuleName:(NSString *)moduleName {
    return [self.modulesDict objectForKey:moduleName];
}

-(void)addModuleWithImplInstance:(id)implInstance moduleName:(NSString *)moduleName {
    [self.modulesDict setObject:implInstance forKey:moduleName];
    [self.allDict setObject:implInstance forKey:moduleName];
}

-(NSArray *)getModulesImplArray {
    return self.modulesDict.allValues;
}

@end
