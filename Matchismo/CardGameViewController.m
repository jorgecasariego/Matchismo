//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Jorge Casariego on 19/08/13.
//  Copyright (c) 2013 Jorge Casariego. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons; //array de cartas
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation CardGameViewController

- (CardMatchingGame *) game
{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                         usingDeck:[[PlayingCardDeck alloc]init]];
    
    return _game;
}

-(void) setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

//El unico trabajo de este metodo es tomar el estado del "Modelo" y hacerlo
//reflejar en la interfaz de usuario (UI)
//*** Este es el trabajo principal de un controlador ***
//Hacer que la UI refleje el modelo
- (void)updateUI
{
    for(UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

-(void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

//Metodo que es llamado cada vez que aprieto el boton para dar la vuelta una carta

- (IBAction)flipCard:(UIButton *)sender
{
    //En la siguiente linea le decimos a nuestro Modelo "Flip Card at Index"
    //¿Y cual es el index? [self.cardButtons indexOfObject:sender]
    //Explicación:
    //- self.cardButtons : es nuestro array de botones y uno de esos botones (sender)
    //es el que nos envia este mensaje y nosotros preguntamos al array de botones (cardButtons)
    //por el index del objeto (0-12)
    //El orden es indeterminado. Pero no importa porque lo podemos saber a traves de esta linea:
    //self.cardButtons indexOfObject:sender
    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    
    //Actualizo la interfaz cada vez que doy la vuelta la carta
    [self updateUI];
}

@end
