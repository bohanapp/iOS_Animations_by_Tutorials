//
//  ViewController.m
//  FlightInfo
//
//  Created by Yuan Gao on 23/02/2017.
//  Copyright © 2017 Yuan Gao. All rights reserved.
//

#import "ViewController.h"
#import "SnowView.h"
#import "FlightData.h"
#import "UIView+Category.h"

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
    
    //add the snow effect Layer
    snowView = [[SnowView alloc] initWithFrame:CGRectMake(-150, -100, 300, 50)];
    UIView *snowClopView = [[UIView alloc] initWithFrame:CGRectOffset(self.view.frame, 0, 50)];
    snowClopView.clipsToBounds = YES;
    [snowClopView addSubview:snowView];
    [self.view addSubview:snowClopView];
    
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
}

- (void) changeFlightTo:(FlightData *)data
{
    // populate the UI with the next flight's data
    self.summary.text = data.summary;
    self.flightNr.text = data.flightNr;
    self.gateNr.text = data.gateNr;
    self.departingFrom.text = data.departingFrom;
    self.arrivingTo.text = data.arrivingTo;
    self.flightStatus.text = data.flightStatus;
    self.bgImageView.image = [UIImage imageNamed:data.weatherImageName];
    snowView.hidden = !data.showWeatherEffects;
    
    // schedule next flight
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.changeFlight(to: data.isTakingOff ? parisToRome : londonToParis)
        [self changeFlightTo:data.isTakingOff?parisToRome:londonToParis];
    });
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
