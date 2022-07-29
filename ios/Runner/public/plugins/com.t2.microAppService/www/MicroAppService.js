cordova.define("com.t2.microAppService.MicroAppService", function(require, exports, module) { 
var exec = require('cordova/exec');

exports.coolMethod = function (arg0, success, error) {
    exec(success, error, 'MicroAppService', 'coolMethod', [arg0]);
};

exports.openOtherMicroApp = function (microAppName, route, data, success, error) {
    exec(success, error, 'MicroAppService', 'openOtherMicroApp', [microAppName, route, data]);
};

exports.CheckFromOtherMicroApp = function (success, error) {
    exec(success, error, 'MicroAppService', 'CheckFromOtherMicroApp');
};
});