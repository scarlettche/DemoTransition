//
//  ViewController.m
//  Demo919
//
//  Created by 车雨欣 on 2019/5/10.
//  Copyright © 2019 车雨欣. All rights reserved.
//

#import "ViewController.h"
#import "SubViewController.h"
#import "TCGroupHomeGestureHandler.h"

#define kPanOffsetFactor (150.0f)//偏移转场系数

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerTopConst;

@property (nonatomic, strong) TCGroupHomeGestureHandler *gestureHandler;

@property (nonatomic, assign) CGFloat containerViewOriginPosition;
@property (nonatomic, assign) CGFloat panOffset;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.containerView addGestureRecognizer:pan];
    
    self.containerViewOriginPosition = self.view.bounds.size.height - 200;
    self.containerTopConst.constant = self.containerViewOriginPosition;
    
    self.gestureHandler = [TCGroupHomeGestureHandler new];
    SubViewController *subVc = self.childViewControllers.firstObject;
    subVc.gestureHandler = self.gestureHandler;
}

#pragma mark -
- (void)panAction:(UIPanGestureRecognizer *)pan {
    if (self.gestureHandler.subContentOffset.y > 0 && self.containerTopConst.constant == 0) {
        return;
    }
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.panOffset = [pan locationInView:self.view].y;
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        CGFloat offset = (self.panOffset - [pan locationInView:self.view].y);
        if (offset > 0 && self.containerTopConst.constant == 0) {
            //  container置顶，无效操作
            return;
        }
        if (offset > 0) {
            self.containerTopConst.constant = _containerViewOriginPosition - offset;
        } else {
            self.containerTopConst.constant = fabs(offset);
        }
    } else {
        CGFloat offset = self.panOffset - [pan locationInView:self.view].y;
        if (offset > 0 && self.containerTopConst.constant == 0) {
            //  container置顶，无效操作
            return;
        }
        
        if (offset > 0) {
            if (offset > kPanOffsetFactor) {
                offset = 0;
            } else {
                offset = self.containerViewOriginPosition;
            }
        } else {
            offset = fabs(offset);
            
            if (offset > kPanOffsetFactor) {
                offset = self.containerViewOriginPosition;
            } else {
                offset = 0;
            }
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            self.containerTopConst.constant = offset;
            [self.view layoutIfNeeded];
        }];
    }
}

#pragma mark - UITabelViewDelegate & Datasource
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
@end
