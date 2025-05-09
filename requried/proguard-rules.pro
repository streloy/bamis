# Flutter-specific rules
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep Firebase-related classes
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Keep Firebase Messaging classes
-keep class com.google.firebase.messaging.** { *; }
-dontwarn com.google.firebase.messaging.**

# Keep Firebase Analytics classes
-keep class com.google.firebase.analytics.** { *; }
-dontwarn com.google.firebase.analytics.**

# Keep Firebase Core classes
-keep class com.google.firebase.core.** { *; }
-dontwarn com.google.firebase.core.**

# Keep Geolocator classes
-keep class com.baseflow.geolocator.** { *; }
-dontwarn com.baseflow.geolocator.**

# Keep Location plugin classes
-keep class com.lyokone.location.** { *; }
-dontwarn com.lyokone.location.**

# Keep WebView classes
-keep class io.flutter.plugins.webviewflutter.** { *; }
-dontwarn io.flutter.plugins.webviewflutter.**

# Keep shared preferences classes
-keep class io.flutter.plugins.sharedpreferences.** { *; }
-dontwarn io.flutter.plugins.sharedpreferences.**

# Keep flutter toast classes
-keep class com.fluttertoast.** { *; }
-dontwarn com.fluttertoast.**

# Keep image picker classes
-keep class io.flutter.plugins.imagepicker.** { *; }
-dontwarn io.flutter.plugins.imagepicker.**

# Keep flutter native splash classes
-keep class io.flutter.plugins.flutter_native_splash.** { *; }
-dontwarn io.flutter.plugins.flutter_native_splash.**

# Keep flutter typeahead classes
-keep class com.github.rmtmckenzie.** { *; }
-dontwarn com.github.rmtmckenzie.**

# Keep syncfusion pdf viewer classes
-keep class com.syncfusion.** { *; }
-dontwarn com.syncfusion.**

# Keep youtube player classes
-keep class com.pierfrancescosoffritti.** { *; }
-dontwarn com.pierfrancescosoffritti.**

# Keep flutter slidable classes
-keep class io.github.** { *; }
-dontwarn io.github.**

# Keep html editor enhanced classes
-keep class com.squirrels.** { *; }
-dontwarn com.squirrels.**

# Keep file picker classes
-keep class com.github.florent37.** { *; }
-dontwarn com.github.florent37.**

# Keep share plus classes
-keep class com.karumi.** { *; }
-dontwarn com.karumi.**

# Please add these rules to your existing keep rules in order to suppress warnings.
# This is generated automatically by the Android Gradle plugin.
-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task