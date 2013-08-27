//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jorge Casariego on 22/08/13.
//  Copyright (c) 2013 Jorge Casariego. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards; // of Card

@end

@implementation CardMatchingGame

- (NSMutableArray *) cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex: (NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if(card && !card.isUnplayable){
        if(!card.isFaceUp){
            //We see if flipping this card up creates a match
            for(Card *otherCard in self.cards){
                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    //match return  how good a match it was (zero if not a match)
                    int matchScore = [card match:@[otherCard]] ;
                    //if it's a match, both cards become unplayable and we up our score
                    if(matchScore){
                        card.unPlayable = YES;
                        otherCard.unPlayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                    } else{
                        //if it doesn't match assess a penalty
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                    }
                
                    break;
                }
            }
            //we always charge a cost to flip
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

//We check index to be sure is not out of bounds
- (Card *)cardAtIndex: (NSUInteger)index
{
    return (index <  [self.cards count]) ? self.cards[index] : nil;
}

- (id) initWithCardCount: (NSUInteger)count
               usingDeck: (Deck *)deck
{
    //NSObject's designated initializer is init
    self = [super init];
    if(self){
        for(int i=0; i<count; i++){
            //draw a random card from the specified deck
            Card *card = [deck drawRandomCard];
            if(card){
                self.cards[i] = card;
            } else{
                self = nil;
                break;
            }
            
        }
    }
    
    return self;
}

@end
