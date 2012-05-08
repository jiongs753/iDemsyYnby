//
//  DemsyAsyncImageView.m
//  demsy
//
//  Created by yongshan ji on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DemsyAsyncImageView.h"

@implementation DemsyAsyncImageView

@synthesize connection;
@synthesize data;
@synthesize cachedFile;
@synthesize imageView;


- (void)loadImageFromURL:(NSURL*)url {
    if (connection!=nil) { 
        [connection release]; 
    }
    if (data!=nil) { 
        [data release];
    }
    NSURLRequest* request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:60.0];
    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)theConnection
    didReceiveData:(NSData *)incrementalData {
    if (data==nil) {
        data = [[NSMutableData alloc] initWithCapacity:2048];
    }
    [data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
    
    [connection release];
    connection=nil;
    
    if (cachedFile != nil) {
        [[NSFileManager defaultManager] createFileAtPath:cachedFile contents:data attributes:nil];
    }    
    imageView.image=[UIImage imageWithData:data];
    
    [data release];
    data=nil;
}

- (void)dealloc {
    [connection cancel];
    [connection release];
    [data release];
    [super dealloc];
}



@end
