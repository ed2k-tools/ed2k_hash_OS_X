#import "Ed2kController.h"

@implementation Ed2kController

//Initialize
- (void)awakeFromNib
{
    [button setEnabled:NO];
    [inputValuesView registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
    files = [[NSMutableArray alloc] init];
}

//for the tableview datasource
- (int)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [files count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(int)row
{
    return [files objectAtIndex:row];
}
//end datasource

//for drag and drop
- (NSDragOperation)tableView:(NSTableView*)tv validateDrop:(id <NSDraggingInfo>)info proposedRow:(int)row proposedDropOperation:(NSTableViewDropOperation)op
{
    [tv setDropRow:[tv numberOfRows] dropOperation:NSTableViewDropAbove];
    return NSTableViewDropAbove;
}

- (BOOL)tableView:(NSTableView*)tv acceptDrop:(id <NSDraggingInfo>)info row:(int)row dropOperation:(NSTableViewDropOperation)op
{
    NSPasteboard *myPboard = [info draggingPasteboard];
    NSArray *wantedTypes = [NSArray arrayWithObjects:NSFilenamesPboardType,nil];
    NSString *availableType, *path;
    NSArray *fileArray;
    int i;
    
    availableType = [myPboard availableTypeFromArray:wantedTypes];
    fileArray = [myPboard propertyListForType:availableType];
    
    for(i = 0; i < [fileArray count]; i++)
    {
        path = [fileArray objectAtIndex:i];
        [files insertObject:path atIndex:row+i];
    }
    
    [inputValuesView reloadData];
    [button setEnabled:YES];
    return YES;
    
}
//end drag and drop
- (NSMutableArray *)getValuesFromInput
{
    NSMutableArray *filesCopy = [NSMutableArray arrayWithArray:files];
    [button setEnabled:NO];
    [files removeAllObjects];
    [inputValuesView reloadData];
    [inputValuesView unregisterDraggedTypes];
    [message setStringValue:@"Working..."];
    return filesCopy;
}

- (void)updateWithString:(NSString *)aString
{
    [outputValuesView setString:aString];
    [inputValuesView registerForDraggedTypes:[NSArray arrayWithObjects:NSFilenamesPboardType, nil]];
    [message setStringValue:@"Idle"];
}

@end
