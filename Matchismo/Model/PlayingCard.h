//
//  PlayingCard.h
//  Matchismo
//
//  Created by Jorge Casariego on 22/08/13.
//  Copyright (c) 2013 Jorge Casariego. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
