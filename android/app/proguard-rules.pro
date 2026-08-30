# Flutter ProGuard Rules for Size Optimization
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Google Play Core & Deferred Components
-dontwarn com.google.android.play.core.**

# Flutter TTS
-dontwarn com.tundralabs.fluttertts.**
-keep class com.tundralabs.fluttertts.** { *; }

# Audio & Hardware
-dontwarn com.ryanheise.just_audio.**
-keep class com.ryanheise.just_audio.** { *; }
-dontwarn com.benjaminabel.vibration.**
-keep class com.benjaminabel.vibration.** { *; }
