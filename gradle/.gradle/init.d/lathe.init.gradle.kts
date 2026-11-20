initscript {
    repositories { gradlePluginPortal() }
    dependencies { classpath("io.github.ag-libs:lathe-gradle-plugin:0.3.1") }
}

settingsEvaluated {
    if (!pluginManager.hasPlugin("io.github.ag-libs.lathe")) {
        pluginManager.apply(io.github.aglibs.lathe.gradle.LatheSettingsPlugin::class.java)
    }
}
