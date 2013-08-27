//
//  Card.m
//  Matchismo
//
//  Created by Jorge Casariego on 22/08/13.
//  Copyright (c) 2013 Jorge Casariego. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match: (NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards) {
        //Card matches only if the cards are exactly the same
        if([card.contents isEqualToString:self.contents]){
            score = 1;
        }
    }
    
    return score;
}

@end
