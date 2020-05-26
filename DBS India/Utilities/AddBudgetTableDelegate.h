//
//  AddBudgetTableDelegate.h
//  DBS India
//
//  Created by Chandrachud on 9/27/16.
//  Copyright © 2016 Chandrachud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLExpandableTableView.h"
#import "AddBudgetStep2Controller.h"

@interface AddBudgetTableDelegate : NSObject<SLExpandableTableViewDatasource, SLExpandableTableViewDelegate>

@property(nonatomic, strong) UIViewController *parentController;
@end
