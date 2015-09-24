#import "HOTimes.h"

@interface HOTimes ()

@property (nonatomic) NSUInteger times;

@end

@implementation HOTimes

+ (id)withObject:(id)object times:(NSUInteger)times
{
  id instance = [self withObject:object];
  [instance setTimes:times];
  return instance;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
  for (NSUInteger i = 0; i < self.times; i++)
  {
    [anInvocation invokeWithTarget:self.object];
  }
}

@end
