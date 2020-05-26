//
//  ExpandableTableDelegate.m
//  DBS India
//
//  Created by Chandrachud on 9/23/16.
//  Copyright © 2016 Chandrachud. All rights reserved.
//

#import "ExpandableTableDelegate.h"
#import "CardCell.h"

@interface SLExpandableTableViewControllerHeaderCell : UITableViewCell <UIExpandingTableViewCell>

@property (nonatomic, assign, getter = isLoading) BOOL loading;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (nonatomic, readonly) UIExpansionStyle expansionStyle;
- (void)setExpansionStyle:(UIExpansionStyle)expansionStyle animated:(BOOL)animated;

@end

@implementation SLExpandableTableViewControllerHeaderCell

- (NSString *)accessibilityLabel
{
    return self.textLabel.text;
}

- (void)setLoading:(BOOL)loading
{
    if (loading != _loading) {
        _loading = loading;
        //[self _updateDetailTextLabel];
    }
}

- (void)setExpansionStyle:(UIExpansionStyle)expansionStyle animated:(BOOL)animated
{
    if (expansionStyle != _expansionStyle) {
        _expansionStyle = expansionStyle;
       // [self _updateDetailTextLabel];
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        [self _updateDetailTextLabel];
//        self.backgroundColor = [UIColor yellowColor];
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

@interface ExpandableTableDelegate ()

@property (nonatomic, strong) NSArray *firstSectionStrings;
@property (nonatomic, strong) NSArray *secondSectionStrings;
@property (nonatomic, strong) NSArray *thirdSectionStrings;

@property (nonatomic, strong) NSMutableArray *sectionsArray;
@property (nonatomic, strong) NSArray *sectionsSubtitleArray;
@property (nonatomic, strong) NSArray *imagesArray;

@property (nonatomic, strong) NSMutableIndexSet *expandableSections;

@end

@implementation ExpandableTableDelegate

-(instancetype)init
{
    _firstSectionStrings = @[ @"Fund from other banks" ];
    _secondSectionStrings = @[ @"Fund with debit card" ];
    _thirdSectionStrings = @[ @"Fund with Net Banking" ];
    _sectionsSubtitleArray = @[@"To transfer any amount",@"Best for Small Amount",@"Good for Small Amount"];
    _imagesArray = @[@"bankTransfer",@"cards",@"netBanking"];
    _sectionsArray = @[ _firstSectionStrings, _secondSectionStrings,_thirdSectionStrings ].mutableCopy;
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
    static NSString *CellIdentifier = @"cardHeader";
    SLExpandableTableViewControllerHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {

        [tableView registerNib:[UINib nibWithNibName:@"SLExpandableTableViewControllerHeaderCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        cell = (SLExpandableTableViewControllerHeaderCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:section];

    }
    NSNumber *key = @(section.section);
    NSArray *arr = [self.sectionsArray objectAtIndex:[key integerValue]];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@", [arr objectAtIndex:0]];
    cell.subTitleLabel.text  = [NSString stringWithFormat:@"%@", [self.sectionsSubtitleArray objectAtIndex:[key integerValue]]];
    cell.image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[self.imagesArray objectAtIndex:[key integerValue]]]];
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
    if (indexPath.row == 1 || indexPath.row == 3) {
        return 240;
    }
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
    NSString *cardCellIdentifier = @"cardCell";
    [tableView registerNib:[UINib nibWithNibName:@"CardCell" bundle:nil] forCellReuseIdentifier:cardCellIdentifier];
    CardCell *cardCell = (CardCell *)[tableView dequeueReusableCellWithIdentifier:cardCellIdentifier forIndexPath:indexPath];
    return cardCell;
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
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
