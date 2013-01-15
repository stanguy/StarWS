//
//  main.m
//  StarWS
//
//  Created by Sebastien Tanguy on 1/13/13.
//  Copyright (c) 2013 Sebastien Tanguy. All rights reserved.
//

#import "Stop.h"
#import "Line.h"

#import "KeolisRennesAPI.h"

static NSManagedObjectModel *managedObjectModel()
{
    static NSManagedObjectModel *model = nil;
    if (model != nil) {
        return model;
    }
    
    NSString *path = [[[NSProcessInfo processInfo] arguments] objectAtIndex:0];
    path = [path stringByDeletingLastPathComponent];
    NSURL *modelURL = [NSURL fileURLWithPath:[path stringByAppendingPathComponent:@"Transit.mom"]];
    model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return model;
}

static NSManagedObjectContext *managedObjectContext()
{
    static NSManagedObjectContext *context = nil;
    if (context != nil) {
        return context;
    }

    @autoreleasepool {
        context = [[NSManagedObjectContext alloc] init];
        
        NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel()];
        [context setPersistentStoreCoordinator:coordinator];
        
        NSString *STORE_TYPE = NSSQLiteStoreType;
        
        NSString *path = [[[NSProcessInfo processInfo] arguments] objectAtIndex:0];
        path = [path stringByDeletingLastPathComponent];
        path = [path stringByAppendingPathComponent:@"Transit.sqlite"];
        NSURL *url = [NSURL fileURLWithPath:path];
        
        NSError *error;
        NSPersistentStore *newStore = [coordinator addPersistentStoreWithType:STORE_TYPE configuration:nil URL:url options:nil error:&error];
        
        if (newStore == nil) {
            NSLog(@"Store Configuration Failure %@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
        }
    }
    return context;
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        // Create the managed object context
        NSManagedObjectContext *context = managedObjectContext();
        
        // Custom code here...
        
        Line* line = nil;
        Stop* stop = nil;
        
        int ch;
        while ( (ch = getopt( argc, argv, "l:s:" )) != -1 ) {
            NSLog( @"yargla" );
            switch ( ch ) {
                case 'l':
                    // find line
                    line = [Line findByShortName:[NSString stringWithCString:optarg encoding:NSUTF8StringEncoding] inContext:context];
                    break;
                case 's':
                    // find stop
                    stop = [Stop findById:[NSString stringWithCString:optarg encoding:NSUTF8StringEncoding] inContext:context];
                    break;
                default:
                    break;
            }
        }
        
        if ( nil == stop ) {
            NSLog( @"We need at least one stop" );
            exit(1);
        }
        
        NSLog( @"calling with line %@ and stop %@", line, stop );
        KeolisRennesAPI* api = [[KeolisRennesAPI alloc] init];
        const char* key = getenv( "KEOLIS_API_KEY" );
        if ( NULL == key ){
            NSLog( @"You need the KEOLIS_API_KEY environment variable" );
            exit( 1 );
        }
        api.key = [NSString stringWithCString:key encoding:NSUTF8StringEncoding];
        [api findNextDepartureAtStop:stop];
        
        
        // Save the managed object context
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Error while saving %@", ([error localizedDescription] != nil) ? [error localizedDescription] : @"Unknown Error");
            exit(1);
        }
    }
    return 0;
}

