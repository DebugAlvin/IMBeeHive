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

#import "IMApplicationContext.h"
#import "IMApplicationDispatcher.h"
#import "IMApplicationExchange.h"
#import "IMBeeHive.h"
#import "IMDispatcherManager.h"
#import "IMIocFactory.h"
#import "IMModuleBundle.h"
#import "IMModuleProtocol.h"
#import "IMServiceProtocol.h"

FOUNDATION_EXPORT double IMBeeHiveVersionNumber;
FOUNDATION_EXPORT const unsigned char IMBeeHiveVersionString[];

