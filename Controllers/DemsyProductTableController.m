//
//  DemsyProductTableController.m
//  iDemsyYnby
//
//  Created by yongshan ji on 12-5-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DemsyProductTableController.h"
#import "DemsyProductDetailController.h"
#import "DemsyUtils.h"
#import "DemsyAsyncImageView.h"


@implementation DemsyProductTableController

@synthesize tableView=_tableView;
@synthesize tableViewCell;
@synthesize toolbar;

@synthesize pageData;

@synthesize detailController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"产品";    
    // add product catalog button
    //UIBarButtonItem *catalogButton = [[UIBarButtonItem alloc] initWithTitle:@"分类" style:UIBarButtonItemStyleBordered target:self action:@selector(loadProductCatalog)];
    //self.navigationItem.rightBarButtonItem = catalogButton;
    //[catalogButton release];
    
    
    // 加载缓存数据
    [self reloadData];
    
    // 异步加载最新数据
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s",DEMSY_URL_PRODUCT_PLIST]];
    [self loadDataFromUrl:url];    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.tableView = nil;
    self.tableViewCell = nil;
    self.pageData = nil;
    self.detailController = nil;}

- (void)dealloc
{
    [super dealloc];
    
    [_tableView release];
    [tableViewCell release];
    [pageData release];
    [detailController release];}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *ret = (NSString *)[pageData objectForKey:@"totalRecords"];
    return [ret integerValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProductCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DemsyProductTableCell" owner:self options:nil];
        if([nib count] > 0){
            cell = self.tableViewCell;
        }else{
            NSLog(@"failed to load DemsyProductTableCell nib file!");
        }
    }
    
    DemsyProduct *dataModel = [self dataModelForRow:[indexPath row]];
    
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
        DemsyProductDetailController *controller = [[DemsyProductDetailController alloc] initWithNibName:@"DemsyProductDetailView" bundle:nil];
        
        self.detailController = controller;
        
        [controller release];
    }
    
    [self.navigationController pushViewController:detailController animated:YES];
    
    DemsyProduct *model = [self dataModelForRow:[indexPath row]];
    detailController.dataModel = model;
    detailController.title = [model title];
    [detailController.webView clearsContextBeforeDrawing];
    
    [detailController reload];
}

#pragma inner methods
- (DemsyProduct *) dataModelForRow: (NSInteger) row
{
    DemsyProduct *model = [[[DemsyProduct alloc] init] autorelease];
    
    NSArray *dataRows = (NSArray *)[pageData objectForKey:@"rows"];
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

- (NSString *) cachedFile{
    NSString *documentsDirectory =[NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
    NSString* path = [NSString stringWithFormat:@"%@/%@",documentsDirectory,@"product.plist"];

    return path;
}

- (void)processData{ 
    
    [self.asynLoadedData writeToFile:[self cachedFile] atomically:TRUE];
    
    [self reloadData];
    
    [_tableView reloadData];
}

- (void) reloadData{
    NSDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:[self cachedFile]];
    self.pageData = dic;
    [dic release];

}

- (void) loadProductCatalog{
}

@end
