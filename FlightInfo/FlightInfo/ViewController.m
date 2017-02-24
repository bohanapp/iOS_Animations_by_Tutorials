//
//  ViewController.m
//  FlightInfo
//
//  Created by Yuan Gao on 23/02/2017.
//  Copyright © 2017 Yuan Gao. All rights reserved.
//

#import "ViewController.h"
#import <CoreGraphics/CoreGraphics.h>
#import "SnowView.h"
#import "FlightData.h"
#import "UIView+Category.h"

typedef enum : NSInteger {
    positive = 1,
    negative = -1
} AnimationDirection;

@interface ViewController ()
{
    SnowView *snowView;
    FlightData *londonToParis;
    FlightData *parisToRome;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.summary addSubview:self.summaryIcon];
    self.summaryIcon.centerY = self.summary.frame.size.height/2;
    
    londonToParis = [[FlightData alloc] init];
    londonToParis.summary= @"01 Apr 2015 09:42";
    londonToParis.flightNr= @"ZY 2014";
    londonToParis.gateNr= @"T1 A33";
    londonToParis.departingFrom= @"LGW";
    londonToParis.arrivingTo= @"CDG";
    londonToParis.weatherImageName = @"bg-snowy";
    londonToParis.showWeatherEffects= YES;
    londonToParis.isTakingOff= YES;
    londonToParis.flightStatus = @"Boarding";
    
    parisToRome = [[FlightData alloc] init];
    parisToRome.summary = @"01 Apr 2015 17:05";
    parisToRome.flightNr = @"AE 1107";
    parisToRome.gateNr = @"045";
    parisToRome.departingFrom = @"CDG";
    parisToRome.arrivingTo = @"FCO";
    parisToRome.weatherImageName = @"bg-sunny";
    parisToRome.showWeatherEffects = NO;
    parisToRome.isTakingOff = NO;
    parisToRome.flightStatus = @"Delayed";
    
    //add the snow effect Layer
    snowView = [[SnowView alloc] initWithFrame:CGRectMake(-150, -100, 300, 50)];
    UIView *snowClipView = [[UIView alloc] initWithFrame:CGRectOffset(self.view.frame, 0, 50)];
    snowClipView.clipsToBounds = YES;
    [snowClipView addSubview:snowView];
    [self.view addSubview:snowClipView];
    [self changeFlightTo:londonToParis animated:NO];
}

-(void) fadeImageView:(UIImageView *)imageView toImage:(UIImage *)toImage showEffects:(BOOL) isShowEffect
{
    [UIView transitionWithView:imageView
                      duration:1.0
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        imageView.image = toImage;
                    }
                    completion:nil];
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         snowView.alpha = isShowEffect?1.0:0.0;
                     }
                     completion:nil];
}

- (void) changeFlightTo:(FlightData *)data animated:(BOOL) animated
{
    // populate the UI with the next flight's data
    self.summary.text = data.summary;
    self.bgImageView.image = [UIImage imageNamed:data.weatherImageName];
    
    if (animated) {
        
        [self planeDepart];
        [self fadeImageView:self.bgImageView
                    toImage:[UIImage imageNamed:data.weatherImageName]
                showEffects:data.showWeatherEffects];
        
        AnimationDirection direction = data.isTakingOff? positive:negative;
        [self cubeTransition:self.flightNr labelText:data.flightNr direction:direction];
        [self cubeTransition:self.gateNr labelText:data.gateNr direction:direction];
        [self cubeTransition:self.flightStatus labelText:data.flightStatus direction:direction];
        CGPoint offsetDeparting = CGPointMake(direction *80, 0.0);
        [self moveLabel:self.departingFrom string:data.departingFrom offset:offsetDeparting];
        CGPoint offsetArriving = CGPointMake(0.0, direction *50);
        [self moveLabel:self.arrivingTo string:data.arrivingTo offset:offsetArriving];
    }
    else
    {
        self.bgImageView.image = [UIImage imageNamed:data.weatherImageName];
        snowView.hidden = !data.showWeatherEffects;
        
        self.flightNr.text = data.flightNr;
        self.gateNr.text = data.gateNr;
        self.departingFrom.text = data.departingFrom;
        self.arrivingTo.text = data.arrivingTo;
        self.flightStatus.text = data.flightStatus;
    }
    
//    // schedule next flight
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.changeFlight(to: data.isTakingOff ? parisToRome : londonToParis)
        [self changeFlightTo:data.isTakingOff?parisToRome:londonToParis animated:YES];
    });
}

