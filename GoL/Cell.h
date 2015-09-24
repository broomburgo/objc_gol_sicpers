#import <Foundation/Foundation.h>
#import "Grid.h"

@protocol CellInterface;

@protocol TickVisitableCell <NSObject>

- (id<CellInterface>)tickOnGrid:(Grid*)grid
                              x:(NSInteger)x
                              y:(NSInteger)y;
@end

@protocol CellInterface <TickVisitableCell>

- (NSInteger)neighboursOnGrid:(Grid*)grid
                            x:(NSInteger)x
                            y:(NSInteger)y;
- (id<CellInterface>)switchPopulation;

- (NSArray*)potentialStates;
- (NSInteger)populationValue;


@end

@interface Cell : NSObject <CellInterface, NSCopying>

+ (id<CellInterface>)living;
+ (id<CellInterface>)dead;

@end