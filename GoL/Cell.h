#import <Foundation/Foundation.h>
#import "Grid.h"

@protocol AbstractCell;
@protocol ActiveCell;

@protocol TickVisitableCell <NSObject>

- (id<AbstractCell>)tickOnGrid:(Grid*)grid
                             x:(NSInteger)x
                             y:(NSInteger)y;
@end

@protocol AbstractCell <TickVisitableCell>

- (id<ActiveCell>)cell;

- (NSInteger)neighboursOnGrid:(Grid*)grid
                            x:(NSInteger)x
                            y:(NSInteger)y;
- (id<AbstractCell>)switchPopulation;



@end

@protocol ActiveCell <AbstractCell>

- (NSArray*)potentialStates;
- (NSInteger)populationValue;

@end

@interface Cell : NSObject <AbstractCell, NSCopying>

+ (id<AbstractCell>)living;
+ (id<AbstractCell>)dead;

@end