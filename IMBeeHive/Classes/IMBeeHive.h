//
//  IMBeeHive.h
//  IMRouter
//
//  Created by 姚佩江 on 2021/9/26.
//

#import <Foundation/Foundation.h>
#import "IMApplicationContext.h"
#import "IMModuleProtocol.h"
#import "IMServiceProtocol.h"


#define IMBeanRegister(service_protocol) [[IMBeeHive shareInstance] registerImpl:self.class protocol:@protocol(service_protocol) ];

#define IMGetBean(service_protocol) ((id<service_protocol>)[[IMBeeHive shareInstance] createImplFromProtocol:@protocol(service_protocol)])

NS_ASSUME_NONNULL_BEGIN

@interface IMBeeHive : NSObject

//save application global context
@property(nonatomic, strong) IMApplicationContext *context;

+ (instancetype)shareInstance;

- (id)createImplFromProtocol:(Protocol *)protocol;

-(void)registerImpl:(Class )impl protocol:(Protocol *)protocol;

-(void)registerAll;

-(void)setupAll;

@end

NS_ASSUME_NONNULL_END
