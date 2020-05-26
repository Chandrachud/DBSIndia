//
//  CardInfoCell.m
//  DBS India
//
//  Created by Chandrachud on 9/13/16.
//  Copyright © 2016 Chandrachud. All rights reserved.
//

#import "CardInfoCell.h"

@implementation CardInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.layer.shadowColor = [UIColor grayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 1.0;
    [self setSeparatorInset:UIEdgeInsetsZero];
    self.layoutMargins = UIEdgeInsetsZero;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
