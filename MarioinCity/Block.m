//
//  Block.m
//  MarioinCity
//
//  Created by Do Minh Hai on 10/14/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//

#import "Block.h"

@implementation Block

-(void) animate {
    self.view.center = CGPointMake(self.view.center.x + self.speed, self.view.center.y);
    
    if (self.view.frame.origin.x + self.view.bounds.size.width < 0) {
        self.view.center = CGPointMake(self.scene.size.width + self.view.bounds.size.width * 0.5, self.view.center.y);
    }
    
}
@end
