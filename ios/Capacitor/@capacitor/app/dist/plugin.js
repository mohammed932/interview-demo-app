var capacitorApp = (function (exports, core) {
    'use strict';

    const App = core.registerPlugin('App', {
        web: () => Promise.resolve().then(function () { return web; }).then(m => new m.AppWeb()),
    });

    class AppWeb extends core.WebPlugin {
        constructor() {
            super();
            this.handleVisibilityChange = () => {
                const data = {
                    isActive: document.hidden !== true,
                };
                this.notifyListeners('appStateChange', data);
            };
            document.addEventListener('visibilitychange', this.handleVisibilityChange, false);
        }
        exitApp() {
            throw this.unimplemented('Not implemented on web.');
        }
        async getInfo() {
            throw this.unimplemented('Not implemented on web.');
        }
        async getLaunchUrl() {
            return { url: '' };
        }
        async getState() {
            return { isActive: document.hidden !== true };
        }
        async minimizeApp() {
            throw this.unimplemented('Not implemented on web.');
        }
    }

    var web = /*#__PURE__*/Object.freeze({
        __proto__: null,
        AppWeb: AppWeb
    });

    exports.App = App;

    Object.defineProperty(exports, '__esModule', { value: true });

    return exports;

})({}, capacitorExports);
//# sourceMappingURL=plugin.js.map
