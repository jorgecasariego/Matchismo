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

//Interface: this area is where we put private properties and is called "Class Extension"
//note the ()
@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
//This is now an NSArray which will contain all the UIButtons we connect in random order.
//This randomness is ok for our purpose because the order of these cards will mean nothing to our matching game
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons; //array de cartas
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation CardGameViewController

- (CardMatchingGame *) game
{
    //Lazy instantiation: is the tactic of delaying the creation of an object, the calculation of a value, or some other expensive process until the first time it is needed.
    //See how we are using our initializer here
    //We get the card count from however many buttons are in our View.
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                         usingDeck:[[PlayingCardDeck alloc]init]];
    
    return _game;
}

-(void) setCardButtons:(NSArray *)cardButtons
{
    //When we implement our setter, we can't forget this line or our setter won't set anymore!
    _cardButtons = cardButtons;
    [self updateUI];
}

//El unico trabajo de este metodo es tomar el estado del "Modelo" y hacerlo
//reflejar en la interfaz de usuario (UI)
//*** Este es el trabajo principal de un controlador ***
//Hacer que la UI refleje el modelo
- (void)updateUI
{
    //To update the UI, we just cycle through the card buttons, getting the asociated Card from the CardMatchingGame
    for(UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        //We set the title in the Selected state to be the Card's contents (if the content have not changed, this will do nothing)
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        //We set the title when the button is both select & disable to also be the Card's contents
        [cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
        //We select the card only if it isFaceUp
        cardButton.selected = card.isFaceUp;
        //Make the card untappable if it isUnplayable
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
