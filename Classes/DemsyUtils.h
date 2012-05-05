//
//  DemsyUtils.h
//  demsy
//
//  Created by yongshan ji on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#ifndef DEMSY_CONSTS
#define DEMSY_CONSTS

//网站服务器地址 192.168.1.10:9090
#define DEMSY_WEB_SERVER "http://www.yunnanbaiyao.com.cn"

#define DEMSY_URL_WEBINFO_PLIST "http://www.yunnanbaiyao.com.cn/ui/iphone/plistWebInfo"

//网站新闻详细内容访问地址，地址后面需要加上新闻ID作为参数
#define DEMSY_URL_WEBINFO_DETAIL "http://www.yunnanbaiyao.com.cn/ui/iphone/htmlWebInfo"

#endif

@interface DemsyUtils : NSObject

+ (UIImage *) loadImageFromUrl:(NSString *)url;
+ (NSURL *) url:(NSString *)relativePath;

@end
