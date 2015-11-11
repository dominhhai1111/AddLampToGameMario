//
//  MainScene.m
//  MarioinCity
//
//  Created by Do Minh Hai on 10/14/15.
//  Copyright (c) 2015 Do Minh Hai. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MainScene.h"
#import "Sprite.h"
#import "City.h"
#import "Cloud.h"
#import "Block.h"
#import "TrafficLamp.h"
#import "SuperMario.h"
#define city_background_width 1498

@implementation MainScene
{
    City *city1, *city2;
    CGSize citySize;
    NSTimer *timer;
    Cloud *cloud1, *cloud2, *cloud3;
    Block *block1, *block2, *block3 ;
    CGFloat marioRunSpeed;
    TrafficLamp * trafficLamp1;
    TrafficLamp * trafficLamp2;
    SuperMario* mario;
    UILabel* fireBallLable;
    AVAudioPlayer* audioPlayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSLog(@"%2.2f", self.view.bounds.size.height);
    CGFloat statusNavigationBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height;
    
    self.size = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - statusNavigationBarHeight);
    [self addCity];
    [self addClouds];
    [self addTrafficLamp];
    [self addBlock];
    [self addSuperMario];
    [self addFireBallCountLable];
       marioRunSpeed = 20.0;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                             target:self
                                           selector:@selector(gameloop)
                                           userInfo:nil
                                        repeats:true];
    [self playSong:@"Levan Polkka - Hatsune Miku"];
}
- (void) addSuperMario
{
    mario = [[SuperMario alloc] initWithName:@"mario"
                                     inScene:self];
    mario.y0 = self.size.height - mario.view.bounds.size.height*0.5 -10 ;
    mario.view.center = CGPointMake(100, mario.y0);
    [self addSprite:mario];
}
- (void) addCity {
    citySize = CGSizeMake(city_background_width, 400);
    UIImage* cityBackground = [UIImage imageNamed:@"city"];
    city1 = [[City alloc] initWithName:@"city1"
                               ownView:[[UIImageView alloc] initWithImage:cityBackground]
                               inScene:self];
    city1.view.frame = CGRectMake(0, self.size.height - citySize.height, citySize.width, citySize.height);
    
    city2 = [[City alloc] initWithName:@"city2"
                               ownView:[[UIImageView alloc] initWithImage:cityBackground]
                               inScene:self];
    
    city2.view.frame = CGRectMake(citySize.width, self.size.height - citySize.height, citySize.width, citySize.height);
    
    [self.view addSubview:city1.view];
    [self.view addSubview:city2.view];
    
}
- (void) addClouds {
    cloud1 = [[Cloud alloc] initWithName:@"cloud1"
                                 ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud1.png"]]
                                 inScene:self];
    cloud1.speed = - 10.0;
    
    cloud2 = [[Cloud alloc] initWithName:@"cloud2"
                                 ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud2.png"]]
                                 inScene:self];
    cloud2.speed = - 5.0;
    
    cloud3 = [[Cloud alloc] initWithName:@"cloud3"
                                 ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloud3.png"]]
                                 inScene:self];
    cloud3.speed = - 8.0;
    
    cloud1.view.frame = CGRectMake(20, 15, 100, 100);
    cloud2.view.frame = CGRectMake(150, 3, 80, 80);
    cloud3.view.frame = CGRectMake(260, 7, 90, 90);
    
    [self addSprite:cloud1];
    [self addSprite:cloud2];
    [self addSprite:cloud3];
    
}
-(void) addTrafficLamp
{
    trafficLamp1 = [[TrafficLamp alloc] initWithName:@"trafficLamp1"
                                          inScene:self];
    trafficLamp1.view.frame = CGRectMake(300, 190, 59, 180 );
    trafficLamp1.speed = -20;
    
    trafficLamp2 = [[TrafficLamp alloc] initWithName:@"trafficLamp2"
                                        inScene:self];
    trafficLamp2.view.frame = CGRectMake(650, 190, 59, 180 );
    trafficLamp2.speed = -20;
    
    [self addSprite:trafficLamp1];
    [self addSprite:trafficLamp2];
}
-(void) addBlock
{
    block1 = [[Block alloc] initWithName:@"block1"
                                 ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"block"]]
                                 inScene:self];
    CGFloat block1X = 81+arc4random()%60+666;
    block1.view.center = CGPointMake(block1X,self.view.bounds.size.height- 26);
    block1.speed = -20;
    
    block2 = [[Block alloc] initWithName:@"block2"
                                 ownView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"block"]]
                                 inScene:self];
    CGFloat block2X = 81+arc4random()%60 + 888+200;
    block2.view.center = CGPointMake(block2X,self.view.bounds.size.height- 26);
    block2.speed = -20;

    
    [self addSprite:block1];
    [self addSprite:block2];
    }
