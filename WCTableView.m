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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WCTableViewDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
}

@end
