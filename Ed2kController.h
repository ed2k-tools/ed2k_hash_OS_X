/* Ed2kController */

#import <Cocoa/Cocoa.h>

@interface Ed2kController : NSObject
{
    IBOutlet NSButton *button;
    IBOutlet NSTableView *inputValuesView;
    IBOutlet NSTextField *message;
    IBOutlet NSTextView *outputValuesView;
    NSMutableArray *files;
    NSString *forOutput;
}

- (NSMutableArray *)getValuesFromInput;
- (void)updateWithString:(NSString *)aString;
//- (void)addElem(NSDocument*)aDoc;

@end
