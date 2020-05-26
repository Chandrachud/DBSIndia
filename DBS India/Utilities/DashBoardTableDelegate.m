//
//  DashBoardTableDelegate.m
//  DBS India
//
//  Created by Chandrachud on 9/12/16.
//  Copyright © 2016 Chandrachud. All rights reserved.
//

#import "DashBoardTableDelegate.h"
#import "PageControlCell.h"
#import "CardInfoCell.h"
#import "GetMoreCell.h"
#import "TransactionCell.h"

@implementation DashBoardTableDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSString *pageControlIdentifier = @"pageControlCell";
        [tableView registerNib:[UINib nibWithNibName:@"PageControlCell" bundle:nil] forCellReuseIdentifier:@"pageControlCell"];
        PageControlCell *pageControlCell = (PageControlCell *)[tableView dequeueReusableCellWithIdentifier:pageControlIdentifier forIndexPath:indexPath];
        return pageControlCell;
        
    }
    else if (indexPath.row ==1) {
        NSString *cardInfoIdentifier = @"cardInfoCell";
        [tableView registerNib:[UINib nibWithNibName:@"CardInfoCell" bundle:nil] forCellReuseIdentifier:cardInfoIdentifier];
        CardInfoCell *cardInfoCell = (CardInfoCell *)[tableView dequeueReusableCellWithIdentifier:cardInfoIdentifier forIndexPath:indexPath];
        return  cardInfoCell;
        
    }
    else if (indexPath.row ==2) {
        NSString *getMoreCellIdentifier = @"getMoreCell";
        [tableView registerNib:[UINib nibWithNibName:@"GetMoreCell" bundle:nil] forCellReuseIdentifier:getMoreCellIdentifier];
        GetMoreCell *getMMoreCell = (GetMoreCell *)[tableView dequeueReusableCellWithIdentifier:getMoreCellIdentifier forIndexPath:indexPath];
        return  getMMoreCell;
    }
    else
    {
        NSString *transactionCellIdentifier = @"transactionCell";
        [tableView registerNib:[UINib nibWithNibName:@"TransactionCell" bundle:nil] forCellReuseIdentifier:transactionCellIdentifier];
        TransactionCell *transactionCell = (TransactionCell *)[tableView dequeueReusableCellWithIdentifier:transactionCellIdentifier forIndexPath:indexPath];
        return  transactionCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenHeight = screenRect.size.height;
    
    if (indexPath.row == 0) {
        return screenHeight*0.24;
    }
    else if (indexPath.row == 1) {
        return screenHeight*0.35;
    }
    else if(indexPath.row == 2){
        return screenHeight*0.25;
    }
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
@end
