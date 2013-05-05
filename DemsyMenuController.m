#import "DemsyMenuController.h"

@implementation DemsyMenuController

@synthesize page = _page;

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithMenu:(NSUInteger)page {
    if (self = [super init]) {
        self.page = page;
    }
    return self;
}

- (NSString*)nameForMenuPage:(NSUInteger)page {
    switch (page) {
        case 1:
            return @"新闻";
        case 2:
            return @"产品";
        case 3:
            return @"论坛";
        case 4:
            return @"会员";
        case 5:
            return @"更多";
        default:
            return @"";
    }
}


- (NSArray*)submenusForMenuPage:(NSUInteger)page {
    switch (page) {
        case 1:
            return [NSArray arrayWithObjects:
                    [[[TTTabItem alloc] initWithTitle:@"资讯"] autorelease],
                    [[[TTTabItem alloc] initWithTitle:@"公告"] autorelease],
                    [[[TTTabItem alloc] initWithTitle:@"媒体"] autorelease],
                    [[[TTTabItem alloc] initWithTitle:@"访谈"] autorelease],
                    [[[TTTabItem alloc] initWithTitle:@"图片"] autorelease],
                    [[[TTTabItem alloc] initWithTitle:@"更多"] autorelease],
                    nil];
        case 2:
            return nil;
        case 3:
            return nil;
        case 4:
            return nil;
        case 5:
            return nil;
        default:
            return nil;
    }
}

- (UIImage*)imgForMenuPage:(NSUInteger)page {
    switch (page) {
        case 1:
            return [UIImage imageNamed:@"news.png"];
        case 2:
            return [UIImage imageNamed:@"product.png"];
        case 3:
            return [UIImage imageNamed:@"bbs.png"];
        case 4:
            return [UIImage imageNamed:@"office.png"];
        case 5:
            return [UIImage imageNamed:@"other.png"];
        default:
            return nil;
    }
}

- (void) setPage:(NSUInteger)page {
    _page = page;
    
    //设置菜单标题    
    self.title = [self nameForMenuPage:page];
    
    //设置菜单图片
    UIImage* image = [self imgForMenuPage:page];
    self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:self.title image:image tag:0] autorelease];
    
    
    self.dataSource = [TTListDataSource dataSourceWithObjects:
                       [TTTableTextItem itemWithText:@"Porridge" URL:@"tt://food/porridge"],
                       [TTTableTextItem itemWithText:@"Bacon & Eggs" URL:@"tt://food/baconeggs"],
                       [TTTableTextItem itemWithText:@"French Toast" URL:@"tt://food/frenchtoast"],
                       
                       [TTTableTextItem itemWithText:@"Coffee" URL:@"tt://food/coffee"],
                       [TTTableTextItem itemWithText:@"Orange Juice" URL:@"tt://food/oj"],
                       
                       [TTTableTextItem itemWithText:@"Just Desserts" URL:@"tt://menu/4"],
                       [TTTableTextItem itemWithText:@"Complaints" URL:@"tt://about/complaints"],
                       nil];
}

- (void) viewDidLoad{
    
    //[self.navigationController setNavigationBarHidden:YES animated:NO];
    
    //设置子菜单
	CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;
    _tabBar = [[TTTabBar alloc] initWithFrame:CGRectMake(0, 0, applicationFrame.size.width, 30)];
    _tabBar.tabItems = [self submenusForMenuPage:self.page];
    
    [self.navigationController.navigationBar.subviews:[NSArray arrayWithObjects:
                                                       _tabBar,
                                                       nil]];
}

- (void)dealloc {
    TT_RELEASE_SAFELY(_tabBar);
    
    [super dealloc];
}

@end
