# === Gemalto SDK (gempcsc) ===

# Keep Gemalto Reader classes
-keep class com.gemalto.gempcsc.GemPCSC_Reader { *; }
-keep class com.gemalto.gempcsc.IGemPCSC$Stub { *; }
-keep class com.gemalto.gempcsc.IGemPCSC { *; }

# Prevent warnings for Gemalto SDK
-dontwarn com.gemalto.**

# === SecureMetric SDK (myID.aar) ===

# Keep all classes under this namespace (broad but scoped)
-keep class com.securemetric.reader.myid.** { *; }

# Prevent warnings for SecureMetric SDK
-dontwarn com.securemetric.reader.myid.**

# === AIDL & Android Services (Safe Reflection Usage) ===

# Keep classes that implement Android AIDL (IBinder-based interfaces)
-keep interface **.IGemPCSC
-keep class * implements android.os.IInterface { *; }

# Keep service connection anonymous classes, e.g., onServiceConnected callbacks
-keep class * {
    void onServiceConnected(android.content.ComponentName, android.os.IBinder);
}

# Keep Service classes (often used in SDKs via AndroidManifest)
-keep class * extends android.app.Service { *; }

# === Reflection Support (Safe but not too broad) ===

# Keep public constructors (reflection-safe)
-keepclassmembers class * {
    public <init>(...);
}

# Keep all annotations (used in modern SDKs for runtime reflection)
-keepattributes *Annotation*

# Preserve method/field names used by reflection (minimal)
-keepclassmembers class * {
    @android.annotation.Keep *;
}

# === Native Methods (if JNI is used in .aar) ===

-keepclasseswithmembernames class * {
    native <methods>;
}

# === Optional: Improve Debugging (remove if not needed) ===
-keepattributes SourceFile,LineNumberTable


# === Flutter Play Core / Deferred Components ===
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.splitcompat.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }

# Prevent warnings from Play Core (optional)
-dontwarn com.google.android.play.core.**

# Flutter's deferred component loader
-keep class io.flutter.embedding.engine.deferredcomponents.** { *; }
-keep class io.flutter.embedding.android.FlutterPlayStoreSplitApplication { *; }
