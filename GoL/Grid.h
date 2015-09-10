#import <Foundation/Foundation.h>

@protocol AbstractCell;
@protocol GridVisitor;

@interface Grid : NSObject <NSCopying>

+ (Grid*)withSideLength:(NSUInteger)sideLength;
+ (Grid*)withSideLength:(NSUInteger)sideLength
               dwellers:(NSArray*)dwellers;

- (id<AbstractCell>)cellAtX:(NSInteger)x
                          y:(NSInteger)y;

- (NSArray*)neighboursOfX:(NSInteger)x
                        y:(NSInteger)y;

- (Grid*)cellAtX:(NSInteger)x
               y:(NSInteger)y
      switchWith:(id<AbstractCell>)newCell;

- (Grid*)tick;
- (Grid*)fillWith:(id<AbstractCell>)cell;

- (Grid*)visit:(id<GridVisitor>)visitor;

@end


