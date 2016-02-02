//
//  BNRImageStore.m
//  Homepwner
//
//  Created by an on 16/1/9.
//  Copyright © 2016 ancool. All rights reserved.
//

#import "BNRImageStore.h"

@interface BNRImageStore ()

@property (nonatomic, strong) NSMutableDictionary *dictionary;
- (NSString *)imagePathForKey:(NSString *)key;

@end

@implementation BNRImageStore

+ (instancetype)sharedStore
{
    static BNRImageStore *sharedStore = nil;
//    if(!sharedStore){
//        sharedStore = [[self alloc] initPrivate];
//    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStore = [[self alloc] initPrivate];
    });
    return sharedStore;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"singleton" reason:@"use +[BNRImageStore sharedStore]" userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _dictionary = [[NSMutableDictionary alloc] init];
        //内存过低警告
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(clearCache:)
                   name:UIApplicationDidReceiveMemoryWarningNotification
                 object:nil];
    }
    
    return self;
}

- (void)clearCache:(NSNotification *)note
{
    NSLog(@"flushing %lu images out of the cache", (unsigned long)[self.dictionary count]);
    [self.dictionary removeAllObjects];
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key
{
    //[self.dictionary setObject:image forKey:key];
    self.dictionary[key] = image;
    //获取保存图片的全路径
    NSString *imagePath = [self imagePathForKey:key];
    //从图片提取JPG格式的数据
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    //将JPG数据写入文件
    [data writeToFile:imagePath atomically:YES];
}

- (id)imageForKey:(NSString *)key
{
    //return [self.dictionary objectForKey:key];
    //return self.dictionary[key];
    UIImage *result = self.dictionary[key];
    if (!result) {
        NSString *imagePath = [self imagePathForKey:key];
        //imagewithContentsOfFile:可以从指定的文件载入图片
        result = [UIImage imageWithContentsOfFile:imagePath];
        if (result) {
            //放入缓存
            self.dictionary[key] =result;
        } else {
            NSLog(@"Error: unable to find %@", [self imagePathForKey:key]);
        }
    }
    return result;
}

- (void)deleteImageForKey:(NSString *)key
{
    if (!key) {
        return;
    }
    [self.dictionary removeObjectForKey:key];
    NSString *imagePath = [self imagePathForKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
}

- (NSString *)imagePathForKey:(NSString *)key
{
    NSArray *documentDirecties = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory,
                                                                     NSUserDomainMask,
                                                                     YES);
    NSString *documentDirectory = [documentDirecties firstObject];
    return [documentDirectory stringByAppendingPathComponent:key];
}

@end










