#import "ViewController.h"
#import "GridView.h"
#import "Grid.h"
#import "Cell.h"

static const NSUInteger gridSize = 15;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet GridView* gridView;
@property (nonatomic) Grid* grid;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.grid = [[Grid withSideLength:gridSize]
                 fillWith:[Cell dead]];
    [self.gridView drawGrid:self.grid];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (id<ChangeDelegate>)changeAtRelativeX:(float)x
                        y:(float)y {
    NSInteger cellX = floor(x * gridSize);
    NSInteger cellY = floor(y * gridSize);
    
    self.grid = [self.grid
                 cellAtX:cellX
                 y:cellY
                 switchWith:[[self.grid
                              cellAtX:cellX
                              y:cellY]
                             switchPopulation]];
    
    [self.gridView drawGrid:self.grid];
    return self;
}

- (IBAction)tickAction:(NSButton *)sender {
    self.grid = [self.grid tick];
    [self.gridView drawGrid:self.grid];
}

- (IBAction)cleanAction:(NSButton *)sender {
    self.grid = [self.grid fillWith:[Cell dead]];
    [self.gridView drawGrid:self.grid];
}

@end
