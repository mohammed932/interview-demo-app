/********* MicroAppService.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>



@interface MicroAppService : CDVPlugin {
  NSString*  microAppData ;
  NSString*  route ;
  NSString* discoverPeripheralCallbackId;
}

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
- (void)openOtherMicroApp:(CDVInvokedUrlCommand*)command;
- (void)CheckFromOtherMicroApp:(CDVInvokedUrlCommand*)command;
- (void)sendCallback;

@end


@implementation MicroAppService


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



- (void)openOtherMicroApp:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;

    NSString* microAppName = [command.arguments objectAtIndex:0];
    if (microAppName != nil && [microAppName length] > 0) {
      route =  [command.arguments objectAtIndex:1];
      microAppData = [command.arguments objectAtIndex:2];
        
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:microAppName,@"microAppName", nil];
        [userInfo setObject:microAppName forKey:@"microAppName"];
        [userInfo setObject:route forKey:@"Route"];
        
        
//        NSDictionary *userInfo =
//        [NSDictionary dictionaryWithObject:microAppName forKey:@"microAppName"];
//        [NSDictionary dictionaryWithObject:route forKey:@"route"];
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:
                               @"routeNotification" object:nil userInfo:userInfo];

      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:microAppName];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}



- (void)CheckFromOtherMicroApp:(CDVInvokedUrlCommand*)command
{
    discoverPeripheralCallbackId = [command.callbackId copy];
    self.sendCallbac;
}


-(void)sendCallbac{
     CDVPluginResult* pluginResult = nil;
     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
     route = [prefs stringForKey:@"MicroAppName"];
    if (route != nil && [route length] > 0) {
        NSMutableDictionary *jsonData = [[NSMutableDictionary alloc]init];

        @try {
          if (microAppData != nil)
           [jsonData setObject:microAppData forKey:@"Data"];
           [jsonData setObject:route forKey:@"Route"];
         }
         @catch (NSException *exception) {
             NSLog(@"CheckFromOtherMicroApp error ", exception.reason);
         }
        
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:jsonData]; 
        [pluginResult setKeepCallbackAsBool:TRUE];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:discoverPeripheralCallbackId];

        microAppData = nil;
        route = nil;


    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

}


@end
