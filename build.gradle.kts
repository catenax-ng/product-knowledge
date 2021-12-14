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

dependencies {
    implementation(":dataspaceconnector:core:0.0.1-SNAPSHOT")
    implementation(":dataspaceconnector:transfer-process-store-memory:0.0.1-SNAPSHOT")
    implementation(":dataspaceconnector:assetindex-memory:0.0.1-SNAPSHOT")
    implementation(":dataspaceconnector:contractnegotiation-store-memory:0.0.1-SNAPSHOT")
    implementation(":dataspaceconnector:contractdefinition-store-memory:0.0.1-SNAPSHOT")
    implementation(":dataspaceconnector:ids-api-multipart-endpoint-v1:0.0.1-SNAPSHOT")
    //implementation("org.eclipse.dataspaceconnector:iam-mock:0.0.1-SNAPSHOT")
}

application {
    @Suppress("DEPRECATION")
    mainClassName = "org.eclipse.dataspaceconnector.system.runtime.BaseRuntime"
}

tasks.withType<com.github.jengelman.gradle.plugins.shadow.tasks.ShadowJar> {
    exclude("**/pom.properties", "**/pom.xm")
    mergeServiceFiles()
    archiveFileName.set("basic-connector.jar")
}

repositories {
  mavenCentral()
  maven {
        url = uri("https://maven.iais.fraunhofer.de/artifactory/eis-ids-public/")
  }
  mavenLocal()
}