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

@property (nonatomic, strong, readonly) NSArray *allItems;

+ (instancetype)sharedStore;

- (BNRItem *)createItem;

- (void)removeItem:(BNRItem *)item;

- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex;

- (BOOL)saveChanges;

@end
