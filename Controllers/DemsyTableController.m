//
//  DemsyTableController.m
//  iDemsyYnby
//
//  Created by yongshan ji on 12-5-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DemsyTableController.h"

@implementation DemsyTableController

@synthesize tableView=_tableView;
@synthesize tableViewCell;
@synthesize totalRecords;
@synthesize pageIndex;
@synthesize dataRows;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataRows = [[NSMutableArray alloc] init];
    
    // 加载缓存数据
    [self loadDataRowsFromCachedFile];
    
    // 异步加载最新数据
    [self asynLoadDataFromUrl:[self getURLForPageIndex:1]];   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.tableView = nil;
    self.tableViewCell = nil;
    self.dataRows = nil;
}

- (void)dealloc
{
    [super dealloc];
    
    [_tableView release];
    [tableViewCell release];
    [dataRows release];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return totalRecords;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat
{
    return 69;
}

#pragma mark - abstract methods will be override

- (NSString *) getCachedFileName{
    return nil;
}

- (NSURL *) getURLForPageIndex: (NSInteger) pageIndex
{
    return nil;
}

- (NSString *) getCachedFileName: (NSString *) fileName{
    NSString *documentsDirectory =[NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
    NSString* path = [NSString stringWithFormat:@"%@/%@",documentsDirectory,[fileName stringByReplacingOccurrencesOfString:@"/" withString:@"-"]];
    
    return path;
}

- (void)processAsynLoadedData{
    [self.asynLoadedData writeToFile:[self getCachedFileName] atomically:TRUE];
    
    [self.dataRows removeAllObjects];
    [self loadDataRowsFromCachedFile];
    
    [_tableView reloadData];
}

- (void) loadDataRowsFromCachedFile{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:[self getCachedFileName]];
    
    [self refreshCache:dic];
    
    [dic release];
}

- (void) loadNextPageFromURL{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfURL:[self getURLForPageIndex: pageIndex+1]];
    
    [self refreshCache:dic];
    
    [dic release];  
}

-(void) refreshCache: (NSDictionary *) result{
    NSArray *rows = [result objectForKey:@"rows"];
    
    [dataRows addObjectsFromArray:rows];
    self.totalRecords = [[result objectForKey: @"totalRecords"] integerValue];
    self.pageIndex = [[result objectForKey: @"pageIndex"] integerValue];}

@end
