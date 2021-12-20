/*
 *  Copyright (c) 2021 T-Systems International GmbH
 *
 *  This program and the accompanying materials are made available under the
 *  terms of the Apache License, Version 2.0 which is available at
 *  https://www.apache.org/licenses/LICENSE-2.0
 *
 *  SPDX-License-Identifier: Apache-2.0
 *
 *  Contributors:
 *       T-Systems International GmbH - Spike Lead
 *
 */

plugins {
    `java-library`
    id("application")
    id("com.github.johnrengelman.shadow") version "7.0.0"
}

val jerseyVersion: String by project
val rsApi: String by project
val okHttpVersion: String by project
val javaVersion: String by project

java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(javaVersion))
    }
}

dependencies {
    implementation("org.eclipse.dataspaceconnector:core:0.0.1-SNAPSHOT")
    implementation("org.eclipse.dataspaceconnector:assetindex-memory:0.0.1-SNAPSHOT")
    implementation("org.eclipse.dataspaceconnector:transfer-process-store-memory:0.0.1-SNAPSHOT")
    implementation("org.eclipse.dataspaceconnector:policy-registry-memory:0.0.1-SNAPSHOT")
    implementation("org.eclipse.dataspaceconnector:contractnegotiation-store-memory:0.0.1-SNAPSHOT")
    implementation("org.eclipse.dataspaceconnector:contractdefinition-store-memory:0.0.1-SNAPSHOT")
    implementation("org.eclipse.dataspaceconnector:iam-mock:0.0.1-SNAPSHOT")
    implementation("org.eclipse.dataspaceconnector:ids:0.0.1-SNAPSHOT")
    implementation("org.eclipse.dataspaceconnector:filesystem-configuration:0.0.1-SNAPSHOT")

    implementation("org.glassfish.jersey.media:jersey-media-multipart:${jerseyVersion}")
    implementation("jakarta.ws.rs:jakarta.ws.rs-api:${rsApi}")
    implementation("com.squareup.okhttp3:okhttp:${okHttpVersion}")
}

application {
    @Suppress("DEPRECATION")
    mainClassName = "org.eclipse.dataspaceconnector.system.runtime.BaseRuntime"
}

tasks.withType<com.github.jengelman.gradle.plugins.shadow.tasks.ShadowJar> {
    exclude("**/pom.properties", "**/pom.xm")
    mergeServiceFiles()
    archiveFileName.set("sparql-federation.jar")
}

repositories {
  mavenCentral()
  maven {
        url = uri("https://maven.iais.fraunhofer.de/artifactory/eis-ids-public/")
  }
  mavenLocal()
}