//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by an on 15/12/30.
//  Copyright (c) 2015年 ancool. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@implementation BNRItemsViewController

-(instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        for (int i = 0; i < 5; i++) {
            [[BNRItemStore sharedStore] createItem];
        }
    }
    return self;
}

-(instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

@end
