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

import com.github.jengelman.gradle.plugins.shadow.transformers.ServiceFileTransformer
import com.github.jengelman.gradle.plugins.shadow.transformers.Transformer
import com.github.jengelman.gradle.plugins.shadow.transformers.TransformerContext
import shadow.org.apache.tools.zip.ZipFile
import java.util.regex.Pattern

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

/**
 * A transformer for the
 * shadowing task which may (finally) filter
 * all artifacts (service descriptions, manifests, ...)
 * depending on the hosting container (jar)
 */
class JarMatchingServiceFileTransformer(
    @org.gradle.api.tasks.Internal
    var excludeJars: Pattern,
    @org.gradle.api.tasks.Internal
    var delegate: Transformer
    ) : Transformer {

    // we need some reflection to the
    // shadowed apache ant zip tools
    // to get the reference to the zipfile (jar)
    // back from the given inputstream
    @Internal
    var zipFileClass = Class.forName("shadow.org.apache.tools.zip.ZipFile$1")
    @Internal
    var zipFileField = zipFileClass.getDeclaredField("this$0")
    init {
        zipFileField.setAccessible(true)
    }

    // some decoration
    override fun getName(): String {
        return String.format("JarMatchingFileTransformer(%s,%s)",excludeJars.pattern(),delegate.getName());
    }

    // pure delegation, we have no hint to the (jar) container at this point, unfortunately
    override fun canTransformResource(element: FileTreeElement?): Boolean {
        return delegate.canTransformResource(element)
    }

    // pure delegation
    override fun hasTransformedResource(): Boolean {
        return delegate.hasTransformedResource()
    }

    // pure delegation
    override fun modifyOutputStream(zos: shadow.org.apache.tools.zip.ZipOutputStream?, flag: Boolean) {
        return delegate.modifyOutputStream(zos,flag)
    }

    // now, here we are. the context has enough information to find out
    // whether the container is a jar and we can simply "mute" the call
    override fun transform(context: TransformerContext?) {
        var stream = context?.getIs()
        if(zipFileClass.isInstance(stream)) {
            var zipFile = zipFileField.get(stream) as shadow.org.apache.tools.zip.ZipFile
            if(excludeJars.matcher(zipFile.name).matches()) {
                return;
            }
        }
        return delegate.transform(context)
    }
}

tasks.withType<com.github.jengelman.gradle.plugins.shadow.tasks.ShadowJar> {
    exclude("**/pom.properties", "**/pom.xm")
    // since we override the ids artifactrequestcontroller with our own version
    // we filter that particular service extension
    transform( JarMatchingServiceFileTransformer(Pattern.compile(".*ids-api-transfer-0.0.1-SNAPSHOT.jar"),ServiceFileTransformer()))
    archiveFileName.set("sparql-federation.jar")
}

repositories {
  mavenCentral()
  maven {
        url = uri("https://maven.iais.fraunhofer.de/artifactory/eis-ids-public/")
  }
  mavenLocal()
}
