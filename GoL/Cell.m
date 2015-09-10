#import "Cell.h"
#import "Grid.h"

@interface LivingCell : Cell <ActiveCell>

@end

@interface DeadCell : Cell <ActiveCell>

@end

@implementation Cell

- (id<ActiveCell>)cell {
    return nil;
}

+ (id<AbstractCell>)living {
    static LivingCell* value = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        value = [LivingCell new];
    });
    return value;
}

+ (id<AbstractCell>)dead {
    static DeadCell* value = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        value = [DeadCell new];
    });
    return value;
}

- (NSInteger)neighboursOnGrid:(Grid*)grid
                            x:(NSInteger)x
                            y:(NSInteger)y {
    return [[[grid
              neighboursOfX:x
              y:y]
             valueForKeyPath:@"@sum.populationValue"]
            integerValue];
}

- (id<AbstractCell>)switchPopulation {
    return self;
}

- (id<AbstractCell>)tickOnGrid:(Grid*)grid
                             x:(NSInteger)x
                             y:(NSInteger)y {
    return [[[self cell]
             potentialStates]
            objectAtIndex:[[self cell]
                           neighboursOnGrid:grid
                           x:x
                           y:y]];
}

- (instancetype)copyWithZone:(NSZone *)zone {
    return self;
}

@end

@implementation LivingCell

- (id<AbstractCell>)cell {
    return self;
}

- (id<AbstractCell>)switchPopulation {
    return [Cell dead];
}

- (NSArray*)potentialStates {
    static NSArray* value = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        value = [NSArray arrayWithObjects:
                 [Cell dead],
                 [Cell dead],
                 [Cell living],
                 [Cell living],
                 [Cell dead],
                 [Cell dead],
                 [Cell dead],
                 [Cell dead],
                 [Cell dead],
                 nil];
    });
    return value;
}

- (NSInteger)populationValue {
    return 1;
}

@end

@implementation DeadCell

- (id<AbstractCell>)cell {
    return self;
}

- (id<AbstractCell>)switchPopulation {
    return [Cell living];
}

- (NSArray*)potentialStates {
    static NSArray* value = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        value = [NSArray arrayWithObjects:
                 [Cell dead],
                 [Cell dead],
                 [Cell dead],
                 [Cell living],
                 [Cell dead],
                 [Cell dead],
                 [Cell dead],
                 [Cell dead],
                 [Cell dead],
                 nil];
    });
    return value;
}

- (NSInteger)populationValue {
    return 0;
}

@end