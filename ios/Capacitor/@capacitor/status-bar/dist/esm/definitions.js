export var Style;
(function (Style) {
    /**
     * Light text for dark backgrounds.
     *
     * @since 1.0.0
     */
    Style["Dark"] = "DARK";
    /**
     * Dark text for light backgrounds.
     *
     * @since 1.0.0
     */
    Style["Light"] = "LIGHT";
    /**
     * On iOS 13 and newer the style is based on the device appearance.
     * If the device is using Dark mode, the statusbar text will be light.
     * If the device is using Light mode, the statusbar text will be dark.
     * On iOS 12 and older the statusbar text will be dark.
     * On Android the default will be the one the app was launched with.
     *
     * @since 1.0.0
     */
    Style["Default"] = "DEFAULT";
})(Style || (Style = {}));
export var Animation;
(function (Animation) {
    /**
     * No animation during show/hide.
     *
     * @since 1.0.0
     */
    Animation["None"] = "NONE";
    /**
     * Slide animation during show/hide.
     *
     * @since 1.0.0
     */
    Animation["Slide"] = "SLIDE";
    /**
     * Fade animation during show/hide.
     *
     * @since 1.0.0
     */
    Animation["Fade"] = "FADE";
})(Animation || (Animation = {}));
/**
 * @deprecated Use `Animation`.
 * @since 1.0.0
 */
export const StatusBarAnimation = Animation;
/**
 * @deprecated Use `Style`.
 * @since 1.0.0
 */
export const StatusBarStyle = Style;
//# sourceMappingURL=definitions.js.map