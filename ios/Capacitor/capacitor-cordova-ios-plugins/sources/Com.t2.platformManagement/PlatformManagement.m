/********* PlatformManagement.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@interface PlatformManagement : CDVPlugin {
    // Member variables go here.
}

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
- (void)exitApp:(CDVInvokedUrlCommand*)command;

@end

@implementation PlatformManagement

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];
    
    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void)exitApp:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"OK"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:
     @"NotificationIdentifier" object:nil userInfo:nil];
}


-(void)logout:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"OK"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:
     @"logoutEvent" object:nil userInfo:nil];
}



-(void)showNavigation:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"OK"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:
     @"showNavigation" object:nil userInfo:nil];
}


-(void)hideNavigation:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"OK"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:
     @"hideNavigation" object:nil userInfo:nil];
}

- (void)trackEvent:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    
    NSString* name = [command.arguments objectAtIndex:0][@"name"];
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:name,@"name", nil];
    [userInfo setObject:name forKey:@"name"];
    
    NSObject* allKey = [command.arguments objectAtIndex:1];
    if (allKey != nil && allKey != [NSNull null]){
        NSArray* keys = [[command.arguments objectAtIndex:1] allKeys];
        [userInfo setObject:allKey forKey:@"data"];
        [userInfo setObject:keys forKey:@"keys"];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:
     @"TrackEvent" object:nil userInfo:userInfo];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"true"];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
