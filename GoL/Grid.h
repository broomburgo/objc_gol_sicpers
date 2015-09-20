#import <Foundation/Foundation.h>

@protocol CellInterface;
@protocol GridVisitor;

@interface Grid : NSObject <NSCopying>

+ (Grid*)withSideLength:(NSUInteger)sideLength;
+ (Grid*)withSideLength:(NSUInteger)sideLength
               dwellers:(NSArray*)dwellers;

- (id<CellInterface>)cellAtX:(NSInteger)x
                          y:(NSInteger)y;

- (NSArray*)neighboursOfX:(NSInteger)x
                        y:(NSInteger)y;

- (Grid*)cellAtX:(NSInteger)x
               y:(NSInteger)y
      switchWith:(id<CellInterface>)newCell;

- (Grid*)tick;
- (Grid*)fillWith:(id<CellInterface>)cell;

- (Grid*)visit:(id<GridVisitor>)visitor;

@end


