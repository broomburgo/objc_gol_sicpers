#import "Times_Internal.h"
#import <objc/runtime.h>

static const NSUInteger kInitialTimes = 1;

@implementation NSObject (Times_Internal)

- (NSUInteger)times {
    return [objc_getAssociatedObject(self, @selector(times)) integerValue];
}

- (void)setTimes:(NSUInteger)times {
    objc_setAssociatedObject(self, @selector(times), @(times), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (instancetype)times:(NSUInteger)times {
    [self setTimes:times];
    return self;
}

- (instancetype)initializeTimes {
    return [self times:kInitialTimes];
}

- (void)execute:(void (^)(void))executeBlock {
    if (executeBlock != nil) {
        for (NSUInteger i = 0; i < self.times; i++) {
            executeBlock();
        }
    }
    [self initializeTimes];
}

@end