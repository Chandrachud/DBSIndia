//
//  AddFundsController.m
//  DBS India
//
//  Created by Chandrachud on 9/23/16.
//  Copyright © 2016 Chandrachud. All rights reserved.
//

#import "AddFundsController.h"
#import "Header.h"
#import "AppDelegate.h"
#import "SLExpandableTableView.h"
#import "ExpandableTableDelegate.h"

static AddFundsController *sharedInstance;

@interface AddFundsController ()
@property (weak, nonatomic) IBOutlet SLExpandableTableView *expandableTable;
@property(nonatomic, strong) ExpandableTableDelegate *expandableTableDelegate;
@end

@implementation AddFundsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpExpandableTableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addBarButtonItems];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setUpExpandableTableView
{
    _expandableTableDelegate = [[ExpandableTableDelegate alloc]init];
    self.expandableTable.delegate = _expandableTableDelegate;
    self.expandableTable.dataSource = _expandableTableDelegate;
    
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
    [leftBtn addTarget:self action:@selector(presentLeftController) forControlEvents:UIControlEventTouchUpInside];
    
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

+ (instancetype) controller{
    
    AddFundsController *controller = [AddFundsController sharedInstance];
    return  controller;
}
+ (AddFundsController *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[AddFundsController alloc] initWithNibName:@"DashBoardController" bundle:nil];
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
        return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([AddFundsController class])];
        
    }
    return self;
}

@end
