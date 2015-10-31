//
//  FireBall.h
//  MarioinCity
//
//  Created by Do Minh Hai on 10/29/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//

#import "Sprite.h"

@interface FireBall : Sprite
@property(nonatomic, assign) BOOL isFlying;
@property(nonatomic, assign) CGFloat speed;
@property(nonatomic, weak) Sprite* fromSprite ;
-(void) startFly: (CGFloat) speed ;

@end
