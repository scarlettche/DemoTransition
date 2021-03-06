//
//  SubViewController.h
//  Demo919
//
//  Created by 车雨欣 on 2019/5/10.
//  Copyright © 2019 车雨欣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCGroupHomeGestureHandler.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SubViewControllerType) {
    SubViewControllerTypeFollow,
    SubViewControllerTypeIndependent
};
@interface SubViewController : UIViewController
@property (nonatomic, assign) SubViewControllerType type;

@property (nonatomic, strong) TCGroupHomeGestureHandler *gestureHandler;

@end

NS_ASSUME_NONNULL_END
