#import "OutputView.h"

@implementation OutputView

- (IBAction)calculate:(id)sender
{
    //Get the input values from the controller
    NSArray *argFiles = [theController getValuesFromInput];
    //Get the path to the "own" bundles resources.
    NSBundle *thisBundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [thisBundle pathForResource:@"ed2k_hash" ofType:@""];
    
    NSPipe *pipe = [[NSPipe alloc] init];
    NSFileHandle *output = [pipe fileHandleForReading];
    NSTask *ed2k = [[NSTask alloc] init];
    [ed2k setArguments:argFiles];
    [ed2k setLaunchPath:path];
    [ed2k setStandardOutput:pipe];
    [ed2k launch];
    //Detach a new Thread, so that the GUI doesn't freeze up
    [NSThread detachNewThreadSelector:@selector(dontFreezeUI:) toTarget:self withObject:output];
    
    [pipe release];
    [ed2k release];
    
}

- (void) dontFreezeUI:(NSFileHandle*)read
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSString *message;
    message = [[NSString alloc] initWithData:[read readDataToEndOfFile] encoding:NSASCIIStringEncoding];
    [theController updateWithString:message];
    
    [message release];
    [pool release];
}

@end
