# Flutter & Engine Rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Google Play Core & Deferred Components
-dontwarn com.google.android.play.core.**
-dontwarn io.flutter.embedding.android.FlutterPlayStoreSplitApplication
-dontwarn io.flutter.embedding.engine.deferredcomponents.**

# Flutter TTS
-dontwarn com.tundralabs.fluttertts.**
-keep class com.tundralabs.fluttertts.** { *; }

# Audio & Hardware
-dontwarn com.ryanheise.just_audio.**
-keep class com.ryanheise.just_audio.** { *; }
-dontwarn com.benjaminabel.vibration.**
-keep class com.benjaminabel.vibration.** { *; }

# Don't warn for missing optional dependencies
-dontwarn **
