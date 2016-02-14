//
//  BNRItemCell.h
//  Homepwner
//
//  Created by ancool on 16/2/14.
//  Copyright © 2016年 ancool. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface BNRItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailView;

@end
