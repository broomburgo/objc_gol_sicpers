
#import "HOAbstract.h"

@interface HOAbstract ()

@property (nonatomic) id object;

@end

@implementation HOAbstract

+ (id)withObject:(id)object
{
  id instance = [self new];
  [instance setObject:object];
  return instance;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
  [anInvocation invokeWithTarget:self.object];
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)aSelector
{
  return [self.object methodSignatureForSelector:aSelector];
}

@end
