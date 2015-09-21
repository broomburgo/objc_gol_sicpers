#import "Times.h"

@interface NSObject (Times_Internal) <Times>

- (instancetype)initializeTimes;
- (void)execute:(void(^)(void))executeBlock;

@end
