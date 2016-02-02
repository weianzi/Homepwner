//
//  BNRItemStore.m
//  Homepwner
//
//  Created by an on 16/1/2.
//  Copyright (c) 2016年 ancool. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRItemStore ()

@property (nonatomic) NSMutableArray *privateItems;
- (NSString *)imagePathForKey: (NSString *)key;

@end

@implementation BNRItemStore


+ (instancetype)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    if (!sharedStore) {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}


- (instancetype)init
{
    @throw [NSException exceptionWithName:@"singleton"
                                   reason:@"Use +[BNRItemStore sharedStore]"
                                 userInfo:nil];
    return nil;
}


- (instancetype)initPrivate
{
    self = [super init];
    //NSLog(@"%@", self);
    if (self) {
        //_privateItems = [[NSMutableArray alloc] init];
        NSString *path = [self itemArchivePath];
        //NSLog(@"%@", path);
        _privateItems = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
         //NSLog(@"%@", _privateItems);
        if (!_privateItems) {
            _privateItems = [[NSMutableArray alloc] init];
        }
    }
    return self;
}


- (NSArray *)allItems
{
    return self.privateItems;
}


- (BNRItem *)createItem
{
    //BNRItem *item = [BNRItem randomItem];
    BNRItem *item = [[BNRItem alloc] init];
    [self.privateItems addObject:item];
    return item;
}

- (void)removeItem:(BNRItem *)item
{
    NSString *key = item.itemKey;
    [[BNRImageStore sharedStore] deleteImageForKey:key];
    
    [self.privateItems removeObjectIdenticalTo:item];
}

- (void)moveItemAtIndex:(NSUInteger)fromIndex
                toIndex:(NSUInteger)toIndex
{
    if (fromIndex == toIndex) {
        return;
    }
    
    BNRItem *item = self.privateItems[fromIndex];
    [self.privateItems insertObject:item atIndex:toIndex];

}

- (NSString *)itemArchivePath
{
    NSArray *documentDirectiries = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectiry = [documentDirectiries firstObject];
    //返回文件名为items.archive文件
    return [documentDirectiry stringByAppendingPathComponent:@"items.archive"];
}

- (BOOL)saveChanges
{
    NSString *path = [self itemArchivePath];
    //如果固化成功就返回YES
    return [NSKeyedArchiver archiveRootObject:self.privateItems toFile:path];
}

- (NSString *)imagePathForKey:(NSString *)key
{
    //NSSearchPathForDirectoriesInDomains得到沙盒中目录全路径
    //NSDocumentDirectory得到Document目录路径
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [documentDirectories firstObject];    
    return [documentDirectory stringByAppendingPathComponent:key];
}


@end





