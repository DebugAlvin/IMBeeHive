# 概述
IMBeeHive是用于iOS的App模块化编程的框架实现方案
# 背景
随着公司业务的不断发展，项目的功能越来越复杂，各个业务代码耦合也越来越多，解耦合和业务组件化（或者叫模块化）也迫在眉睫。 在网上组件化的文章很多，主要方案有三种：1.protocol-class 2.target-action 3.route 

yy直播  
![image](https://user-images.githubusercontent.com/7621179/135894318-d3991488-ec6e-4aaf-b21f-de4acf7b07c3.png)  
抖音  
![2](https://user-images.githubusercontent.com/7621179/135894007-d89941bc-733c-461d-a75b-df5c412133f2.png)  
网易云音乐  
![3](https://user-images.githubusercontent.com/7621179/135894056-d52eeb00-d86b-4706-9940-f829da3b1bd5.png)  

# 完整DEMO  
https://github.com/DebugAlvin/IMAudioLive

# 项目特色
组件管理生命周期  
组件间通信  
使用protocol-class方案service无需注册  
支持route（计划更新）  
# Installation
```
pod "IMBeeHive"
```
# 初始化
一.首先我们需要在主工程添加一个配置文件，这里我添加的是IMBeeHive.bundle/IMBeeHive.plist，通过配置plist我们可以在启动时注册所有的Moudle，实际开发的项目Moudle并不会很多，我目前开发的项目大概也就8个Moudle，IMLuanchMoudle、IMHomeMoudle、IMDynamicMoudle、IMChatMoudle、IMMineMoudle...，所以在推荐在plist里面统一注册Moudle
![image](https://user-images.githubusercontent.com/7621179/136272784-f90af222-7f01-4126-8dfd-d4e1d8e5b46b.png)

二.在主主工程加入__attribute__((constructor))，通常app启动流程为：  
1.所有Framework的+load方法   
2.所有Framework的c++构造方法  
3.主程序的+load方法   
4.主程序的c++构造方法  
我们在主程序Appdelegate之前做初始化,IMBeeHive才可以通过HOOK + NSInvocation方式让已经注册的Moudle管理Appdelegate的生命周期

```
__attribute__((constructor)) void loadBeeHiveMoudle () {  
    [IMBeeHive shareInstance].context.configName = @"IMBeeHive.bundle/IMBeeHive";//可选，默认为IMBeeHive.bundle/IMBeeHive  
    [[IMBeeHive shareInstance] registerAll]; //从配置里面注册所有moudle或者service  
    [[IMBeeHive shareInstance] setupAll]; //设置ioc容器里面所有的对象  
}  
```
# 创建Moudle
一.使用cocopods创建Moudle  

首先cd到主程序目录，然后执行命令pod lib create xxxxx

```
pod lib create IMLuanchMoudle
```

将会询问以下内容：  

1.What Language do you want to use?? [Swift / objC]  
2.Would you like to include a demo application with your Library? [Yes / No]  
3.Would you like to do view based testing? [Yes / No]  
4.What is your class prefix?  
  
创建成功后会打开Xcode   
<img width="491" alt="WeChat7ad9d59058808237942820048c7db9a3" src="https://user-images.githubusercontent.com/7621179/136320938-cbc53f65-0299-49ee-9ea9-529091700745.png">  
Example可以作为我们的壳工程，平时对模块的开发和调试可以在这里进行。另外我们需要配置IMLuanchMoudle.podspec，具体方法请参考DEMO  
  
新建一个IMLaunchModuleProtocol.h,值得注意的是我们必须遵循IMModuleProtocol协议  
  
```
#import <IMBeeHive/IMBeeHive.h>
/**
 The services provided by Launch module to other modules
 */
@protocol IMLaunchModuleProtocol <IMModuleProtocol>

-(void)doSomeTings;

@end

```
新建一个IMLuanchMoudle.h和IMLuanchMoudle.m  
```
//IMLuanchMoudle.h
#import <Foundation/Foundation.h>

#import "IMLaunchModuleProtocol.h"

static UIWindow *mWindow = nil;

NS_ASSUME_NONNULL_BEGIN

@interface IMLuanchMoudle : NSObject<IMLaunchModuleProtocol>

@end

NS_ASSUME_NONNULL_END  
```
```
//IMLuanchMoudle.m  
#import "IMLuanchMoudle.h"
#import "IMLuanchViewController.h"

@implementation IMLuanchMoudle

//每个Moudle必须实现shareInstance方法，编译器会提醒
+ (instancetype)shareInstance {
    static dispatch_once_t p;
    static id Instance = nil;
    dispatch_once(&p, ^{
        Instance = [[self alloc] init];
    });
    return Instance;
}

//如果我们当前的模块是主模块，我们可以实现didFinishLaunchingWithOptions设置rootViewController
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"[IMLuanchMoudle] --- [执行]");
    mWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    mWindow.backgroundColor = [UIColor whiteColor];
    [mWindow makeKeyAndVisible];
    [UIApplication sharedApplication].delegate.window = mWindow;
    mWindow.rootViewController = [[IMLuanchViewController alloc] init];
    return YES;
}

- (void)doSomeTings {
    NSLog(@"通过IMLaunchModuleProtocol协议调用IMLuanchMoudle的doSomeTings方法");
}


```  
# 模块间的互相调用  
首先我们需要在Protocol暴露方法
```  
#import <IMBeeHive/IMBeeHive.h>
#import <IMBeeHive/IMBeeHive.h>

@protocol IMMineModuleProtocol <IMModuleProtocol>

- (UIViewController *)mainViewController;
-(void)doSomeTingsA;
-(void)doSomeTingsB;


@end
```  
然后在Protocol的实现类实现这些方法  
```
#import "IMMineModule.h"
#import "IMMIneViewController.h"

@implementation IMMineModule

+ (instancetype)shareInstance {
    static dispatch_once_t p;
    static id Instance = nil;
    dispatch_once(&p, ^{
        Instance = [[self alloc] init];
    });
    return Instance;
}

-(UIViewController *)mainViewController {
    IMMIneViewController *controller = [[IMMIneViewController alloc] init];
    return controller;
}

- (void)doSomeTingsA {
    NSLog(@"通过IMLaunchModuleProtocol协议调用IMLuanchMoudle的doSomeTingsA方法");
}

- (void)doSomeTingsB {
    NSLog(@"通过IMLaunchModuleProtocol协议调用IMLuanchMoudle的doSomeTingsB方法");
}


@end  
``` 
    
最后我们可以在任意模块通过Protocol调用实现类的方法  
``` 
id<IMMineModuleProtocol> pModule = IMGetBean(IMMineModuleProtocol);
[pModule doSomeTingsA];
[pModule doSomeTingsB];
UIViewController *controller = [pModule mainViewController];
[self.navigationController pushViewController:controller animated:YES];  
```  
