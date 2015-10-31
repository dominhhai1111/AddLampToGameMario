//
//  FireBall.m
//  MarioinCity
//
//  Created by Do Minh Hai on 10/29/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//

#import "FireBall.h"

@implementation FireBall
-(instancetype) initWithName:(NSString *)name inScene:(Scene *)scene
{
    self = [super initWithName:name
                       ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fireball"]]
                       inScene:scene];
    return self;
    
}

-(void) startFly:(CGFloat)speed
{
    if (!self.isFlying) {
        self.isFlying = true;
        self.speed =speed;
    }
}

-(void) fly
{
    if (!self.isFlying) return;
    CGFloat x = self.view.center.x + self.speed;
    if (x>self.view.bounds.size.width + self.scene.size.width) {
        [self.scene removeSprite:self];
        return;
    }
    self.view.center = CGPointMake(x, self.view.center.y);
}

-(void) animate
{
    [self fly];
}
@end
