#import <Three20/Three20.h>

@interface DemsyMenuController : TTTableViewController {
    TTTabBar* _tabBar;
    NSUInteger _page;
}

@property(nonatomic) NSUInteger page;

@end