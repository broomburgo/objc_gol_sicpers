#import <Foundation/Foundation.h>

@interface NSNumber (Times)

- (id)timesMake:(id)target perform:(SEL)action;
- (id)timesMake:(id)target perform:(SEL)action withObject:(id)object;

@end
