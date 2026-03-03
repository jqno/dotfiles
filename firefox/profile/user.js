// *** UI & UX ***

// Block AI features
user_pref("browser.ai.control.default", "blocked");

// Don't offer to remember passwords
user_pref("signon.rememberSignons", false);

// Restore tabs from previous session
user_pref("browser.startup.page", 3);

// Don't show bookmark bars
user_pref("browser.toolbars.bookmarks.visibility", "never");

// Show vertical tabs
user_pref("sidebar.revamp", true);
user_pref("sidebar.verticalTabs", true);
user_pref("sidebar.verticalTabs.dragToPinPromo.dismissed", true);
user_pref("sidebar.visibility", "always-show");

// Don't show too many tool icons in the sidebar
user_pref("sidebar.main.tools", "history,bookmarks");

// Don't close the browser after closing the last tab
user_pref("browser.tabs.closeWindowWithLastTab", false);

// Don't autoplay videos
user_pref("media.autoplay.default", 5);

// Don't ask for translations
user_pref("browser.translations.automaticallyPopup", false);




// *** security & privacy ***

// HTTPS Only mode
user_pref("dom.security.https_only_mode", true);

// Disable telemetry
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);

// Disable studies and experiments
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);

// Total cookie protection
user_pref("network.cookie.cookieBehavior", 5);

// Tracking protection
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);
user_pref("privacy.trackingprotection.cryptomining.enabled", true); // [DEFAULT: true]
user_pref("privacy.trackingprotection.fingerprinting.enabled", true); // [DEFAULT: true]

// DNS over HTTPS
user_pref("network.trr.mode", 2);

// Disable prefetching (sends requests you haven't made)
user_pref("network.prefetch-next", false);
user_pref("network.dns.disablePrefetch", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true);
user_pref("network.predictor.enabled", false);
user_pref("browser.urlbar.speculativeConnect.enabled", false);

// Disable live search suggestions
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.suggest.searches", false);

// Reduce tracking with a more strict referrer policy
user_pref("network.http.referer.XOriginPolicy", 2);
user_pref("network.http.referer.XOriginTrimmingPolicy", 2);
