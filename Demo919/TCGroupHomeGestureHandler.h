//
//  GestureHandler.h
//  TaLiCaiCommunity
//
//  Created by 车雨欣 on 2019/2/16.
//  Copyright (c) 2014 guoyalun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TCGroupHomeGestureHandler : NSObject
@property (nonatomic, assign) CGFloat containerTopConstant;

@property (nonatomic, assign) CGPoint superContentOffset;
@property (nonatomic, assign) CGPoint subContentOffset;
@end

NS_ASSUME_NONNULL_END
