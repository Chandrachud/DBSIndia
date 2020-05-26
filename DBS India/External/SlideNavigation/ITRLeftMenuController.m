//
//  LeftMenuController.m
//  ITRAirSideMenu
//
//  Created by kirthi on 12/08/15.
//  Copyright (c) 2015 kirthi. All rights reserved.
//

#import "ITRLeftMenuController.h"
#import "AppDelegate.h"
#import "DashBoardController.h"

@interface ITRLeftMenuController ()
{
    NSIndexPath *selectedIndexPath;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic, strong)NSArray *titles;

@property(nonatomic,retain) UIViewController *selectedController;

@end

@implementation ITRLeftMenuController


+ (instancetype)controller {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ITRLeftMenuController class])];
}

#pragma view lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor darkGrayColor];
    _titles = @[@"Home", @"Add New Expense", @"Expense Timeline", @"Reports", @"Profile", @"Logout"];
    
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ITRAirSideMenu *itrSideMenu = ((AppDelegate *)[UIApplication sharedApplication].delegate).itrAirSideMenu;
    selectedIndexPath = indexPath;
    //update content view controller with setContentViewController
    [itrSideMenu hideMenuViewController];
    
    if (indexPath.row == 4)
    {
        //_selectedController = [MyProfileController controller];
    }
    else
    {
        _selectedController = [DashBoardController controller];
    }
}


#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:25];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    cell.textLabel.text = _titles[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark ITRAirSideMenu Delegate

- (void)sideMenu:(ITRAirSideMenu *)sideMenu didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer {
    
}

- (void)sideMenu:(ITRAirSideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController {
    
}

- (void)sideMenu:(ITRAirSideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController {
    
}

- (void)sideMenu:(ITRAirSideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController {
    
}

- (void)sideMenu:(ITRAirSideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController{
    
    if (_selectedController == nil) {
        _selectedController = [DashBoardController controller];
    }
    [sideMenu setContentViewController:[[UINavigationController alloc] initWithRootViewController:_selectedController]];
}


@end
