#import "NSNumber+Times.h"

@implementation NSNumber (Times)

- (id)timesMake:(id)target perform:(SEL)action {
    return [self timesMake:target perform:action withObject:nil];
}

- (id)timesMake:(id)target perform:(SEL)action withObject:(id)object {
    
    return
    [self integerValue] != 0
    ? [self
       recursiveTimesMake:target
       perform:action
       withObject:object]
    : target;
}

- (id)recursiveTimesMake:(id)target perform:(SEL)action withObject:(id)object {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [target performSelector:action withObject:object];
#pragma clang diagnostic pop
    return [[NSNumber numberWithInteger:[self integerValue]-1]
            timesMake:target
            perform:action
            withObject:object];
}

@end
