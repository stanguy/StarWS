#import "Line.h"

@implementation Line

// Custom logic goes here.
+ (Line*) findByShortName:(NSString*)name inContext:(NSManagedObjectContext*)context{
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [Line entityInManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"short_name = %@", name ];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setFetchLimit:1];
    
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"old_src_id" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor1, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSString* cacheName = [NSString stringWithFormat:@"old_line_src_%@", name];
    
    NSError *error = nil;
    NSArray* result = [context executeFetchRequest:fetchRequest error:&error];

    if ( nil == result ) {
        return nil;
    }
    Line* line = [result objectAtIndex:0];
    return line;

}

+ (Line*) findBySrcId:(NSString*)src_id inContext:(NSManagedObjectContext*)context{
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [Line entityInManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"src_id = %@", src_id ];
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
    Line* line = [result objectAtIndex:0];
    return line;
    
}

-(NSString*)description{
    return self.short_name;
}

@end
