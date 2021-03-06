#import "Grid.h"
#import "Cell.h"
#import "GridVisitors.h"
#import "NSNumber+Times.h"

@interface EmptyCell : Cell <CellInterface>

@end

@implementation EmptyCell

@end

@interface Grid ()

@property (copy, nonatomic) NSArray* dwellers;
@property (nonatomic) NSUInteger sideLength;

@end

@implementation Grid

+ (Grid*)withSideLength:(NSUInteger)sideLength {
    return [Grid withSideLength:sideLength
                       dwellers:[[NSNumber numberWithInteger:sideLength*sideLength]
                                 timesMake:[[NSMutableArray alloc] initWithCapacity:sideLength*sideLength]
                                 perform:@selector(addObject:)
                                 withObject:[EmptyCell new]]];
}

+ (Grid*)withSideLength:(NSUInteger)sideLength
               dwellers:(NSArray*)dwellers {
    NSAssert(sideLength > 0, @"Grids must have positive length");
    NSAssert([dwellers count] == sideLength*sideLength, @"Grids must be populated");
    Grid* grid = [Grid new];
    grid.sideLength = sideLength;
    grid.dwellers = dwellers;
    return grid;
}

- (id<CellInterface>)cellAtX:(NSInteger)x
                          y:(NSInteger)y {
    return [[self dwellers]
             objectAtIndex:[self
                            indexForX:x
                            y:y]];
}

- (Grid*)cellAtX:(NSInteger)x
               y:(NSInteger)y
      switchWith:(id<CellInterface>)newCell {
    NSMutableArray* m_dwellers = [self.dwellers mutableCopy];
    [m_dwellers
     replaceObjectAtIndex:[self
                           indexForX:x
                           y:y]
     withObject:newCell];
    return [[self class]
            withSideLength:self.sideLength
            dwellers:m_dwellers];
}

- (Grid*)tick {
    return [self visit:[TickVisitor new]];
}

- (Grid*)fillWith:(id<CellInterface>)cell {
    return [self visit:[PopulateVisitor withCell:cell]];
    
}

- (Grid*)visit:(id<GridVisitor>)visitor {
    return [[[NSNumber numberWithInteger:self.sideLength*self.sideLength]
             timesMake:[GridVisitation
                        onGrid:self
                        sideLength:self.sideLength
                        visitor:visitor]
             perform:@selector(visitNext)]
            visitedGrid];
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return [Grid
            withSideLength:self.sideLength
            dwellers:self.dwellers];
}

#pragma mark - private

- (NSInteger)indexForX:(NSInteger)x
                     y:(NSInteger)y {
    
    NSInteger index = ((x+self.sideLength)%self.sideLength)*self.sideLength + ((y+self.sideLength)%self.sideLength);
    NSAssert((index >= 0) && (index < self.sideLength*self.sideLength), @"Should be in range");
    return index;
}

- (NSArray*)verticalNeighboursOfX:(NSInteger)x
                                y:(NSInteger)y {
    
    return @[[self cellAtX:x y:y-1],
             [self cellAtX:x y:y+1]];
}

- (NSArray*)horizontalNeighboursOfX:(NSInteger)x
                                  y:(NSInteger)y {
    
    return @[[self cellAtX:x-1 y:y],
             [self cellAtX:x+1 y:y]];
}

- (NSArray*)diagonalNeighboursOfX:(NSInteger)x
                                y:(NSInteger)y {
    
    return @[[self cellAtX:x-1 y:y-1],
             [self cellAtX:x-1 y:y+1],
             [self cellAtX:x+1 y:y-1],
             [self cellAtX:x+1 y:y+1]];
}

- (NSArray*)neighboursOfX:(NSInteger)x
                        y:(NSInteger)y {
    
    return [[[self verticalNeighboursOfX:x y:y]
             arrayByAddingObjectsFromArray:[self horizontalNeighboursOfX:x y:y]]
            arrayByAddingObjectsFromArray:[self diagonalNeighboursOfX:x y:y]];
}

@end
