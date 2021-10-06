//
//  IMModuleProtocol.h
//  IMRouter
//
//  Created by 姚佩江 on 2021/9/28.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IMServiceProtocol.h"

#define IMModuleDefaultPriority 100

@protocol IMModuleProtocol <UIApplicationDelegate,IMServiceProtocol>

@optional

+ (NSUInteger)priority;

+ (BOOL)setupModuleSynchronously;

- (void)setup;

@end
