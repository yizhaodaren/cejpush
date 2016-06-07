//
//  JXImageView.m
//  textScr
//
//  Created by JK PENG on 11-8-17.
//  Copyright 2011年 Devdiv. All rights reserved.
//

#import "JXImageView.h"


@implementation JXImageView
@synthesize delegate;
@synthesize didTouch;
@synthesize changeAlpha;
@synthesize animationType;
@synthesize selected;
@synthesize enabled;

- (id)init
{
    self = [super init];
    if (self) {
        [self doSet];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self doSet];
    }
    return self;
}

-(void)doSet{
    changeAlpha = NO;
    selected    = NO;
    enabled     = NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan");
    //[super touchesBegan: touches withEvent: event];
    if(changeAlpha)
        self.alpha = 0.5;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    NSLog(@"touchesMoved");
    [super touchesMoved: touches withEvent: event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesEnded");
    //[super touchesEnded: touches withEvent: event];
    if(changeAlpha)
        self.alpha = 1;
    BOOL inside = YES;
    for(int i=0;i<[touches count];i++){
        CGPoint p = [[[touches allObjects] objectAtIndex:i] locationInView:self];
        NSLog(@"%d=%f,%f",i,p.x,p.y);        
        if(p.x<0 || p.y <0){
            inside = NO;
            break;
        }
        if(p.x>self.frame.size.width || p.y>self.frame.size.height){
            inside = NO;
            break;
        }
    }
    if(!inside){
        if(self.delegate != nil && [self.delegate respondsToSelector:self.didDragout])
            [self.delegate performSelectorOnMainThread:self.didDragout withObject:self waitUntilDone:NO];
        return;
    }
	if(self.delegate != nil && [self.delegate respondsToSelector:self.didTouch])
		[self.delegate performSelectorOnMainThread:self.didTouch withObject:self waitUntilDone:NO];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    //[super touchesCancelled: touches withEvent: event];
    NSLog(@"touchesCancelled");
    if(changeAlpha)
        self.alpha = 1;
    for(int i=0;i<[touches count];i++){
        CGPoint p = [[[touches allObjects] objectAtIndex:i] locationInView:self];
        NSLog(@"%d=%f,%f",i,p.x,p.y);
    }
}



-(void)setImage:(UIImage *)image{
    switch (self.animationType) {
        case JXImageView_Animation_More:
            [self addAnimationPage:2];
            break;
        case JXImageView_Animation_Line:
            [self addAnimation:2.0];
            break;
        default:
            break;
    }
    
    [super setImage:image];
}

-(void)addAnimation:(int)nTime
{
	CATransition *transition = [CATransition animation];
	// Animate over 3/4 of a second
	transition.duration = nTime;
	// using the ease in/out timing function
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
	transition.type = kCATransitionFade;
	transition.delegate = self;
	
	[self.layer addAnimation:transition forKey:nil];
}

-(void)addAnimationPage:(int)nTime{
	// First create a CATransition object to describe the transition
	CATransition *transition = [CATransition animation];
	// Animate over 3/4 of a second
	transition.duration = nTime;
	// using the ease in/out timing function
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	
    NSString *types[4] = {kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade};
    NSString *subtypes[4] = {kCATransitionFromLeft, kCATransitionFromRight};
    int rnd = random() % 4;
    transition.type = types[rnd];
    if(rnd < 3) // if we didn't pick the fade transition, then we need to set a subtype too
    {
        transition.subtype = subtypes[random() % 2];
    }
	
	transition.delegate = self;
	[self.layer addAnimation:transition forKey:nil];
}

-(void)setDidTouch:(SEL)value{
    if(value){
        didTouch = value;
        changeAlpha = YES;
        self.userInteractionEnabled = YES;
    }
}

@end
