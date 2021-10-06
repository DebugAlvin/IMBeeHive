//
//  IMDispatcherManager.h
//
//  Created by 姚佩江 on 2019/4/15.
//

#import <Foundation/Foundation.h>

@interface IMDispatcherManager : NSObject

/**
 实例化

 @return 实例
 */
+ (instancetype)shareInstance;

/**
 动态调用各个模块的appdelegate方法
 支持多参数,这里的参数只做转发不校验
 */
- (BOOL)performTarget:(Class)cls
                          action:(SEL)sel
                          params:(id)arg,...NS_REQUIRES_NIL_TERMINATION;

@end

