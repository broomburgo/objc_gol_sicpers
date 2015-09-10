#import <Foundation/Foundation.h>
#import "Grid.h"

@protocol AbstractCell;

@protocol GridVisitor <NSObject>

- (id<AbstractCell>)visitCell:(id<AbstractCell>)cell
                         grid:(Grid*)grid
                   sideLength:(NSInteger)n
                            x:(NSInteger)x
                            y:(NSInteger)y;

@end

@interface TickVisitor : NSObject <GridVisitor>

@end

@interface PopulateVisitor : NSObject <GridVisitor>

+ (PopulateVisitor*)withCell:(id<AbstractCell>)cell;

@end

@interface GridVisitation : NSObject

+ (GridVisitation*)onGrid:(Grid*)grid
               sideLength:(NSInteger)sideLength
                  visitor:(id<GridVisitor>)visitor;

- (id<AbstractCell>)visitNext;
- (Grid*)visitedGrid;

@end
