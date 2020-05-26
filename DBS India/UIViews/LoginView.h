//
//  LoginView.h
//  DBS India
//
//  Created by Chandrachud on 9/8/16.
//  Copyright © 2016 Chandrachud. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoginDelegate;

@interface LoginView : UIView
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (nonatomic, assign) id<LoginDelegate>delegate;

- (IBAction)continueClicked:(id)sender;
- (IBAction)forgotPassword:(id)sender;

@end

@protocol LoginDelegate <NSObject>

-(void)didLogin:(NSString *)userName password:(NSString *)password;
-(void)didForgetPassword;

@end