- (void)planeDepart
{
    CGPoint originalCenter = self.planeImage.center;
    
    [UIView animateKeyframesWithDuration:1.5
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                 //add keyframes
                                  [UIView addKeyframeWithRelativeStartTime:0.0
                                                          relativeDuration:0.25
                                                                animations:^{
                                                                    self.planeImage.centerX += 80.0;
                                                                    self.planeImage.centerY -= 10.0;
                                                                }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.1
                                                          relativeDuration:0.4
                                                                animations:^{
                                                                    self.planeImage.transform = CGAffineTransformMakeRotation(-M_PI/8);
                                                                }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.25
                                                          relativeDuration:0.25
                                                                animations:^{
                                                                    self.planeImage.centerX += 100.0;
                                                                    self.planeImage.centerY -= 50.0;
                                                                    self.planeImage.alpha = 0.0;
                                                                }];
                                  
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.51
                                                          relativeDuration:0.01
                                                                animations:^{
                                                                    self.planeImage.transform = CGAffineTransformIdentity;
                                                                    self.planeImage.center  = CGPointMake(0.0, originalCenter.y);
                                                                }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.55
                                                          relativeDuration:0.45
                                                                animations:^{
                                                                    self.planeImage.alpha = 1.0;
                                                                    self.planeImage.center  = originalCenter;
                                                                }];
                                  
                                  
                              }
                              completion:^(BOOL finished) {
                                  
                              }];
}

- (void) moveLabel:(UILabel *)label string:(NSString *)text offset:(CGPoint) offset
{
    UILabel *auxLabel = [[UILabel alloc] initWithFrame:label.frame];
    auxLabel.text = text;
    auxLabel.font = label.font;
    auxLabel.textAlignment = label.textAlignment;
    auxLabel.textColor = label.textColor;
    auxLabel.backgroundColor = [UIColor clearColor];
    
    auxLabel.transform = CGAffineTransformMakeTranslation(offset.x, offset.y);
    auxLabel.alpha = 0;
    [self.view addSubview:auxLabel];
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         label.transform = CGAffineTransformMakeTranslation(offset.x, offset.y);
                         label.alpha = 0;
                     }
                     completion:nil];
    
    [UIView animateWithDuration:0.25
                          delay:0.1
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         auxLabel.transform = CGAffineTransformIdentity;
                         auxLabel.alpha = 1.0;
                     }
                     completion:^(bool finished){
                         [auxLabel removeFromSuperview];
                         label.text = text;
                         label.alpha = 1.0;
                         label.transform = CGAffineTransformIdentity;
                     }];
}

- (void) cubeTransition:(UILabel *)label labelText:(NSString *)text direction:(AnimationDirection) direct
{
    UILabel *auxLabel = [[UILabel alloc] initWithFrame:label.frame];
    auxLabel.text = text;
    auxLabel.font = label.font;
    auxLabel.textAlignment = label.textAlignment;
    auxLabel.textColor = label.textColor;
    auxLabel.backgroundColor = label.backgroundColor;
    CGFloat auxLabelOffset = (CGFloat) direct * label.frame.size.height/2.0;
    auxLabel.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 0.1), CGAffineTransformMakeTranslation(0.0, auxLabelOffset));
    
//    auxLabel.transform = CGAffineTransformScale(auxLabel.transform, 1.0, 0.1);
//    auxLabel.transform = CGAffineTransformTranslate(auxLabel.transform, 0.0, auxLabelOffset);
    
    [label.superview addSubview:auxLabel];
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         auxLabel.transform = CGAffineTransformIdentity;
                         label.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 0.1), CGAffineTransformMakeTranslation(0.0, -auxLabelOffset));
                     }
                     completion:^(BOOL finished) {
                         label.text = auxLabel.text;
                         label.transform = CGAffineTransformIdentity;
                         [auxLabel removeFromSuperview];
                     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
