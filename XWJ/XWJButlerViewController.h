//
//  XWJButlerViewController.h
//  信我家
//
//  Created by Sun on 15/11/28.
//  Copyright © 2015年 Paul. All rights reserved.
//

#import "XWJBaseViewController.h"
#import "LCBannerView.h"
@interface XWJButlerViewController : XWJBaseViewController<LCBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *adView;
@property (weak, nonatomic) IBOutlet UILabel *room;


@property NSMutableArray *notices;
@property NSMutableArray *shows ;

@property NSArray *vConlers;
@property NSArray *titles;

@end
