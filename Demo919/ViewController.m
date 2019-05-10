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
#define kContainerViewStayHeight (200.0f)// containerView预留高度

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerTopConst;

@property (nonatomic, strong) SubViewController *subVC;
@property (nonatomic, strong) TCGroupHomeGestureHandler *gestureHandler;

@property (nonatomic, assign) CGFloat containerViewOriginPosition;
@property (nonatomic, assign) CGFloat scrollViewOriginPosition;//跟随时，拖动container，scrollview的原始位置

@property (nonatomic, assign) CGFloat panOffset;

@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;

@property (nonatomic, assign) BOOL handleScroll;//scroll正在交互
@property (nonatomic, assign) BOOL handlePan;//containerView正在交互
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.containerView addGestureRecognizer:self.panGesture];
    
    self.containerViewOriginPosition = self.view.bounds.size.height - kContainerViewStayHeight;
    self.containerTopConst.constant = self.containerViewOriginPosition;
    self.gestureHandler.containerTopConstant = self.containerTopConst.constant;
    
    self.gestureHandler = [TCGroupHomeGestureHandler new];
    self.subVC = self.childViewControllers.firstObject;
    self.subVC.gestureHandler = self.gestureHandler;
    self.subVC.type = SubViewControllerTypeIndependent;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:_subVC.view.frame];
}

#pragma mark -
- (void)panAction:(UIPanGestureRecognizer *)pan {
    
    if (self.subVC.type == SubViewControllerTypeFollow) {
        if (pan.state == UIGestureRecognizerStateBegan) {
            self.handlePan = YES;
            self.panOffset = [pan locationInView:self.view].y;
            self.scrollViewOriginPosition = self.tableView.contentOffset.y;
        } else if (pan.state == UIGestureRecognizerStateChanged) {
            CGFloat offset = (self.panOffset - [pan locationInView:self.view].y);
            if (offset > 0 && self.containerTopConst.constant == 0) {
                //  container置顶，无效操作
                return;
            }
            if (offset > 0) {
//                self.containerTopConst.constant = _containerViewOriginPosition - offset;
            } else {
//                self.containerTopConst.constant = fabs(offset);
            }
            
            [self.tableView setContentOffset:CGPointMake(0, self.scrollViewOriginPosition + offset) animated:YES];
        } else {
            self.handlePan = NO;
        }
    } else {
        
        if (self.gestureHandler.subContentOffset.y > 0 && self.containerTopConst.constant == 0) {
            self.gestureHandler.containerTopConstant = self.containerTopConst.constant;
            
            return;
        }
        
        self.subVC.type = SubViewControllerTypeIndependent;
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
            
            self.gestureHandler.containerTopConstant = self.containerTopConst.constant;
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (self.handlePan == YES) {
//        return;
//    }
    
    self.handleScroll = YES;
    CGFloat offset = scrollView.contentOffset.y - (scrollView.contentSize.height - [self.childViewControllers.firstObject view].frame.size.height * 2 + kContainerViewStayHeight);
    if (offset < 0) {
        self.subVC.type = SubViewControllerTypeIndependent;
        offset = 0;
    }
    
    self.subVC.type = SubViewControllerTypeFollow;
    if (offset > 0 && offset < 612) {
//        self.panGesture.enabled = NO;
        
        self.containerTopConst.constant = self.containerViewOriginPosition - offset;
        self.gestureHandler.containerTopConstant = self.containerTopConst.constant;
    } else {
//        self.panGesture.enabled = YES;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        self.handleScroll = NO;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.handleScroll = NO;
}
#pragma mark - UITabelViewDelegate & Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
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
