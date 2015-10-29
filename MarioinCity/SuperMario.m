//
//  SuperMario.m
//  MarioinCity
//
//  Created by Do Minh Hai on 10/28/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//

#import "SuperMario.h"

@implementation SuperMario
{
    BOOL isRunning, isJumping , isJumpingAndSanto;
    CGFloat jumpVelocity, fallAcceleration;
    float i ;
}
- (instancetype) initWithName: (NSString*) name
                      inScene: (Scene*) scene {
    self = [super initWithName:name
                       inScene:scene];
    UIImageView* marioView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 102)];
    marioView.userInteractionEnabled = true;
    marioView.multipleTouchEnabled = true;
    marioView.animationImages = @[
                                  [UIImage imageNamed:@"1.png"],
                                  [UIImage imageNamed:@"2.png"],
                                  [UIImage imageNamed:@"3.png"],
                                  [UIImage imageNamed:@"4.png"],
                                  [UIImage imageNamed:@"5.png"],
                                  [UIImage imageNamed:@"6.png"],
                                  [UIImage imageNamed:@"7.png"],
                                  [UIImage imageNamed:@"8.png"]
                                  ];
    marioView.animationDuration = 1.0;
    [marioView startAnimating];
    self.view = marioView;
   [self applyGestureRecognizer];
    self.alive = true;
    
   
    
    
    return self;
}

-(void) applyGestureRecognizer
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doSingleTap)];
    singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doDoubleTap)] ;
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
   // [self.scene.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
   //                                                                              action:@selector(startJump)]];
    [self.scene.view addGestureRecognizer:singleTap];
    [self.scene.view addGestureRecognizer:doubleTap];

}
-(void) doDoubleTap{
    if (!isJumpingAndSanto)
    {
        isJumpingAndSanto = true ;
        jumpVelocity =-40 ;
        fallAcceleration = 10;
        i = 0;
    }
}

-(void) JumpAndSanTo
{
    if (!isJumpingAndSanto) return ;
   
    CGFloat y = self.view.center.y ;
    y += jumpVelocity;
    jumpVelocity += fallAcceleration;
   
    
    if (y < self.y0-45 && i==0)
    {
        i=1;
        [self runSpinAnimationWithDuration:1];
    }
    
    if(y > self.y0)
    {
         y = self.y0;
         isJumpingAndSanto = false;
     }
    
    self.view.center = CGPointMake(self.view.center.x, y);
     
}

-(void) doSingleTap
{
    if (!isJumping)
    {
        isJumping = true ;
        jumpVelocity =-40 ;
        fallAcceleration = 10;
        i = 0;
    }
}

-(void) Jump
{
    if (!isJumping) return ;
    
    CGFloat y = self.view.center.y ;
    y += jumpVelocity;
    jumpVelocity += fallAcceleration;
   
    if(y > self.y0) {
        y = self.y0;
        isJumping = false;
    }
    self.view.center = CGPointMake(self.view.center.x, y);
    
}

- (void) runSpinAnimationWithDuration:(CGFloat) duration;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/  ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1.0;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [self.view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
- (void) animate
{
    if (!self.alive) return;
    [self JumpAndSanTo];
    [self Jump];
}

@end

