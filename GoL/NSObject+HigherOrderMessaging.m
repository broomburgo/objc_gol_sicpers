
#import "NSObject+HigherOrderMessaging.h"
#import "HOTimes.h"

@implementation NSObject (HigherOrderMessaging)

- (id)times:(NSUInteger)times
{
  return [HOTimes withObject:self times:times];
}

@end
