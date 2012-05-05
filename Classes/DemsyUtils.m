//
//  DemsyUtils.m
//  demsy
//
//  Created by yongshan ji on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DemsyUtils.h"

@implementation DemsyUtils

+ (UIImage *)loadImageFromUrl:(NSString *)url{
    if(url.length == 0){
        return nil;
    }
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%s%@", DEMSY_WEB_SERVER, url]]];
    UIImage *image = [[[UIImage alloc] initWithData:imageData] autorelease];
    
    [imageData release];
    
    return  image;
}

+ (NSURL *)url:(NSString *)relativePath{
    
    if(relativePath.length == 0){
        return nil;
    }

    if([relativePath characterAtIndex:0] == '/'){
        return [NSURL URLWithString:[NSString stringWithFormat:@"%s%@", DEMSY_WEB_SERVER, relativePath]];
    }
    
    return [NSURL URLWithString:relativePath];
}

@end
