//
//  JXWaitView.m
//  shiku_im
//
//  Created by flyeagleTang on 14-5-31.
//  Copyright (c) 2014年 Reese. All rights reserved.
//

#import "JXWaitView.h"
#import "UIFactory.h"

@implementation JXWaitView
@synthesize isShowing;

static JXWaitView *shared;

+(JXWaitView*)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared=[[JXWaitView alloc]initWithTitle:nil];
    });
    return shared;
}

- (id)initWithTitle:(NSString*)s
{
    self = [super initWithFrame:g_window.bounds];
    if (self) {
        UIView* view = [[UIView alloc] initWithFrame:g_window.bounds];
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.3;
        [self addSubview:view];
      
        
        CGRect r = CGRectMake(k_ScreenWith/2-100, (k_ScreenHeight-200)/2, 200, 200);
        _iv = [[UIImageView alloc]initWithFrame:r];
        _iv.image = [UIImage imageNamed:@"alertView-bg@2x.png"];
        _iv.alpha = 1;
        [self addSubview:_iv];
        

        r = CGRectMake(0, 160, _iv.frame.size.width, 20);
        _title = [UIFactory createLabelWith:r text:s font:nil textColor:[UIColor whiteColor] backgroundColor:[UIColor clearColor]];
        [_iv addSubview:_title];
        _title.textAlignment = UITextAlignmentCenter;

        _aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        int n = 38;
        _aiv.frame = CGRectMake((_iv.frame.size.width-n)/2, (_iv.frame.size.height-n)/2, n, n);
        [_iv addSubview:_aiv];
               isShowing = NO;
    }
    return self;
}



-(void)start:(NSString*)s{
    isShowing = YES;
    if(s)
        _title.text = s;
    else
        _title.text = @"正在加载";
    [g_window addSubview:self];
    self.hidden = NO;
    [_aiv startAnimating];
}

-(void)stop{
    isShowing = NO;
    [self removeFromSuperview];
    self.hidden = YES;
    [_aiv stopAnimating];
}

@end