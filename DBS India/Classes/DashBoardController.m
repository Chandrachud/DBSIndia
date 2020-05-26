//
//  DashBoardController.m
//  DBS India
//
//  Created by Chandrachud on 9/8/16.
//  Copyright © 2016 Chandrachud. All rights reserved.
//

#import "DashBoardController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "DashBoardTableDelegate.h"
#import "ViewController.h"

static DashBoardController *sharedInstance;

@interface DashBoardController ()

{
    BOOL isLoggedIn;
}

@property(nonatomic, weak) IBOutlet UITableView *tblView;
@property(nonatomic, strong) DashBoardTableDelegate *tableDelegate;
@end

@implementation DashBoardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBarButtonItems];
    [self setUpTableView];
    [self configuretabBar];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!isLoggedIn) {
     [self presentLoginView];
        isLoggedIn = YES;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)presentLoginView
{
    ViewController *viewCont = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
    [self presentViewController:viewCont animated:YES completion:nil];
}

-(void)setUpTableView
{
    _tableDelegate = [[DashBoardTableDelegate alloc]init];
    self.tblView.delegate = _tableDelegate;
    self.tblView.dataSource = _tableDelegate;
}

-(void)configuretabBar
{
    UITabBarItem *item = [self.tabBarController.tabBar.items objectAtIndex:2];
    item.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    

    [[self.tabBarController.tabBar.items objectAtIndex:0] setTitle:@"ADD FUNDS"];
    
    [[self.tabBarController.tabBar.items objectAtIndex:1] setTitle:@"SPENDINGS"];
    
    [[self.tabBarController.tabBar.items objectAtIndex:2] setTitle:@""];
    
    [[self.tabBarController.tabBar.items objectAtIndex:3] setTitle:@"YOUR PAYEES"];
    
    [[self.tabBarController.tabBar.items objectAtIndex:4] setTitle:@"RECHARGE"];
    
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
//                                             forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }
//                                             forState:UIControlStateSelected];
}

-(void)addBarButtonItems
{
    self.navigationController.navigationBar.tintColor = FONT_PURPLE
    UIView *leftBgView = [[UIView alloc]initWithFrame:CGRectMake(0,-20, self.view.frame.size.width/2.0, 64)];
    leftBgView.backgroundColor = YELLOW_BG;
    [self.navigationController.navigationBar addSubview:leftBgView];
    
    UIView *rightBgView = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2.0,-20, self.view.frame.size.width/2.0, 64)];
    rightBgView.backgroundColor = LIGHTYELLOW_BG;
    [self.navigationController.navigationBar addSubview:rightBgView];

    
    UILabel* lbNavTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,40,320,40)];
    lbNavTitle.textAlignment = NSTextAlignmentLeft;
    lbNavTitle.textColor = FONT_PURPLE
    lbNavTitle.text = NSLocalizedString(@" Welcome, Patil C",@"");
    self.navigationItem.titleView = lbNavTitle;

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
    [btn setImage:[UIImage imageNamed:@"user.png"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barbutton = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barbutton;
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
    [leftBtn setImage:[UIImage imageNamed:@"icon-menu"] forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(presentLeftController) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarbutton = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarbutton;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:RED_Color}];
    
    [self.navigationController.navigationBar  setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.hidesBackButton = YES;
}

#pragma mark - Left Menu Methods

- (void) presentLeftController{
    
    [((AppDelegate *)[UIApplication sharedApplication].delegate) showTheHomeScreenWithAnimationFlag:YES];
    
    //show left menu with animation
    ITRAirSideMenu *itrSideMenu = ((AppDelegate *)[UIApplication sharedApplication].delegate).itrAirSideMenu;
    [itrSideMenu presentLeftMenuViewController];
}

-(void)logout
{
    [((AppDelegate *)[UIApplication sharedApplication].delegate) showTheLoginScreen];
}

+ (instancetype) controller{
    
    DashBoardController *controller = [DashBoardController sharedInstance];
    return  controller;
}
+ (DashBoardController *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[DashBoardController alloc] initWithNibName:@"DashBoardController" bundle:nil];
    });
    return sharedInstance;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(sharedInstance) {
        // avoid creating more than one instance
        [NSException raise:@"bug" format:@"tried to create more than one instance"];
    }
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([DashBoardController class])];
        
    }
    return self;
}

@end
