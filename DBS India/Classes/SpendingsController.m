//
//  SpendingsController.m
//  DBS India
//
//  Created by Chandrachud on 9/26/16.
//  Copyright © 2016 Chandrachud. All rights reserved.
//

#import "SpendingsController.h"
#import "Header.h"
#import "AddBudgetController.h"

@interface SpendingsController ()

@property(nonatomic, strong) AddBudgetController *budgetCont;

- (IBAction)addBudget:(id)sender;

@end

@implementation SpendingsController

- (void)viewDidLoad {
    [super viewDidLoad];
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

-(void)addBarButtonItems
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"header-bg"]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    
    UILabel* lbNavTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,40,320,40)];
    lbNavTitle.textAlignment = NSTextAlignmentLeft;
    lbNavTitle.textColor = FONT_PURPLE
    lbNavTitle.text = NSLocalizedString(@" Spendings",@"");
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addBudget:(id)sender
{
    _budgetCont = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AddBudgetController"];
    [self.navigationController pushViewController:_budgetCont animated:YES];
}
@end
