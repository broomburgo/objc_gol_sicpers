
#import "NSMutableArray+Append.h"

@implementation NSMutableArray (Append)

- (NSMutableArray*)append:(id)object {
  [self addObject:object];
  return self;
}

@end

