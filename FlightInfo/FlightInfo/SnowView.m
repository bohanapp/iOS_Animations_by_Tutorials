//
//  SnowView.m
//  FlightInfo
//
//  Created by Yuan Gao on 23/02/2017.
//  Copyright © 2017 Yuan Gao. All rights reserved.
//

#import "SnowView.h"
#import <QuartzCore/QuartzCore.h>

@implementation SnowView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CAEmitterLayer *emitter = [[CAEmitterLayer alloc] init];
        [emitter setPosition:CGPointMake(self.bounds.size.width/2, 0)];
        emitter.emitterSize = self.bounds.size;
        emitter.emitterShape = kCAEmitterLayerRectangle;
        
        CAEmitterCell *emitterCell = [[CAEmitterCell alloc] init];
        emitterCell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"flake.png"].CGImage);
        emitterCell.birthRate = 200;
        emitterCell.lifetime = 3.5;
        emitterCell.color = [UIColor whiteColor].CGColor;
        emitterCell.redRange = 0.0;
        emitterCell.blueRange = 0.1;
        emitterCell.greenRange = 0.0;
        emitterCell.velocity = 10;
        emitterCell.velocityRange = 350;
        emitterCell.emissionRange = M_PI_2;
        emitterCell.emissionLongitude = -M_PI;
        emitterCell.yAcceleration = 70;
        emitterCell.xAcceleration = 0;
        emitterCell.scale = 0.33;
        emitterCell.scaleRange = 1.25;
        emitterCell.scaleSpeed = -0.25;
        emitterCell.alphaRange = 0.5;
        emitterCell.alphaSpeed = -0.15;
        emitter.emitterCells = @[emitterCell];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
