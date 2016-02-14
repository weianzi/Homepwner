//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by an on 15/12/30.
//  Copyright (c) 2016 ancool. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemsViewController ()

@property (nonatomic, strong)IBOutlet UIView *headerView;

@end

@implementation BNRItemsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] init];
  
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] initForNewItem:NO];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *selectedItem = items[indexPath.row];
    
    detailViewController.item = selectedItem;
    
    [self.navigationController pushViewController:detailViewController
                                         animated:YES];
}

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
//        for (int i = 0; i < 5; i++) {
//            [[BNRItemStore sharedStore] createItem];
//        }
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
        
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
    initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                         target:self
                         action:@selector(addNewItem:)];
        
        navItem.rightBarButtonItem = bbi;
        navItem.leftBarButtonItem = self.editButtonItem;
        
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
    //return [self init];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore sharedStore] allItems] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];

    //获取BNRItemCell对象，返回可能是现有的对象，也可能是新创建的对象
    BNRItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BNRItemCell"
                                                        forIndexPath:indexPath];
    
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    //cell.textLabel.text = [item description];
    //根据BNRItem对象设置BNRItemCell对象
    cell.nameLabel.text = item.itemName;
    cell.serialNumberLabel.text = item.serialNumber;
    cell.valueLabel.text = [NSString stringWithFormat:@"$%d", item.valueInDollars];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        [[BNRItemStore sharedStore] removeItem:item];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.tableView registerClass:[UITableViewCell class]
//           forCellReuseIdentifier:@"UITableViewCell"];
    
    //创建UINib对象，该对象代表包含了BNRItemCell的NIB文件
    UINib *nib = [UINib nibWithNibName:@"BNRItemCell" bundle:nil];
    //通过UINib对象注册相应的NIB对象
    [self.tableView registerNib:nib
         forCellReuseIdentifier:@"BNRItemCell"];
    
    //UIView *header = self.headerView;
    //[self.tableView setTableHeaderView:header];
}

//-(UIView *)headerView
//{
//    if (!_headerView) {
//        [[NSBundle mainBundle] loadNibNamed:@"HeaderView"
//                                     owner:self
//                                   options:nil];
//    }
//    return _headerView;
//}

- (IBAction)addNewItem:(id)sender
{
    //NSInteger lastRow = [self.tableView numberOfRowsInSection:0];
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    //NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
    
    //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow
    //                                            inSection:0];
    //[self.tableView insertRowsAtIndexPaths:@[indexPath]
    //                      withRowAnimation:UITableViewRowAnimationTop];
    
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] initForNewItem:YES];
    detailViewController.item = newItem;
    
    detailViewController.dismissBlock = ^{
        [self.tableView reloadData];
    };
    
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:detailViewController];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [self presentViewController:navController
                       animated:YES
                     completion:nil];
    
}

//-(IBAction)toggleEditingMode:(id)sender
//{
//    if (self.isEditing) {
//        [sender setTitle:@"Edit"
//                forState:UIControlStateNormal];
//        [self setEditing:NO
//                animated:YES];
//    } else {
//        [sender setTitle:@"Done"
//                forState:UIControlStateNormal];
//        [self setEditing:YES
//                animated:YES];
//    }
//}

 - (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row
                                        toIndex:destinationIndexPath.row];    
}

@end