-(void) addFireBallCountLable
{
    fireBallLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 75)];
    fireBallLable.center = CGPointMake(557, 37.5);
    fireBallLable.text = [NSString stringWithFormat:@"FireBall: 00%d",7-mario.fireBallCount];
    fireBallLable.textColor = [UIColor redColor];
    fireBallLable.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:fireBallLable];
}

- (void) gameloop {
    ///
    fireBallLable.text = [NSString stringWithFormat:@"FireBall: 00%d",7-mario.fireBallCount];
    [self moveCityBackAtSpeed:marioRunSpeed];
    for (Sprite *sprite in self.sprites.allValues) {
        [sprite animate];
    }
    [self checkCollisionBetweenMarioAndBlocks];
   
}
- (void) moveCityBackAtSpeed: (CGFloat) speed {
    city1.view.center = CGPointMake(city1.view.center.x - speed, city1.view.center.y);
    city2.view.center = CGPointMake(city2.view.center.x - speed, city1.view.center.y);
    if (city1.view.frame.origin.x + citySize.width < 0.0) {
        city1.view.frame = CGRectMake(city2.view.frame.origin.x + citySize.width,
                                      city1.view.frame.origin.y,
                                      citySize.width,
                                      citySize.height);
        
    }
    if (city2.view.frame.origin.x + citySize.width < 0.0) {
        city2.view.frame = CGRectMake(city1.view.frame.origin.x + citySize.width,
                                      city2.view.frame.origin.y,
                                      citySize.width,
                                      citySize.height);
    }
}

-(void) checkCollisionBetweenMarioAndBlocks
{
    CGRect boundBlock1 = [block1.view convertRect:block1.view.bounds toView:nil];
    CGRect boundBlock2 = [block2.view convertRect:block2.view.bounds toView:nil];
    CGRect boundMario = [mario.view convertRect:mario.view.bounds toView:nil];
   if (CGRectIntersectsRect(boundBlock1, boundMario)){
        [mario getKilled];
        marioRunSpeed = 0.0;
       [audioPlayer stop];
       [self playSong:@"Game Over sound effect"];
       [timer invalidate];
        [self gameOver];
        //return true;
    }

if (CGRectIntersectsRect(boundBlock2, boundMario)){
    [mario getKilled];
    marioRunSpeed = 0.0;
    [audioPlayer stop];
    [self playSong:@"Game Over sound effect"];
    [timer invalidate];
    [self gameOver];
    //return true;
}}

- (void) gameOver {
    UIImageView* dialog = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gameover.png"]];
    
    dialog.center = CGPointMake(self.size.width * 0.5, -dialog.bounds.size.height * 0.5);
    [self.view addSubview:dialog];
    
    [UIView animateWithDuration:2 animations:^{
        dialog.center = CGPointMake(self.size.width * 0.5, self.size.height * 0.5);
    } completion:^(BOOL finished) {
        
    }];
}

- (void) playSong: (NSString*) song {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:song
                                                         ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSError *error;
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url
                                                         error:&error];
    [audioPlayer prepareToPlay];
    [audioPlayer play];
}
@end
