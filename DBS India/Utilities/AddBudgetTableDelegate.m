//
//  AddBudgetTableDelegate.m
//  DBS India
//
//  Created by Chandrachud on 9/27/16.
//  Copyright © 2016 Chandrachud. All rights reserved.
//

#import "AddBudgetTableDelegate.h"

@interface SLAddBudgetHeaderCell : UITableViewCell <UIExpandingTableViewCell>

@property (nonatomic, assign, getter = isLoading) BOOL loading;
@property (nonatomic, readonly) UIExpansionStyle expansionStyle;
- (void)setExpansionStyle:(UIExpansionStyle)expansionStyle animated:(BOOL)animated;

@end

@implementation SLAddBudgetHeaderCell

- (NSString *)accessibilityLabel
{
    return self.textLabel.text;
}

- (void)setLoading:(BOOL)loading
{
    if (loading != _loading) {
        _loading = loading;
        [self _updateDetailTextLabel];
    }
}

- (void)setExpansionStyle:(UIExpansionStyle)expansionStyle animated:(BOOL)animated
{
    if (expansionStyle != _expansionStyle) {
        _expansionStyle = expansionStyle;
        [self _updateDetailTextLabel];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _updateDetailTextLabel];
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)_updateDetailTextLabel
{
    if (self.isLoading) {
        self.detailTextLabel.text = @"Loading data";
    } else {
        switch (self.expansionStyle) {
            case UIExpansionStyleExpanded:
                self.detailTextLabel.text = @"Click to collapse";
                break;
            case UIExpansionStyleCollapsed:
                self.detailTextLabel.text = @"Click to expand";
                break;
        }
    }
}

@end

@interface AddBudgetTableDelegate ()

@property (nonatomic, strong) NSArray *firstSectionStrings;
@property (nonatomic, strong) NSArray *secondSectionStrings;
@property (nonatomic, strong) NSArray *thirdSectionStrings;

@property (nonatomic, strong) NSMutableArray *sectionsArray;
@property (nonatomic, strong) NSArray *sectionsSubtitleArray;
@property (nonatomic, strong) NSArray *imagesArray;

@property (nonatomic, strong) NSMutableIndexSet *expandableSections;
@property(nonatomic, strong) NSIndexPath *lastIndexPath;

@property(nonatomic, strong) AddBudgetStep2Controller *budgetStep2Controller;
@end

@implementation AddBudgetTableDelegate

-(instancetype)init
{
    _firstSectionStrings = @[ @"Section 0 Row 0", @"Section 0 Row 1", @"Section 0 Row 2", @"Section 0 Row 3" ];
    _secondSectionStrings = @[ @"Section 1 Row 0", @"Section 1 Row 1", @"Section 1 Row 2", @"Section 1 Row 3", @"Section 1 Row 4" ];
    
    _sectionsArray = @[ _firstSectionStrings, _secondSectionStrings ].mutableCopy;
    _expandableSections = [NSMutableIndexSet indexSet];
    return self;
}

- (BOOL)tableView:(SLExpandableTableView *)tableView canExpandSection:(NSInteger)section
{
    return YES;
}

- (BOOL)tableView:(SLExpandableTableView *)tableView needsToDownloadDataForExpandableSection:(NSInteger)section
{
    return ![self.expandableSections containsIndex:section];
}

- (UITableViewCell<UIExpandingTableViewCell> *)tableView:(SLExpandableTableView *)tableView expandingCellForSection:(NSIndexPath*)section
{
    static NSString *CellIdentifier = @"addBudgetHeaderCell";
    [tableView registerNib:[UINib nibWithNibName:@"SLAddBudgetHeaderCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];

    SLAddBudgetHeaderCell *cell = (SLAddBudgetHeaderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:section];
    
    return cell;
}

#pragma mark - SLExpandableTableViewDelegate

- (void)tableView:(SLExpandableTableView *)tableView downloadDataForExpandableSection:(NSInteger)section
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.expandableSections addIndex:section];
        [tableView expandSection:section animated:YES];
    });
}

- (void)tableView:(SLExpandableTableView *)tableView didCollapseSection:(NSUInteger)section animated:(BOOL)animated
{
    [self.expandableSections removeIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *dataArray = self.sectionsArray[section];
    return dataArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSArray *dataArray = self.sectionsArray[indexPath.section];
    cell.textLabel.text = dataArray[indexPath.row - 1];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    
    [cell setIndentationLevel:10];
    [cell setIndentationWidth:5];

    
    if([self.lastIndexPath isEqual:indexPath])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        //        [self.sectionsArray removeObjectAtIndex:indexPath.section];
        //        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.budgetStep2Controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AddBudgetStep2Controller"];
    [self.parentController.navigationController pushViewController:_budgetStep2Controller animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:self.lastIndexPath];
    
    selectedCell.accessoryType = UITableViewCellAccessoryNone;
    cell.accessoryType = UITableViewCellAccessoryCheckmark;


    if(self.lastIndexPath)
    {
        UITableViewCell* uncheckCell = [tableView
                                        cellForRowAtIndexPath:self.lastIndexPath];
        uncheckCell.accessoryType = UITableViewCellAccessoryNone;
    }
    if([self.lastIndexPath isEqual:indexPath])
    {
        self.lastIndexPath = nil;
    }
    else
    {
        UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.lastIndexPath = indexPath;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
@end
