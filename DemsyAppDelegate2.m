#import "DemsyAppDelegate2.h"
#import "DemsyTabBarController.h"
#import "DemsyMenuController.h"

@implementation DemsyAppDelegate2

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIApplicationDelegate

- (void)applicationDidFinishLaunching:(UIApplication*)application {
    TTNavigator* navigator = [TTNavigator navigator];
    navigator.persistenceMode = TTNavigatorPersistenceModeAll;
    navigator.window = [[[UIWindow alloc] initWithFrame:TTScreenBounds()] autorelease];
    
    TTURLMap* map = navigator.URLMap;
    
    // 任何不匹配的URL地址都将使用Web控制器打开——即通过内置浏览器打开
    [map from:@"*" toViewController:[TTWebController class]];
    
    // 这是一个共享的TabBar控制器（即APP主界面），意味着它只会在程序启动时被创建一次
    [map from:@"tt://tabBar" toSharedViewController:[DemsyTabBarController class]];
    
    // Menu controllers are also shared - we only create one to show in each tab, so opening
    // these URLs will switch to the tab containing the menu
    [map from:@"tt://menu/(initWithMenu:)" toSharedViewController:[DemsyMenuController class]];
    
    // 进入tabBar主界面之前先检查是否有历史界面存在
    if (![navigator restoreViewControllers]) {
        // 程序第一次启动是进入tabBar主界面
        [navigator openURLAction:[TTURLAction actionWithURLPath:@"tt://tabBar"]];
    }
}

- (BOOL)application:(UIApplication*)application handleOpenURL:(NSURL*)URL {
    [[TTNavigator navigator] openURLAction:[TTURLAction actionWithURLPath:URL.absoluteString]];
    return YES;
}

@end
