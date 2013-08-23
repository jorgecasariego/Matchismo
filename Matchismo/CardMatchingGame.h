//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Jorge Casariego on 22/08/13.
//  Copyright (c) 2013 Jorge Casariego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (id) initWithCardCount: (NSUInteger)count
               usingDeck: (Deck *)deck;

- (void)flipCardAtIndex: (NSUInteger)index;

- (Card *)cardAtIndex: (NSUInteger)index;

@property (readonly, nonatomic) int score;

@end
