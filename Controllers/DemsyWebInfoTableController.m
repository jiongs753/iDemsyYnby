//
//  NewsViewController.m
//  demsy
//
//  Created by yongshan ji on 12-4-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DemsyWebInfoTableController.h"
#import "DemsyWebInfoDetailController.h"
#import "DemsyUtils.h"
#import "DemsyAsyncImageView.h"

@interface DemsyWebInfoTableController ()

@end

@implementation DemsyWebInfoTableController

@synthesize tableView=_tableView;
@synthesize tableViewCell;
@synthesize totalRecords;
@synthesize pageIndex;
@synthesize dataRows;

@synthesize detailController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"新闻";
    
    // 加载缓存数据
    [self reloadData];
    
    // 异步加载最新数据
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/%d",DEMSY_URL_WEBINFO_PLIST,1]];
    [self loadDataFromUrl:url];    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.tableView = nil;
    self.tableViewCell = nil;
    self.dataRows = nil;
    self.detailController = nil;}

- (void)dealloc
{
    [super dealloc];
    
    [_tableView release];
    [tableViewCell release];
    [dataRows release];
    [detailController release];}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return totalRecords;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WebInfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DemsyWebInfoTableCell" owner:self options:nil];
        if([nib count] > 0){
            cell = self.tableViewCell;
        }else{
            NSLog(@"failed to load DemsyWebInfoTableCell nib file!");
        }
    }
    	
    DemsyWebInfo *dataModel = [self dataModelForRow:[indexPath row]];
    
    if(dataModel == nil)
        return nil;
        
    UILabel *titleLabel = (UILabel *)[tableViewCell viewWithTag:1];
    titleLabel.text = [dataModel title];
    
    UILabel *summLabel = (UILabel *)[tableViewCell viewWithTag:2];
    summLabel.text = [dataModel summary];
    summLabel.numberOfLines=2;
    
    UIImageView *imageView = (UIImageView *)[tableViewCell viewWithTag:3];
    DemsyAsyncImageView *asyncImage = [[[DemsyAsyncImageView alloc] init] autorelease];
    asyncImage.imageView = imageView;
    NSURL *url = [DemsyUtils url:dataModel.image];
    [asyncImage loadImageFromURL:url];
        
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 69;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if(detailController == nil){
        DemsyWebInfoDetailController *controller = [[DemsyWebInfoDetailController alloc] initWithNibName:@"DemsyWebInfoDetailView" bundle:nil];
        
        self.detailController = controller;
        
        [controller release];
    }
    
    [self.navigationController pushViewController:detailController animated:YES];
    
    DemsyWebInfo *model = [self dataModelForRow:[indexPath row]];
    detailController.dataModel = model;
    detailController.title = [model title];
    [detailController.webView clearsContextBeforeDrawing];
    
    [detailController reload];
}

#pragma inner methods

- (NSString *) cachedFile{
    NSString *documentsDirectory =[NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
    NSString* path = [NSString stringWithFormat:@"%@/%@",documentsDirectory,@"webinfodata.plist"];
    
    return path;
}

- (DemsyWebInfo *) dataModelForRow: (NSInteger) row
{
    DemsyWebInfo *model = [[[DemsyWebInfo alloc] init] autorelease];
    
    if ([dataRows count] <= row){
        [self loadNextPage];
    }
    if ([dataRows count] <= row) {
        return nil;
    }
    
    NSDictionary *dataRow = (NSDictionary *)[dataRows objectAtIndex:row];
    model.ID = [dataRow objectForKey:@"id"];
    model.commentCount = [dataRow objectForKey: @"comment-count"];
    model.image = [dataRow objectForKey:@"image"];
    model.title = [dataRow objectForKey:@"title"];
    model.summary = [dataRow objectForKey:@"summary"];
    model.updated = [dataRow objectForKey:@"updated"];
    model.content = [dataRow objectForKey:@"content"];
    
    return model;
}


- (void)processData{
    [self.asynLoadedData writeToFile:[self cachedFile] atomically:TRUE];
    
    [self.dataRows removeAllObjects];
    [self reloadData];

    [_tableView reloadData];
}

- (void) reloadData{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:[self cachedFile]];
    NSArray *rows = [dic objectForKey:@"rows"];
    
    [self.dataRows addObjectsFromArray:rows];
    self.totalRecords = [[dic objectForKey: @"totalRecords"] integerValue];
    self.pageIndex = [[dic objectForKey: @"pageIndex"] integerValue];
    
    [dic release];
}

- (void) loadNextPage{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/%d",DEMSY_URL_WEBINFO_PLIST, pageIndex+1]];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfURL:url];
    NSArray *rows = [dic objectForKey:@"rows"];
    
    
    [self.dataRows addObjectsFromArray:rows];
    self.totalRecords = [[dic objectForKey: @"totalRecords"] integerValue];
    self.pageIndex = [[dic objectForKey: @"pageIndex"] integerValue];

}

@end
