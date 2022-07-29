cordova.define("com-t2-SharedPreferences.T2SharedPreferences", function(require, exports, module) { 
var exec = require('cordova/exec');

exports.coolMethod = function (arg0, success, error) {
    exec(success, error, 'T2SharedPreferences', 'coolMethod', [arg0]);
};

exports.put = function (key, value, success, error) {
    exec(success, error, 'T2SharedPreferences', 'put', [key, value]);
};

exports.getString = function (arg0, success, error) {
    exec(success, error, 'T2SharedPreferences', 'getString', [arg0]);
};

exports.getToken = function (success, error) {
    exec(success, error, 'T2SharedPreferences', 'getToken');
};

exports.getServerURL = function (success, error) {
    exec(success, error, 'T2SharedPreferences', 'getServerURL');
};


//ServerURL
});