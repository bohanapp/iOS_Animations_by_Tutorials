//
//  ViewController.m
//  PackingList
//
//  Created by dudw on 16/5/29.
//  Copyright © 2016年 dudw. All rights reserved.
//

#import "ViewController.h"
#import "HorizontalItemList.h"

static NSString  *reuseid = @"Cell";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonMenu;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuHeightConstraint;

@property(nonatomic,strong) NSArray *itemTitles;
@property(nonatomic,strong) NSArray *items;
@property(nonatomic,assign) BOOL isMenuOpen;
@property(nonatomic,strong) HorizontalItemList *slider;
@end

@implementation ViewController

- (NSArray *)itemTitles{
    return @[@"Icecream money", @"Great weather", @"Beach ball", @"Swim suit for him", @"Swim suit for her", @"Beach games", @"Ironing board", @"Cocktail mood", @"Sunglasses", @"Flip flops"];
}

- (NSArray *)items{
    return @[@5,@6,@7];
}
    
- (IBAction)actionToggleMenu:(UIButton *)sender {
    
    for (NSLayoutConstraint *layoutContrain in self.titleLabel.superview.constraints) {
        NSLog(@"->%@", layoutContrain.description);
    }
    
    self.isMenuOpen = !self.isMenuOpen;
    self.menuHeightConstraint.constant = self.isMenuOpen?200.0:60.0;
    self.titleLabel.text = self.isMenuOpen?@"Select Item" : @"Packing List";
    [UIView animateWithDuration:1.0
                          delay:0.0
         usingSpringWithDamping:0.4
          initialSpringVelocity:10.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self.view layoutIfNeeded];
                         CGFloat angle = self.isMenuOpen ? M_PI/4 :0.0;
                         self.buttonMenu.transform = CGAffineTransformMakeRotation(angle);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview.rowHeight = 54.0;
}

#pragma mark - UITableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseid forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = self.itemTitles[[self.items[indexPath.row] intValue]];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"summericons_100px_0\%@",self.items[indexPath.row]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self showItem:indexPath.row];
}

- (void)showItem:(NSInteger)index{
    NSLog(@"%@",self.items[index]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
