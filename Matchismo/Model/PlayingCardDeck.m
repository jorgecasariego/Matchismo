//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Jorge Casariego on 22/08/13.
//  Copyright (c) 2013 Jorge Casariego. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

//El metodo init lo que hace es llamar al metodo init de la clase padre
- (id) init
{
    //Inicializamos las variables de la clase padre
    //Regla: Antes de inicializar nuestras variables SIEMPRE tenemos que inicializar la clase padre
    self = [super init];
    
    if(self){
        //Aquí inicializamos nuestras variables
        for(NSString *suit in [PlayingCard validSuits]){
            for(NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++){
                PlayingCard     *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:YES];
            }
        }
    }
    
    return self;
    
}

@end
