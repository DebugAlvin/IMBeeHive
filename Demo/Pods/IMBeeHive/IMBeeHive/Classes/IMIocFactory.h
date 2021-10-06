//
//  IMIocFactory.h
//  IMRouter
//
//  Created by 姚佩江 on 2021/9/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMIocFactory : NSObject


+(instancetype)shareInstance;

-(id)getImplFromProtocol:(Protocol *)protocol;

-(void)registerPlist;

-(void)setupAllServices;

-(void)setupAllModules;

-(id)registerImplInstance:(Class)implClass protocol:(Protocol *)protocol;

@end

NS_ASSUME_NONNULL_END
