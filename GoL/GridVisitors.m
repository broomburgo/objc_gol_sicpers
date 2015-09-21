
#import "GridVisitors.h"
#import "Cell.h"
#import "Grid.h"
#import "Times_Internal.h"

@implementation TickVisitor

- (id<CellInterface>)visitCell:(id<CellInterface>)cell
                         grid:(Grid*)grid
                   sideLength:(NSInteger)n
                            x:(NSInteger)x
                            y:(NSInteger)y {
    return [cell
            tickOnGrid:grid
            x:x
            y:y];
}

@end

@interface PopulateVisitor ()

@property (nonatomic) id<CellInterface> cell;

@end

@implementation PopulateVisitor

+ (PopulateVisitor*)withCell:(id<CellInterface>)cell {
    PopulateVisitor* visitor = [PopulateVisitor new];
    visitor.cell = cell;
    return visitor;
}

- (id<CellInterface>)visitCell:(id<CellInterface>)cell
                         grid:(Grid*)grid
                   sideLength:(NSInteger)n
                            x:(NSInteger)x
                            y:(NSInteger)y {
    return self.cell;
}

@end

@interface GridVisitation ()

@property (nonatomic) Grid* grid;
@property (nonatomic) id<GridVisitor> visitor;
@property (nonatomic) NSUInteger cursor;
@property (nonatomic) NSUInteger sideLength;

@property (nonatomic) NSMutableArray* m_allVisited;

@end

@implementation GridVisitation

+ (GridVisitation*)onGrid:(Grid*)grid
               sideLength:(NSInteger)sideLength
                  visitor:(id<GridVisitor>)visitor {
    GridVisitation* visitation = [GridVisitation new];
    visitation.grid = grid;
    visitation.sideLength = sideLength;
    visitation.visitor = visitor;
    visitation.m_allVisited = [NSMutableArray array];
    [visitation initializeTimes];
    return visitation;
}


- (GridVisitation*)visitNext {
    [self execute:^{
        NSUInteger x = self.cursor / self.sideLength;
        NSUInteger y = self.cursor % self.sideLength;
        self.cursor += 1;
        [self.m_allVisited
         addObject:[self.visitor
                    visitCell:[self.grid
                               cellAtX:x
                               y:y]
                    grid:self.grid
                    sideLength:self.sideLength
                    x:x
                    y:y]];
    }];
    return self;
}

- (Grid*)visitedGrid {
    return [Grid
            withSideLength:self.sideLength
            dwellers:self.m_allVisited];
}

@end