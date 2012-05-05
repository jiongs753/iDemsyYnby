//
//  DemsyAsyncImageView.h
//  demsy
//
//  Created by yongshan ji on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemsyAsyncImageView : NSObject
    
@property (retain, nonatomic) NSURLConnection  *connection;
@property (retain, nonatomic) NSMutableData *data;

@property (retain, nonatomic) UIImageView *imageView;

- (void)loadImageFromURL:(NSURL*)url ;

@end
