//
//  BNRImageStore.h
//  Homepwner
//
//  Created by an on 16/1/9.
//  Copyright © 2016年 ancool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject

+ (instancetype)sharedStore;

- (void)setImage:(id)image forKey:(NSString *)key;
- (id)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
