/* OutputView */

#import <Cocoa/Cocoa.h>

@interface OutputView : NSTextView
{
    IBOutlet id theController;
}
- (IBAction)calculate:(id)sender;
@end
