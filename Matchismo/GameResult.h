//
//  GameResult.h
//  Matchismo
//
//  Created by Jorge Casariego on 01/11/13.
//  Copyright (c) 2013 Jorge Casariego. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

+ (NSArray *) allGameResults; //of GameResults

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;

@end
