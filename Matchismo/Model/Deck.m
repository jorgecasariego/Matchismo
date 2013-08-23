//
//  Deck.m
//  Matchismo
//
//  Created by Jorge Casariego on 22/08/13.
//  Copyright (c) 2013 Jorge Casariego. All rights reserved.
//

#import "Deck.h"
#import "Card.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

//Constructor de cards. Inicializamos la nueva variable
- (NSMutableArray *) cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

//insertamos una carta en el mazo de cartas
- (void)addCard: (Card *)card atTop:(BOOL)atTop
{
    if(atTop){
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

//Metodo para retornar una carta de forma randomica
- (Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    if(self.cards.count){
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end
