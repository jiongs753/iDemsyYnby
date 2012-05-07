//
//  DemsyUtils.m
//  demsy
//
//  Created by yongshan ji on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DemsyUtils.h"

@implementation DemsyUtils


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
