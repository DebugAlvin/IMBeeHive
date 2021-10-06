#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "IMDynamicModule.h"
#import "IMDynamicModuleProtocol.h"
#import "IMDynamicViewController.h"

FOUNDATION_EXPORT double IMDynamicMoudleVersionNumber;
FOUNDATION_EXPORT const unsigned char IMDynamicMoudleVersionString[];

