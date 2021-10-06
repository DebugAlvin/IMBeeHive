//
//  IMServiceProtocol.h
//  IMRouter
//
//  Created by 姚佩江 on 2021/9/26.
//

#import <Foundation/Foundation.h>


@protocol IMServiceProtocol <UIApplicationDelegate,NSObject>

@required

+ (instancetype)shareInstance;

@end
