//
//  PageControlCell.h
//  DBS India
//
//  Created by Chandrachud on 9/12/16.
//  Copyright © 2016 Chandrachud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"

@interface PageControlCell : UITableViewCell<SwipeViewDataSource, SwipeViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, weak) IBOutlet SwipeView *swipeView;
@property (nonatomic, strong) NSMutableArray *items;

@property (assign, nonatomic) NSInteger index;

@end
