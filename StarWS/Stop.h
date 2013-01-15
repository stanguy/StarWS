#import "_Stop.h"

@interface Stop : _Stop {}
// Custom logic goes here.

+ (Stop*) findById:(NSString*)strId  inContext:(NSManagedObjectContext*)context;
@end
