//
//  TrafficLamp.m
//  MarioinCity
//
//  Created by Do Minh Hai on 10/28/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//

#import "TrafficLamp.h"

@implementation TrafficLamp
-(void) animate {
    self.view.center = CGPointMake(self.view.center.x + self.speed, self.view.center.y);
    
    if (self.view.frame.origin.x + self.view.bounds.size.width < 0) {
        self.view.center = CGPointMake(self.scene.size.width + self.view.bounds.size.width * 0.5, self.view.center.y);
    }
      
}
-(instancetype) initWithName:(NSString *)name
                     inScene:(Scene *)scene
{
    self = [super initWithName:name
                       inScene:scene];
    UIImageView* animationTrafficLamp = [[UIImageView alloc] initWithFrame:CGRectMake(300, 190, 59, 180 )] ;
    animationTrafficLamp.animationImages =@[[UIImage imageNamed:@"TrafficLamp1"], [UIImage imageNamed:@"TrafficLamp2"]];
    animationTrafficLamp.animationDuration= 1.5;
    animationTrafficLamp.animationRepeatCount = -1;
    [animationTrafficLamp startAnimating];
    self.view = animationTrafficLamp;
    return self;
}
@end
