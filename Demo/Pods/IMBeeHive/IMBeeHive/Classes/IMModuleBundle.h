//
//  IMModuleBundle.h
//  IMBeeHive
//
//  Created by 姚佩江 on 2021/10/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IMModuleBundle : NSObject
/*
 * 根据bundle的名称获取bundle
 */
+ (NSBundle *)bundleWithName:(NSString *)bundleName;

//获取bundle 每次只要重写这个方法就可以在指定的bundle中获取对应资源
+ (NSBundle *)bundle;

//根据xib文件名称获取xib文件
+ (__kindof UIView *)viewWithXibFileName:(NSString *)fileName;

//根据图片名称获取图片
+ (UIImage *)imageNamed:(NSString *)imageName;

//根据sb文件名称获取对应sb文件
+ (UIStoryboard *)storyboardWithName:(NSString *)storyboardName;

//获取nib文件
+ (UINib *)nibWithName:(NSString *)nibName;

@end

NS_ASSUME_NONNULL_END
