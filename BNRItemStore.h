//
//  BNRItemStore.h
//  Homepwner
//
//  Created by an on 16/1/2.
//  Copyright (c) 2016年 ancool. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BNRItem;

@interface BNRItemStore : NSObject

@property (nonatomic, readonly) NSArray *allItems;

+ (instancetype)sharedStore;
- (BNRItem *)createItem;

@end
