cordova.define("com.t2.platformManagement.PlatformManagement", function(require, exports, module) { 
var exec = require('cordova/exec');

exports.coolMethod = function (arg0, success, error) {
    exec(success, error, 'PlatformManagement', 'coolMethod', [arg0]);
};

exports.exitApp = function (success, error) {
    exec(success, error, 'PlatformManagement', 'exitApp');
};

exports.logout = function (success, error) {
    exec(success, error, 'PlatformManagement', 'logout');
};

exports.showNavigation = function (success, error) {
    exec(success, error, 'PlatformManagement', 'showNavigation');
};

exports.hideNavigation = function (success, error) {
    exec(success, error, 'PlatformManagement', 'hideNavigation');
};
    
exports.trackEvent = function (arg0, arg1, success, error) {
        exec(success, error, 'PlatformManagement', 'trackEvent',[arg0,arg1]);
};
});
