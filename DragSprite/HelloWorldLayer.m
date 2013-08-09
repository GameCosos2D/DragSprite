//
//  HelloWorldLayer.m
//  DragSprite
//
//  Created by Marco Velluto on 10/08/13.
//  Copyright Algos 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        _MoveableSpriteTouch = FALSE;
        self.isTouchEnabled = YES;
        _MoveableSprite = [CCSprite spriteWithFile:@"smile.png"];
        _MoveableSprite.position = ccp(_MoveableSprite.contentSize.width / 2, _MoveableSprite.contentSize.height / 2);
        [self addChild:_MoveableSprite];
	
    }
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

#pragma mark Touch delegate

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch* myTouch = [touches anyObject];
	CGPoint location = [myTouch locationInView: [myTouch view]];
	location = [[CCDirector sharedDirector]convertToGL:location];
	
	CGRect MoveableSpriteRect = CGRectMake(_MoveableSprite.position.x - (_MoveableSprite.contentSize.width/2),
                                           _MoveableSprite.position.y - (_MoveableSprite.contentSize.height/2),
                                           _MoveableSprite.contentSize.width,
                                           _MoveableSprite.contentSize.height);
	if (CGRectContainsPoint(MoveableSpriteRect, location)) {
		_MoveableSpriteTouch=TRUE;
	}
	
	
}
-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *myTouch = [touches anyObject];
	CGPoint point = [myTouch locationInView:[myTouch view]];
	point = [[CCDirector sharedDirector] convertToGL:point];
	//CCNode *sprite = [self getChildByTag:kTagBall];
	if(_MoveableSpriteTouch==TRUE){
		[_MoveableSprite setPosition:point];
	}
	//return YES;
}
-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	_MoveableSpriteTouch=FALSE;
}

@end
