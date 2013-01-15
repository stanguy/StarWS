#import "Stop.h"

@implementation Stop

// Custom logic goes here.
+ (Stop*) findById:(NSString*)name inContext:(NSManagedObjectContext*)context{
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [Stop entityInManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"src_id = %@", name ];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setFetchLimit:1];
    
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"src_id" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor1, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSArray* result = [context executeFetchRequest:fetchRequest error:&error];
    
    if ( nil == result || 0 == [result count] ) {
        return nil;
    }
    Stop* stop = [result objectAtIndex:0];
    return stop;
}

-(NSString*)description{
    return self.name;
}

@end
