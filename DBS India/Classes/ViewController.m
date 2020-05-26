//
//  ViewController.m
//  DBS India
//
//  Created by Chandrachud on 9/7/16.
//  Copyright © 2016 Chandrachud. All rights reserved.
//

#import "ViewController.h"
#import "HMSegmentedControl.h"
#import "SignUpView.h"
#import "LoginView.h"
#import "DashBoardController.h"
#import "AppDelegate.h"

@interface ViewController ()<UIScrollViewDelegate,LoginDelegate>
@property (nonatomic, strong)IBOutlet HMSegmentedControl *segmentedControl;
@property (nonatomic, strong)IBOutlet UIScrollView *scrollView;
@property(nonatomic, strong) DashBoardController *dashBoard;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addSegmentedControl];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addSegmentedControl
{
    CGFloat viewWidth = CGRectGetWidth(self.view.frame);
    // Tying up the segmented control to a scroll view
    self.segmentedControl.sectionTitles = @[@"SIGNIN", @"SIGNUP"];
    
    self.segmentedControl.selectedSegmentIndex = 0;
//    self.segmentedControl.backgroundColor = [UIColor clearColor];
    self.segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    self.segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor redColor]};
    self.segmentedControl.selectionIndicatorColor = [UIColor blackColor];//[UIColor colorWithRed:147.0/255.0 green:19.0/255.0 blue:17.0/255.0 alpha:1];
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.selectionIndicatorHeight = 4.0;
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(viewWidth * index, 0, viewWidth, 200) animated:YES];
    }];
    
    [self.view addSubview:self.segmentedControl];
    
    self.scrollView.backgroundColor = [UIColor clearColor]; //[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(viewWidth * 2, 200);
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:self options:nil];
    LoginView *lgnView = nibViews.firstObject;
    lgnView.delegate = self;
    lgnView.backgroundColor = [UIColor clearColor];
    lgnView.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    UIColor *color = [UIColor darkGrayColor];
    lgnView.userName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: color}];
    lgnView.password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];

    [self.scrollView addSubview:lgnView];

    NSArray* nibViews1 = [[NSBundle mainBundle] loadNibNamed:@"SignUpView" owner:self options:nil];
    SignUpView *sgnUpView = nibViews1.firstObject;
    sgnUpView.backgroundColor = [UIColor clearColor];
    sgnUpView.frame = CGRectMake(viewWidth, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    [self.scrollView addSubview:sgnUpView];
}

- (void)setApperanceForLabel:(UILabel *)label {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    label.backgroundColor = color;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:21.0f];
    label.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}

#pragma mark - 
#pragma mark - LoginDelegate Methods

-(void)didLogin:(NSString *)userName password:(NSString *)password
{
//    [((AppDelegate *)[UIApplication sharedApplication].delegate) showTheHomeScreenWithAnimationFlag:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didForgetPassword
{
    
}

@end
