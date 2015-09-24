
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HOAbstract : NSObject

@property (nonatomic, readonly) id object;

+ (id)withObject:(id)object;

@end

NS_ASSUME_NONNULL_END