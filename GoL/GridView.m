#import "GridView.h"
#import "GridVisitors.h"
#import "Grid.h"
#import "Cell.h"

@interface DrawingVisitor : NSObject <GridVisitor>

@property (weak, nonatomic) NSView* view;

@end

@implementation DrawingVisitor

+ (DrawingVisitor*)withView:(NSView*)view
{
  DrawingVisitor* visitor = [DrawingVisitor new];
  visitor.view = view;
  return visitor;
}

- (id<CellInterface>)visitCell:(id<CellInterface>)cell
                          grid:(Grid*)grid
                    sideLength:(NSInteger)sideLength
                             x:(NSInteger)x
                             y:(NSInteger)y
{
  float beginningHorizontal = (float)x/(float)sideLength;
  float beginningVertical = (float)y/(float)sideLength;
  float horizontalExtent = 10.0/(float)sideLength;
  float verticalExtent = 10.0/(float)sideLength;
  NSSize boundsSize = self.view.bounds.size;
  NSRect cellRectangle = NSMakeRect(beginningHorizontal * boundsSize.width,
                                    beginningVertical * boundsSize.height,
                                    horizontalExtent * boundsSize.width,
                                    verticalExtent * boundsSize.height);
  NSBezierPath *path = [NSBezierPath bezierPathWithRect:cellRectangle];
  [[NSColor colorWithCalibratedWhite:[cell populationValue] alpha:1.0] set];
  [path stroke];
  [[NSColor colorWithCalibratedWhite:1.0-[cell populationValue] alpha:1.0] set];
  [path fill];
  return cell;
}

@end

@interface GridView ()

@property (weak, nonatomic) IBOutlet id<ChangeDelegate> changeDelegate;

@property (nonatomic) Grid* currentGrid;

@end

@implementation GridView

- (GridView*)drawGrid:(Grid*)grid
{
  self.currentGrid = grid;
  [self setNeedsDisplay:YES];
  return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
  [super drawRect:dirtyRect];
  [self.currentGrid visit:[DrawingVisitor withView:self]];
}

- (void)mouseUp:(NSEvent*)theEvent
{
  NSPoint location = [self
                      convertPoint:[theEvent locationInWindow]
                      fromView:nil];
  NSSize boundsSize = self.bounds.size;
  float fractionX = location.x/boundsSize.width;
  float fractionY = location.y/boundsSize.height;
  [self.changeDelegate changeAtRelativeX:fractionX y:fractionY];
}

@end
