import org.jetbrains.compose.desktop.application.dsl.TargetFormat
import org.jetbrains.kotlin.gradle.ExperimentalKotlinGradlePluginApi
import org.jetbrains.kotlin.gradle.dsl.JvmTarget

plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.androidApplication)
    alias(libs.plugins.composeMultiplatform)
    alias(libs.plugins.composeCompiler)
    kotlin("plugin.serialization") version "2.0.0"
}

kotlin {
    androidTarget {
        @OptIn(ExperimentalKotlinGradlePluginApi::class)
        compilerOptions {
            jvmTarget.set(JvmTarget.JVM_11)
        }
    }
    
    listOf(
        iosX64(),
        iosArm64(),
        iosSimulatorArm64()
    ).forEach { iosTarget ->
        iosTarget.binaries.framework {
            baseName = "ComposeApp"
            isStatic = true
            export("io.github.mirzemehdi:kmpnotifier:1.3.0")
        }
    }
    
    sourceSets {
        
        androidMain.dependencies {
            implementation(compose.preview)
            implementation(libs.androidx.activity.compose)

            //data-store
            implementation(libs.androidx.datastore.preferences)
            implementation(libs.androidx.datastore.core)
        }
        commonMain.dependencies {
            implementation(compose.runtime)
            implementation(compose.foundation)
            implementation(compose.material)
            implementation(compose.ui)
            implementation(compose.components.resources)
            implementation(compose.components.uiToolingPreview)
            implementation(libs.androidx.lifecycle.viewmodel)
            implementation(libs.androidx.lifecycle.runtime.compose)

            implementation(libs.voyager.navigator)
            implementation(libs.voyager.screenModel)
            implementation(libs.voyager.bottomSheetNavigator)
            implementation(libs.voyager.tabNavigator)
            implementation(libs.voyager.transitions)
            implementation(libs.voyager.koin)
            implementation(libs.ktor.client.core)
            implementation(libs.kotlinx.coroutines.core)
            implementation(libs.ktor.client.websockets)
            implementation(libs.ktor.serialization.kotlinx.json)
            implementation(libs.sqldelight.coroutines.extensions)
            implementation(libs.kamel.image)
            implementation(libs.landscapist.coil3)
            implementation(libs.sandwich.ktor)
            implementation(libs.sketch.compose)

            implementation("com.github.skydoves:sandwich-ktorfit:2.0.8")
            implementation("io.ktor:ktor-client-content-negotiation:2.0.0")
            implementation("io.ktor:ktor-client-logging:2.0.0")
            //https://github.com/russhwolf/multiplatform-settings
            implementation("com.russhwolf:multiplatform-settings:1.2.0")

            //notify -> https://github.com/mirzemehdi/KMPNotifier
            api("io.github.mirzemehdi:kmpnotifier:1.3.0")
        }

        iosMain.dependencies {
            implementation(libs.ktor.client.darwin)
            implementation(libs.native.driver)
        }
    }
}

android {
    namespace = "com.chaaraapp.henna"
    compileSdk = libs.versions.android.compileSdk.get().toInt()

    defaultConfig {
        applicationId = "com.chaaraapp.henna"
        minSdk = libs.versions.android.minSdk.get().toInt()
        targetSdk = libs.versions.android.targetSdk.get().toInt()
        versionCode = 1
        versionName = "1.0"
    }
    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
    }
    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
}

dependencies {
    debugImplementation(compose.uiTooling)
}

