import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

val environmentSigningValues = listOf(
    "ANDROID_KEYSTORE_PATH",
    "ANDROID_KEYSTORE_ALIAS",
    "ANDROID_KEYSTORE_PRIVATE_KEY_PASSWORD",
    "ANDROID_KEYSTORE_PASSWORD",
).associateWith(System::getenv)
val hasEnvironmentReleaseSigning = environmentSigningValues.values.all {
    !it.isNullOrBlank()
}

val localSigningKeys = listOf(
    "storeFile",
    "keyAlias",
    "keyPassword",
    "storePassword",
)
val hasLocalReleaseSigning = localSigningKeys.all {
    !keystoreProperties.getProperty(it).isNullOrBlank()
}

// An assessment/reviewer build can retain release-mode optimizations without
// distributing a production keystore. This flag must be deliberate.
val useDebugReleaseSigning = System.getenv("ALLOW_DEBUG_RELEASE_SIGNING")
    ?.equals("true", ignoreCase = true) == true

android {
    namespace = "com.rahatiqbal.medbook"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.rahatiqbal.medbook"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            when {
                hasEnvironmentReleaseSigning -> {
                    storeFile = file(environmentSigningValues.getValue("ANDROID_KEYSTORE_PATH"))
                    keyAlias = environmentSigningValues.getValue("ANDROID_KEYSTORE_ALIAS")
                    keyPassword = environmentSigningValues.getValue(
                        "ANDROID_KEYSTORE_PRIVATE_KEY_PASSWORD",
                    )
                    storePassword = environmentSigningValues.getValue("ANDROID_KEYSTORE_PASSWORD")
                }
                hasLocalReleaseSigning -> {
                    keyAlias = keystoreProperties.getProperty("keyAlias")
                    keyPassword = keystoreProperties.getProperty("keyPassword")
                    storeFile = file(keystoreProperties.getProperty("storeFile"))
                    storePassword = keystoreProperties.getProperty("storePassword")
                }
            }
        }
    }

    flavorDimensions += "default"
    productFlavors {
        create("production") {
            dimension = "default"
            applicationIdSuffix = ""
            manifestPlaceholders["appName"] = "Medbook"
        }
        create("staging") {
            dimension = "default"
            applicationIdSuffix = ".stg"
            manifestPlaceholders["appName"] = "[STG] Medbook"
        }
        create("development") {
            dimension = "default"
            applicationIdSuffix = ".dev"
            manifestPlaceholders["appName"] = "[DEV] Medbook"
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = when {
                hasEnvironmentReleaseSigning || hasLocalReleaseSigning -> {
                    signingConfigs.getByName("release")
                }
                useDebugReleaseSigning -> signingConfigs.getByName("debug")
                // Leave release signing incomplete so debug/profile variants can run.
                // An unsigned release task then fails in the Android build with its
                // standard missing-signing-configuration error.
                else -> signingConfigs.getByName("release")
            }
            isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android.txt"),
                "proguard-rules.pro"
            )
        }
        getByName("debug") {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib:2.2.10")
}
