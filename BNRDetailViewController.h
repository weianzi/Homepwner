//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by ancool on 16/1/6.
//  Copyright © 2016年 ancool. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface BNRDetailViewController : UIViewController

- (instancetype)initForNewItem:(BOOL)isNew;

@property (nonatomic, strong) BNRItem *item;

@end
