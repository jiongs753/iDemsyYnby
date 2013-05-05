/*
#import <UIKit/UIKit.h>

#import "DemsyAppDelegate.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, nil);
    }
}
*/

#import <Three20/Three20.h>

int main(int argc, char *argv[]) {
	
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int retVal = UIApplicationMain(argc, argv, nil, @"DemsyAppDelegate2");
	[pool release];
	return retVal;
}
