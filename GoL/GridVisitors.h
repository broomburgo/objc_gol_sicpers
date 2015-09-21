#import <Foundation/Foundation.h>
#import "Grid.h"
#import "Times.h"

@protocol CellInterface;

@protocol GridVisitor <NSObject>

- (id<CellInterface>)visitCell:(id<CellInterface>)cell
                         grid:(Grid*)grid
                   sideLength:(NSInteger)n
                            x:(NSInteger)x
                            y:(NSInteger)y;

@end

@interface TickVisitor : NSObject <GridVisitor>

@end

@interface PopulateVisitor : NSObject <GridVisitor>

+ (PopulateVisitor*)withCell:(id<CellInterface>)cell;

@end

@interface GridVisitation : NSObject <Times>

+ (GridVisitation*)onGrid:(Grid*)grid
               sideLength:(NSInteger)sideLength
                  visitor:(id<GridVisitor>)visitor;

- (GridVisitation*)visitNext;
- (Grid*)visitedGrid;

@end
