//
//  SCRootViewController.m
//  SCPullRefresh
//
//  Created by Singro on 8/14/14.
//  Copyright (c) 2014 Singro. All rights reserved.
//

#import "SCRootViewController.h"

@interface SCRootViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation SCRootViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    self.tableView                 = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    [self.view addSubview:self.tableView];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"SCPullRefresh";
    
    __weak typeof(SCRootViewController) *weakSelf = self;
    
    self.refreshBlock = ^{
        
        __strong typeof(SCRootViewController) *strongSelf = weakSelf;
        
        [strongSelf performSelector:@selector(endRefresh) withObject:strongSelf afterDelay:2.0];
        
    };
    
    self.loadMoreBlock = ^{
        
        __strong typeof(SCRootViewController) *strongSelf = weakSelf;
        
        [strongSelf performSelector:@selector(endLoadMore) withObject:strongSelf afterDelay:2.0];

    };
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"row %zd", indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
