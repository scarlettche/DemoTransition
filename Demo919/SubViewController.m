//
//  SubViewController.m
//  Demo919
//
//  Created by 车雨欣 on 2019/5/10.
//  Copyright © 2019 车雨欣. All rights reserved.
//

#import "SubViewController.h"
#import "TCGroupHomeTableView.h"

@interface SubViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet TCGroupHomeTableView *tableView;

@end
@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 400;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.gestureHandler.subContentOffset = scrollView.contentOffset;
    
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
    
    self.gestureHandler.subContentOffset = scrollView.contentOffset;
}
@end
