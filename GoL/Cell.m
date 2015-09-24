#import "Cell.h"
#import "Grid.h"

@interface LivingCell : Cell

@end

@interface DeadCell : Cell

@end

@implementation Cell

+ (id<CellInterface>)living
{
  static LivingCell* value = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    value = [LivingCell new];
  });
  return value;
}

+ (id<CellInterface>)dead
{
  static DeadCell* value = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    value = [DeadCell new];
  });
  return value;
}

- (NSInteger)neighboursOnGrid:(Grid*)grid
                            x:(NSInteger)x
                            y:(NSInteger)y
{
  return [[[grid
            neighboursOfX:x
            y:y]
           valueForKeyPath:@"@sum.populationValue"]
          integerValue];
}

- (id<CellInterface>)switchPopulation
{
  return self;
}

- (id<CellInterface>)tickOnGrid:(Grid*)grid
                              x:(NSInteger)x
                              y:(NSInteger)y
{
  return [[self potentialStates]
          objectAtIndex:[self
                         neighboursOnGrid:grid
                         x:x
                         y:y]];
}

- (NSArray*)potentialStates
{
  return nil;
}

- (NSInteger)populationValue
{
  return -1;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
  return self;
}

@end

@implementation LivingCell

- (id<CellInterface>)switchPopulation
{
  return [Cell dead];
}

- (NSArray*)potentialStates
{
  static NSArray* value = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    value = @[[Cell dead],
              [Cell dead],
              [Cell living],
              [Cell living],
              [Cell dead],
              [Cell dead],
              [Cell dead],
              [Cell dead],
              [Cell dead]];
  });
  return value;
}

- (NSInteger)populationValue
{
  return 1;
}

@end

@implementation DeadCell

- (id<CellInterface>)switchPopulation
{
  return [Cell living];
}

- (NSArray*)potentialStates
{
  static NSArray* value = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    value = @[[Cell dead],
              [Cell dead],
              [Cell dead],
              [Cell living],
              [Cell dead],
              [Cell dead],
              [Cell dead],
              [Cell dead],
              [Cell dead]];
  });
  return value;
}

- (NSInteger)populationValue
{
  return 0;
}

@end