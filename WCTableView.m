//
//  WCTableView.m
//  WCTableView
//
//  Created by Wenwen on 2014-08-21.
//  Copyright (c) 2014 com.wenwenchu. All rights reserved.
//

#import "WCTableView.h"

@implementation WCTableView
@synthesize WCTableViewDataSource,WCTableViewDelegate;


-(id) initWithFrame:(CGRect)frame expandOnlyOneCell:(BOOL)_expandOnlyOneCell enableAutoScroll:(BOOL)_enableAutoScroll
{
    self =[super initWithFrame:frame];
    if(self)
    {
        expandOnlyOneCell = _expandOnlyOneCell;
        if(expandOnlyOneCell)
        {
            expandedIndexPaths = [[NSMutableArray alloc] init];
        }
        enableAutoScroll = _enableAutoScroll;
        self.delegate = self;
        self.dataSource = self;
        
    }
    return self;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [WCTableViewDataSource tableView:tableView numberOfRowsInSection:section];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [WCTableViewDataSource numberOfSectionsInTableView:tableView];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if([WCTableViewDataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)])
        return  [WCTableViewDataSource tableView:tableView titleForHeaderInSection:section];
    return nil;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if([WCTableViewDataSource respondsToSelector:@selector(tableView:titleForFooterInSection:)])
        return [WCTableViewDataSource tableView:tableView titleForFooterInSection:section];
    return nil;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([WCTableViewDataSource respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)])
        return [WCTableViewDataSource tableView:tableView canEditRowAtIndexPath:indexPath];
    return NO;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([WCTableViewDataSource respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)]) {
        return [WCTableViewDataSource tableView:tableView canMoveRowAtIndexPath:indexPath];
    }
    return NO;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if([WCTableViewDataSource respondsToSelector:@selector(sectionIndexTitlesForTableView:)])
        {
        return [WCTableViewDataSource sectionIndexTitlesForTableView:tableView];
        }
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if([WCTableViewDataSource respondsToSelector:@selector(tableView:sectionForSectionIndexTitle:atIndex:)])
        return [WCTableViewDataSource tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
    return 0;
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([WCTableViewDataSource respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)])
        return [WCTableViewDataSource tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
}

-(void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    if([WCTableViewDataSource respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)])
        return [WCTableViewDataSource tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    if(expandOnlyOneCell)
    {
        if(actionToTake == 0)
        {
            if(selectedIndexPath)
            {
                if (selectedIndexPath.row == indexPath.row && selectedIndexPath.section == indexPath.section) {
                    cell = [WCTableViewDataSource tableView:tableView cellForRowAtIndexPath:indexPath isExpanded: YES];
                    return cell;
                }
            }
            cell = [WCTableViewDataSource tableView:tableView cellForRowAtIndexPath:indexPath isExpanded: NO];
            return cell;
        }
        cell = [WCTableViewDataSource tableView:tableView cellForRowAtIndexPath:indexPath isExpanded: NO];
        
        if(actionToTake == -1)
        {
            [WCTableViewDataSource tableView:tableView collapseCell:cell withIndexPath:indexPath];
            actionToTake = 0;
        }
        
        else
        {
            [WCTableViewDataSource tableView:tableView expandCell:cell withIndexPath:indexPath];
            actionToTake = 0;
        }
    }
    else
    {
        if(actionToTake == 0)
        {
            BOOL alreadyExpanded = NO;
            NSIndexPath * correspondingIndexPath;
            for (NSIndexPath * anIndexPath in expandedIndexPaths) {
                if(anIndexPath.row == indexPath.row && anIndexPath.section == indexPath.section)
            }
            
            if (alreadyExpanded)
               cell = [WCTableViewDataSource tableView:tableView cellForRowAtIndexPath:indexPath isExpanded: NO];
            else
               cell = [WCTableViewDataSource tableView:tableView cellForRowAtIndexPath:indexPath isExpanded: NO];
            return cell;
        }
        
        cell = [WCTableViewDataSource tableView:tableView cellForRowAtIndexPath:indexPath isExpanded: NO];
        
        if(actionToTake == -1)
        {
            [WCTableViewDataSource tableView:tableView collapseCell:cell withIndexPath:indexPath];
            actionToTake = 0;
        }
        
        else
        {
            [WCTableViewDataSource tableView:tableView expandCell:cell withIndexPath:indexPath];
            actionToTake = 0;
        }
    }
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if(expandOnlyOneCell)
   {
       if (selectedIndexPath)
       {
           if(selectedIndexPath.row == indexPath.row && selectedIndexPath.section == indexPath.section)
               return [WCTableViewDelegate tableView:tableView heightForRowAtIndexPath:indexPath isExpanded:YES];
       }
       return [WCTableViewDelegate tableView:tableView heightForRowAtIndexPath:indexPath isExpanded:NO];
   }
   else
   {
       BOOL alreadyExpanded = NO;
       NSIndexPath * correspondingIndexPath;
       for(NSIndexPath * anIndexPath in expandedIndexPaths)
       {
           if(anIndexPath.row == indexPath.row && anIndexPath.section == indexPath.section)
           {
               alreadyExpanded = YES;
               correspondingIndexPath = anIndexPath;
           }
       }
       if(alreadyExpanded)
           return [WCTableViewDelegate tableView:tableView heightForRowAtIndexPath:indexPath isExpanded:YES];
       else
           return [WCTableViewDelegate tableView:tableView heightForRowAtIndexPath:indexPath isExpanded:NO];
   }
}


-(NSIndexPath *) tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(expandOnlyOneCell)
    {
        if(selectedIndexPath)
            if(selectedIndexPath.row != -1 && selectedIndexPath.row != -2)
            {
                BOOL dontExpandNewCell = NO;
                if(selectedIndexPath.row == indexPath.row && selectedIndexPath.section == indexPath.section)
                    dontExpandNewCell = YES;
            }
        NSIndexPath* tmp = [NSIndexPath indexPathForRow:selectedIndexPath.row inSection:selectedIndexPath.section];
        selectedIndexPath = [NSIndexPath indexPathForRow:-1 inSection:0];
        actionToTake = -1;
        [tableView beginUpdates];
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:tmp] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView endUpdates];
        if(enableAutoScroll)
            [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    else{
        BOOL alreadyExpandded = NO;
        NSIndexPath* correspondingIndexPath;
        for(NSIndexPath * anIndexPath in expandedIndexPaths)
        {
            if(anIndexPath.row == indexPath.row && anIndexPath.section == indexPath.section)
            {
                alreadyExpandded = YES;
                correspondingIndexPath = anIndexPath;
            }
        }
        if(alreadyExpandded)
        {
            actionToTake = -1;
            [expandedIndexPaths removeObject:correspondingIndexPath];
            [tableView beginUpdates];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView endUpdates];
        }
        else{
            actionToTake = 1;
            [expandedIndexPaths addObject:indexPath];
            [tableView beginUpdates];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView endUpdates];
            if(enableAutoScroll)
                [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        }
    }
}

@end
