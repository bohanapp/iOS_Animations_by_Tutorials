//
//  HorizontalItemList.h
//  AutolayoutAnimation
//
//  Created by Yuan Gao on 27/02/2017.
//  Copyright © 2017 Yuan Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^didSelectItem)(NSInteger);

@interface HorizontalItemList : UIScrollView

@property(nonatomic,copy)didSelectItem selectItem;
- (instancetype)initInView:(UIView *)inview;
@end
