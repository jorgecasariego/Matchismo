//
//  Card.h
//  Matchismo
//
//  Created by Jorge Casariego on 22/08/13.
//  Copyright (c) 2013 Jorge Casariego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

//Whats  on the card
@property (strong, nonatomic) NSString *contents;

//State of the card
@property (nonatomic, getter = isFaceUp) BOOL faceUp;

@property (nonatomic, getter = isUnplayable) BOOL unPlayable;

// return 0 if the other card do no match the receiver
// otherwise return an integer representing de quality of the match
// 1 should be the simplest, easiest match
// higher number should reflect how much more difficult the match was
- (int)match: (NSArray *)otherCards;

@end
