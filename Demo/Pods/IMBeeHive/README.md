# 概述
IMBeeHive是用于iOS的App模块化编程的框架实现方案，本项目主要借鉴了阿里巴巴BeeHive，在此基础上通过逆向了一些大厂的APP使得功能更加强大完善。同时现在也在寻找一起开发这个框架的开发者，如果您对此感兴趣，请联系我的微信：alvinkk01.
# 背景
随着公司业务的不断发展，项目的功能越来越复杂，各个业务代码耦合也越来越多，解耦合和业务组件化（或者叫模块化）也迫在眉睫。 在网上组件化的文章很多，主要方案有三种：1.protocol-class 2.target-action 3.route，后来通过逆向一些大厂的app，发现这些组件化（或者叫模块化）的技术在大厂使用率挺高的，基本上也是基于这三种方案，但各家都是不同的实现方式，于是乎就萌生了开发一个比较全面的组件化框架的想法，开发者可以根据自己的喜好选择自己喜欢的方案实现解耦和业务组件化，而不需要重复造轮子。  

yy直播  
![image](https://user-images.githubusercontent.com/7621179/135894318-d3991488-ec6e-4aaf-b21f-de4acf7b07c3.png)  
抖音  
![2](https://user-images.githubusercontent.com/7621179/135894007-d89941bc-733c-461d-a75b-df5c412133f2.png)  
网易云音乐  
![3](https://user-images.githubusercontent.com/7621179/135894056-d52eeb00-d86b-4706-9940-f829da3b1bd5.png)  



# 项目特色
组件管理生命周期  
组件间通信  
使用protocol-class方案service无需注册  
支持route（计划更新）  
# Installation
pod "IMBeeHive"
