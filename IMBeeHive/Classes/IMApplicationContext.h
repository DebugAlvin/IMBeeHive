//
//  IMApplicationContext.h
//  IMRouter
//
//  Created by 姚佩江 on 2021/9/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMApplicationContext : NSObject

@property(nonatomic, strong) NSString *configName;

+ (instancetype)shareInstance;

- (id)getInstanceFromProtocolName:(NSString *)protocolName;

- (void)addServiceWithImplInstance:(id)implInstance serviceName:(NSString *)serviceName;

- (NSArray *)getServiceImplArray;

- (id)getModuleInstanceFromModuleName:(NSString *)moduleName;

- (void)addModuleWithImplInstance:(id)implInstance moduleName:(NSString *)moduleName;

- (NSArray *)getModulesImplArray;

@end

NS_ASSUME_NONNULL_END
