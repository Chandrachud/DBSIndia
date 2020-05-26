//
//  AddBudgetController.m
//  DBS India
//
//  Created by Chandrachud on 9/26/16.
//  Copyright © 2016 Chandrachud. All rights reserved.
//

#import "AddBudgetController.h"
#import "Header.h"
#import "AddbudgetTableDelegate.h"

@interface AddBudgetController ()

@property(nonatomic, strong) AddBudgetTableDelegate *tblDelegate;
@property (weak, nonatomic) IBOutlet SLExpandableTableView *expandableTable;
@end

@implementation AddBudgetController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpExpandableTableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addBarButtonItems];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setUpExpandableTableView
{
    _tblDelegate = [[AddBudgetTableDelegate alloc]init];
    self.expandableTable.delegate = _tblDelegate;
    self.expandableTable.dataSource = _tblDelegate;
    _tblDelegate.parentController = self;
}

-(void)addBarButtonItems
{
    UILabel* lbNavTitle = [[UILabel alloc] initWithFrame:CGRectMake(0,40,320,40)];
    lbNavTitle.textAlignment = NSTextAlignmentLeft;
    lbNavTitle.textColor = FONT_PURPLE
    lbNavTitle.text = NSLocalizedString(@" Add a Budget",@"");
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
        [leftBtn addTarget:self action:@selector(pushBack) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBarbutton = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftBarbutton;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:RED_Color}];
    
    [self.navigationController.navigationBar  setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.hidesBackButton = YES;
}

-(void)pushBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
