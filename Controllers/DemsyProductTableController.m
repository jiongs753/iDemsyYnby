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

@synthesize detailController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"产品";
    
    // add product catalog button
    //UIBarButtonItem *catalogButton = [[UIBarButtonItem alloc] initWithTitle:@"分类" style:UIBarButtonItemStyleBordered target:self action:@selector(loadProductCatalog)];
    //self.navigationItem.rightBarButtonItem = catalogButton;
    //[catalogButton release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.detailController = nil;
}

- (void)dealloc
{
    [super dealloc];
    
    [detailController release];
}

#pragma mark - Table view data source

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
    
    UILabel *titleLabel = (UILabel *)[self.tableViewCell viewWithTag:1];
    titleLabel.text = [dataModel title];
    
    UILabel *summLabel = (UILabel *)[self.tableViewCell viewWithTag:2];
    summLabel.text = [dataModel summary];
    
    UIImageView *imageView = (UIImageView *)[self.tableViewCell viewWithTag:3];
    DemsyAsyncImageView *asyncImage = [[[DemsyAsyncImageView alloc] init] autorelease];
    asyncImage.imageView = imageView;
    NSURL *url = [DemsyUtils url:dataModel.image];
    [asyncImage loadImageFromURL:url];
    
    return cell;
}

#pragma mark - Table view delegate

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
- (NSString *) getCachedFileName{
    NSString *documentsDirectory =[NSHomeDirectory()stringByAppendingPathComponent:@"Documents"];
    NSString* path = [NSString stringWithFormat:@"%@/%@",documentsDirectory,@"product.plist"];

    return path;
}

- (NSURL *) getURLForPageIndex: (NSInteger) pageIndex
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"%s/%d",DEMSY_URL_PRODUCT_PLIST,pageIndex]];
}

- (DemsyProduct *) dataModelForRow: (NSInteger) row
{
    DemsyProduct *model = [[[DemsyProduct alloc] init] autorelease];
    
    if (row != 0 && [self.dataRows count] <= row){
        [self loadNextPageFromURL];
    }
    if (row != 0 && [self.dataRows count] <= row){
        return nil;
    }
    
    NSDictionary *dataRow = (NSDictionary *)[self.dataRows objectAtIndex:row];
    model.ID = [dataRow objectForKey:@"id"];
    model.commentCount = [dataRow objectForKey: @"comment-count"];
    model.image = [dataRow objectForKey:@"image"];
    model.title = [dataRow objectForKey:@"title"];
    model.summary = [dataRow objectForKey:@"summary"];
    model.updated = [dataRow objectForKey:@"updated"];
    model.content = [dataRow objectForKey:@"content"];
    
    return model;
}


- (void) loadProductCatalog{
}

@end
