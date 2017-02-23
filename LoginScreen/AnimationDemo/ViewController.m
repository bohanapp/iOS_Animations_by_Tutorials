//
//  ViewController.m
//  AnimationDemo
//
//  Created by Yuan Gao on 8/23/16.
//  Copyright © 2016 www.ly.com. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Category.h"

@interface ViewController ()
{
    UIActivityIndicatorView *spinner ;
    UIImageView *status;
    UILabel *label;
    NSArray *messages;
    CGPoint statusPosition;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    messages = @[@"Connecting ...", @"Authorizing ...", @"Sending credentials ...", @"Failed"];
    statusPosition = CGPointZero;
    self.loginButton.layer.cornerRadius = 8.0;
    self.loginButton.layer.masksToBounds = YES;
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.frame = CGRectMake(-20.0, 6.0, 20.0, 20.0);
    [spinner startAnimating];
    spinner.alpha = 0.0;
    [self.loginButton addSubview:spinner];
    
    status = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banner"]];
    status.hidden = YES;
    status.center = self.loginButton.center;
    [self.view addSubview:status];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, status.frame.size.width, status.frame.size.height)];
    label.font = [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    label.textColor = [UIColor colorWithRed:0.89 green:0.38 blue:0.0 alpha:1.0];
    label.textAlignment = NSTextAlignmentCenter;
    [status addSubview:label];
    
    statusPosition = status.center;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.heading.centerX -= self.view.bounds.size.width;
    self.username.centerX -= self.view.bounds.size.width;
    self.password.centerX -= self.view.bounds.size.width;
    
    //cloud
    self.cloud1.alpha = 0.0;
    self.cloud2.alpha = 0.0;
    self.cloud3.alpha = 0.0;
    self.cloud4.alpha = 0.0;
    
    self.loginButton.centerY += 30;
    self.loginButton.alpha = 0.0;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.5
                     animations:^{
        self.heading.centerX += self.view.bounds.size.width;
    }];
    
    [UIView animateWithDuration:0.5
                          delay:0.3
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.username.centerX += self.view.bounds.size.width;
                     }
                     completion:nil];
    
    [UIView animateWithDuration:0.5
                          delay:0.4
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.password.centerX += self.view.bounds.size.width;
                     }
                     completion:nil];
    
    [UIView animateWithDuration:0.5
                          delay:0.5
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.cloud1.alpha = 1.0;
                     }
                     completion:nil];
    
    [UIView animateWithDuration:0.5
                          delay:0.7
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.cloud2.alpha = 1.0;
                     }
                     completion:nil];
    
    [UIView animateWithDuration:0.5
                          delay:0.9
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.cloud3.alpha = 1.0;
                     }
                     completion:nil];
    
    [UIView animateWithDuration:0.5
                          delay:1.1
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.cloud4.alpha = 1.0;
                     }
                     completion:nil];
    
   
    [UIView animateWithDuration:0.5
                          delay:0.5
         usingSpringWithDamping:0.5
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.loginButton.centerY -= 30;
                         self.loginButton.alpha = 1.0;
                     }
                     completion:nil];
    
    [self animateCloud:_cloud1];
    [self animateCloud:_cloud2];
    [self animateCloud:_cloud3];
    [self animateCloud:_cloud4];
}

-(void) showMessage:(int) index
{
    label.text = messages[index];
    [UIView transitionWithView:status
                      duration:0.33
                       options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionTransitionCurlDown
                    animations:^{
                        status.hidden = NO;
                    }
                    completion:^(BOOL finished) {
                        double delayInSeconds = 2.0;
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            if (index < messages.count -1) {
                                [self removeMessage:index];
                            }
                            else{
                                //reset form
                                [self resetForm];
                            }
                        });
                        
                    }];
}

- (void)removeMessage:(int) index
{
    [UIView animateWithDuration:0.33
                          delay:0.0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         status.centerX += self.view.frame.size.width;
                     } completion:^(BOOL finished) {
                         status.hidden = YES;
                         status.center = statusPosition;
                         [self showMessage:index +1];
                     }];
}

- (void)animateCloud:(UIView *)cloud
{
    float cloudSpeed = 60.0/self.view.frame.size.width;
    NSTimeInterval timeInterval = (self.view.width - cloud.frame.origin.x)* cloudSpeed;
    [UIView animateWithDuration:timeInterval
                          delay:0.0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         CGRect rect = cloud.frame;
                         rect.origin.x = self.view.frame.size.width;
                         cloud.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = cloud.frame;
                         rect.origin.x = -cloud.frame.size.width;
                         cloud.frame = rect;
                         [self animateCloud:cloud];
                     }];
}

- (void)resetForm
{
   [UIView transitionWithView:status
                     duration:0.2
                      options:UIViewAnimationOptionTransitionCurlUp
                   animations:^{
                       status.center = statusPosition;
                       status.hidden = YES;
                   }
                   completion:nil];
    
    [UIView animateWithDuration:0.5
                          delay:0.2
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         spinner.frame = CGRectMake(-20.0, 6.0, 20.0, 20.0);
                         spinner.alpha = 0.0;
                         self.loginButton.backgroundColor = [UIColor colorWithRed:0.63 green:0.84 blue:0.35 alpha:1.0];
                         
                         CGRect boundsRect = self.loginButton.bounds;
                         boundsRect.size.width -= 80.0;
                         self.loginButton.bounds = boundsRect;
                         
                         self.loginButton.centerY -= 60.0;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

-(IBAction)login:(id)sender
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:1.5
                          delay:0.0
         usingSpringWithDamping:0.2
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         CGRect boundsRect = self.loginButton.bounds;
                         boundsRect.size.width += 80.0;
                         self.loginButton.bounds = boundsRect;
                     }
                     completion:^(BOOL finished){
                         [self showMessage:0];
                     } ];
    
    [UIView animateWithDuration:0.33
                          delay:0.0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.loginButton.centerY += 60.0;
                         self.loginButton.backgroundColor = [UIColor colorWithRed:0.85 green:0.83 blue:0.45 alpha:1.0];
                         spinner.center = CGPointMake(40.0, self.loginButton.frame.size.height/2);
                         spinner.alpha = 1.0;
                     }
                     completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
