//
//  FlightData.h
//  FlightInfo
//
//  Created by Yuan Gao on 23/02/2017.
//  Copyright © 2017 Yuan Gao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightData : NSObject

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *flightNr;

@property (nonatomic, copy) NSString *gateNr;

@property (nonatomic, copy) NSString *departingFrom;

@property (nonatomic, copy) NSString *arrivingTo;

@property (nonatomic, copy) NSString *weatherImageName;

@property (nonatomic) BOOL showWeatherEffects;

@property (nonatomic) BOOL isTakingOff;

@property (nonatomic, copy) NSString *flightStatus;


//
// Pre- defined flights
//


@end
