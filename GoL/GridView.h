#import <Cocoa/Cocoa.h>

@class Grid;
@protocol ChangeDelegate;

@interface GridView : NSView

- (GridView*)drawGrid:(Grid*)grid;

@end

@protocol ChangeDelegate <NSObject>

- (id<ChangeDelegate>)changeAtRelativeX:(float)x
                                      y:(float)y;

@end
