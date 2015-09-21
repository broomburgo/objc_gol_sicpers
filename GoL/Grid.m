#import "Grid.h"
#import "Cell.h"
#import "GridVisitors.h"
#import "Times_Internal.h"

@interface NSMutableArray (Times) <Times>

- (NSMutableArray*)appendObject:(id)object;

@end

@implementation NSMutableArray (Times)

- (NSMutableArray*)appendObject:(id)object {
    if (object != nil) {
        [self execute:^{
            [self addObject:object];
        }];
    }
    return self;
}

@end

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
    return [Grid
            withSideLength:sideLength
            dwellers:[[[[NSMutableArray alloc]
                        initWithCapacity:sideLength*sideLength]
                       times:sideLength*sideLength]
                      appendObject:[EmptyCell new]]];
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
    return [[[[GridVisitation
               onGrid:self
               sideLength:self.sideLength
               visitor:visitor]
              times:self.sideLength*self.sideLength]
             visitNext]
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
