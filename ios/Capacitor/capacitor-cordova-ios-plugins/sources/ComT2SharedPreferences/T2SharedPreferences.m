/********* T2SharedPreferences.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@interface T2SharedPreferences : CDVPlugin {
  // Member variables go here.
} 

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
- (void)put:(CDVInvokedUrlCommand*)command;
- (void)getString:(CDVInvokedUrlCommand*)command;   
- (void)getToken:(CDVInvokedUrlCommand*)command;    
- (void)getServerURL:(CDVInvokedUrlCommand*)command;   

@end

@implementation T2SharedPreferences

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


-(void)put:(CDVInvokedUrlCommand*)command{
        CDVPluginResult* pluginResult = nil;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString* key =  [command.arguments objectAtIndex:0];
    NSString* Value =  [command.arguments objectAtIndex:1];
    if (prefs) {
     [prefs setObject:Value forKey:key];
    }
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:key];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

-(void)getString:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* key =  [command.arguments objectAtIndex:0];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *userName = [prefs stringForKey:key];
    
   pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:userName];

   [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


-(void)getToken:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
     NSString* key =  @"Token";
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *userName = [prefs stringForKey:key];
    
   pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:userName];

   [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}



-(void)getServerURL:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* key =  @"ServerURL";
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *userName = [prefs stringForKey:key];
    
   pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:userName];

   [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end


