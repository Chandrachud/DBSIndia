//
//  LoginView.m
//  DBS India
//
//  Created by Chandrachud on 9/8/16.
//  Copyright © 2016 Chandrachud. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (IBAction)continueClicked:(id)sender
{
    if([self.delegate respondsToSelector:@selector(didLogin:password:)])
    {
        [self.delegate didLogin:self.userName.text password:self.password.text];
    }
}

- (IBAction)forgotPassword:(id)sender
{
    if([self.delegate respondsToSelector:@selector(didForgetPassword)])
    {
        [self.delegate didForgetPassword];
    }
}

@end
