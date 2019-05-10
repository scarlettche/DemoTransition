//
//  TableView1.m
//  TaLiCaiCommunity
//
//  Created by 车雨欣 on 2019/2/16.
//  Copyright (c) 2014 guoyalun. All rights reserved.
//

#import "TCGroupHomeTableView.h"

@interface TCGroupHomeTableView () <UIGestureRecognizerDelegate>

@end
@implementation TCGroupHomeTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    NSInteger tag = gestureRecognizer.view.tag;
    NSInteger otherTag = otherGestureRecognizer.view.tag;
    return YES;
}
//
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    if ([otherGestureRecognizer.view isKindOfClass:[UICollectionView class]] || otherGestureRecognizer.view.tag == 1000) {
//        return YES;
//    }
//
//    return NO;
//}

@end
