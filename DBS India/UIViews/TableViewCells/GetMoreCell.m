//
//  GetMoreCell.m
//  DBS India
//
//  Created by Chandrachud on 9/13/16.
//  Copyright © 2016 Chandrachud. All rights reserved.
//

#import "GetMoreCell.h"

@implementation GetMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self addShadowToViews:_view1];
    [self addShadowToViews:_view2];
    [self setSeparatorInset:UIEdgeInsetsZero];
    self.layoutMargins = UIEdgeInsetsZero;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)addShadowToViews:(UIView*)view
{
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    view.layer.shadowOpacity = 0.5f;
}
@end
