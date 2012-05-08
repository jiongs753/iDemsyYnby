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

//#define DEMSY_TEST 1

#define DEMSY_PAGE_SIZE 20

#ifdef DEMSY_TEST

#define DEMSY_WEB_SERVER "http://192.168.1.117:9090"
#define DEMSY_URL_WEBINFO_PLIST "http://192.168.1.117:9090/ui/iphone/plistWebInfo/70/55"
#define DEMSY_URL_WEBINFO_DETAIL "http://192.168.1.117:9090/ui/iphone/detailWebInfo"
#define DEMSY_URL_PRODUCT_PLIST "http://192.168.1.117:9090/ui/iphone/plistProduct/55/55"
#define DEMSY_URL_PRODUCT_DETAIL "http://192.168.1.117:9090/ui/iphone/detailProduct"
#define DEMSY_URL_BBS_PLIST "http://192.168.1.117:9090/ui/iphone/plistBbs"
#define DEMSY_URL_BBS_DETAIL "http://192.168.1.117:9090/ui/iphone/detailBbs"
#define DEMSY_URL_BBS_REPLY_PLIST "http://192.168.1.117:9090/ui/iphone/plistBbsReply"
#define DEMSY_URL_BBS_REPLY_DETAIL "http://192.168.1.117:9090/ui/iphone/detailBbsReply"

#endif

#ifndef DEMSY_TEST

#define DEMSY_WEB_SERVER "http://www.yunnanbaiyao.com.cn"
#define DEMSY_URL_WEBINFO_PLIST "http://www.yunnanbaiyao.com.cn/ui/iphone/plistWebInfo/70/55"
#define DEMSY_URL_WEBINFO_DETAIL "http://www.yunnanbaiyao.com.cn/ui/iphone/detailWebInfo"
#define DEMSY_URL_PRODUCT_PLIST "http://www.yunnanbaiyao.com.cn/ui/iphone/plistProduct/55/55"
#define DEMSY_URL_PRODUCT_DETAIL "http://www.yunnanbaiyao.com.cn/ui/iphone/detailProduct"
#define DEMSY_URL_BBS_PLIST "http://www.yunnanbaiyao.com.cn/ui/iphone/plistBbs"
#define DEMSY_URL_BBS_DETAIL "http://www.yunnanbaiyao.com.cn/ui/iphone/detailBbs"
#define DEMSY_URL_BBS_REPLY_PLIST "http://www.yunnanbaiyao.com.cn/ui/iphone/plistBbsReply"
#define DEMSY_URL_BBS_REPLY_DETAIL "http://www.yunnanbaiyao.com.cn/ui/iphone/detailBbsReply"
#endif

#endif

@interface DemsyUtils : NSObject

+ (NSURL *) url:(NSString *)relativePath;

@end
