//
//  PageControlCell.m
//  DBS India
//
//  Created by Chandrachud on 9/12/16.
//  Copyright © 2016 Chandrachud. All rights reserved.
//

#import "PageControlCell.h"
#import "Header.h"

@implementation PageControlCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //set up data
    //your swipeView should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    self.items = [NSMutableArray array];
    for (int i = 0; i < 5; i++)
    {
        [_items addObject:@(i)];
    }
    _swipeView.pagingEnabled = YES;
    self.pageControl.currentPage = 0;
    self.pageControl.pageIndicatorTintColor = YELLOW_BG;
    self.pageControl.numberOfPages = _items.count;
    
    [self setSeparatorInset:UIEdgeInsetsZero];
    self.layoutMargins = UIEdgeInsetsZero;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    //return the total number of items in the carousel
    return [_items count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg-down"]];
    imgView.frame = self.bounds;
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIView alloc] initWithFrame:self.swipeView.bounds];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    [view addSubview:imgView];

    //set background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    view.backgroundColor = [UIColor colorWithRed:red
                                           green:green
                                            blue:blue
                                           alpha:1.0];
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = [_items[index] stringValue];
    
    return view;
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return self.swipeView.bounds.size;
}
-(void)swipeViewDidEndDecelerating:(SwipeView *)swipeView
{
    self.pageControl.currentPage = swipeView.currentItemIndex;

}

-(void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index
{
    
}
@end
