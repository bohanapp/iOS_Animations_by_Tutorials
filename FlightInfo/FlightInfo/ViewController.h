//
//  ViewController.h
//  FlightInfo
//
//  Created by Yuan Gao on 23/02/2017.
//  Copyright © 2017 Yuan Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (nonatomic, weak) IBOutlet UIImageView *bgImageView;

@property (nonatomic, weak) IBOutlet UIImageView *summaryIcon;

@property (nonatomic, weak) IBOutlet UILabel *summary;
@property (nonatomic, weak) IBOutlet UILabel *flightNr;
@property (nonatomic, weak) IBOutlet UILabel *gateNr;
@property (nonatomic, weak) IBOutlet UILabel *departingFrom;
@property (nonatomic, weak) IBOutlet UILabel *arrivingTo;

@property (nonatomic, weak) IBOutlet UIImageView *planeImage;

@property (nonatomic, weak) IBOutlet UILabel *flightStatus;

@property (nonatomic, weak) IBOutlet UIImageView *statusBanner;


@end

