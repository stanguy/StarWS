#import "_Line.h"

@interface Line : _Line {}
// Custom logic goes here.

+ (Line*) findByShortName:(NSString*)name inContext:(NSManagedObjectContext*)context;
+ (Line*) findBySrcId:(NSString*)src_id inContext:(NSManagedObjectContext*)context;

@end
