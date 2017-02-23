//
//  ViewController.h
//  AnimationDemo
//
//  Created by Yuan Gao on 8/23/16.
//  Copyright © 2016 www.ly.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton *loginButton;

@property (nonatomic, weak) IBOutlet UILabel *heading;

@property (nonatomic, weak) IBOutlet UITextField *username;
@property (nonatomic, weak) IBOutlet UITextField *password;

@property (nonatomic, weak) IBOutlet UIImageView *cloud1;
@property (nonatomic, weak) IBOutlet UIImageView *cloud2;
@property (nonatomic, weak) IBOutlet UIImageView *cloud3;
@property (nonatomic, weak) IBOutlet UIImageView *cloud4;


-(IBAction)login:(id)sender;

@end

