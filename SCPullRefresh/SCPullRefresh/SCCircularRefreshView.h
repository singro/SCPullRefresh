//
//  SCCircularRefreshView.h
//  newSponia
//
//  Created by Singro on 5/27/14.
//  Copyright (c) 2014 Sponia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCCircularRefreshView : UIView

@property (nonatomic, assign) BOOL isLoadMore;

@property (nonatomic, assign) CGFloat timeOffset;  // 0.0 ~ 1.0

- (void)beginRefreshing;
- (void)endRefreshing;

@end
