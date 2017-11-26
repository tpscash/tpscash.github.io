title: Build Docker Image with Maven
date: 2017-11-25 23:30:00 +0800
categories:
 - technologies
tags:
 - docker
author: Kevin
---

You can use maven-docker-plugin to create Docker image with artifacts built from your Maven project.

<!-- more -->

## Overview

Docker allows you to treat your infrastructure as code. This code is your Dockerfile. 

Like any code, we want to get into a tight change -> commit -> build -> test cycle (a full continuous integration solution). To archive this, we need to build a smooth CD pipeline.

The steps will be:

* Bitbucket/GitHub notifies TeamCity/Jenkins about each push to the repository
* TeamCity/Jenkins triggers a Maven build
* Maven builds everything including docker images
* Finally the build finishes up by pushing docker images to our private docker registry


## Setup

You can specify the base image, entry point, cmd, maintainer and files you want to add to your image directly in the pom, without needing a separate Dockerfile. If you need VOLUME command(or any other not supported dockerfile command), then you will need to create a Dockerfile and use the dockerDirectory element.

By default the plugin will try to connect to docker on localhost:2375. Set the DOCKER_HOST environment variable to connect elsewhere.

`DOCKER_HOST=tcp://<host>:2375`

Other docker-standard environment variables are honored too such as TLS and certificates.

## Hands on


### Integrate git-commit-id-plugin

We can use this plugin to get git commit id and tag our docker images using the commit id - this is very helpful and allows up to know which version is running

```
<plugin>
    <groupId>pl.project13.maven</groupId>
    <artifactId>git-commit-id-plugin</artifactId>
    <version>2.2.0</version>
    <executions>
        <execution>
            <goals>
                <goal>revision</goal>
            </goals>
        </execution>
    </executions>
    <configuration>
        <dateFormatTimeZone>${user.timezone}</dateFormatTimeZone>
        <verbose>true</verbose>
    </configuration>
</plugin>
```

### Config for Parent POM

Properties:

```
<properties>
    <docker.maven.plugin.version>0.4.13</docker.maven.plugin.version>
    <docker.registry.url>url_of_your_private_registry</<docker.registry.url>
    <docker.registry.repository>your_repo_in_the_private_registry</docker.registry.repository>
    <docker.image.name>${project.artifactId}:${git.commit.id.abbrev}</docker.image.name>
</properties>
```

Plugin Management:

```
<build>
    <pluginManagement>
        <plugins>
            <plugin>
                <groupId>com.spotify</groupId>
                <artifactId>docker-maven-plugin</artifactId>
                <version>${docker.maven.plugin.version}</version>
                <configuration>
                    <serverId>docker-registry</serverId>
                    <registryUrl>${docker.registry.url}</registryUrl>
                    <dockerDirectory>${project.build.outputDirectory}</dockerDirectory>
                    <imageName>${docker.image.name}</imageName>
                    <resources>
                        <resource>
                            <targetPath>/app</targetPath>
                            <directory>${project.build.directory}/app</directory>
                        </resource>
                    </resources>
                </configuration>
                <executions>
                    <execution>
                        <id>build-image</id>
                        <phase>package</phase>
                        <goals>
                            <goal>build</goal>
                        </goals>
                    </execution>
                    <execution>
                        <id>tag-image</id>
                        <phase>package</phase>
                        <goals>
                            <goal>tag</goal>
                        </goals>
                        <configuration>
                            <image>${docker.image.name}</image>
                            <newName>${docker.registry.url}/${docker.registry.repository}/${docker.image.name}</newName>
                        </configuration>
                    </execution>
                    <execution>
                        <id>push-image</id>
                        <phase>install</phase>
                        <goals>
                            <goal>push</goal>
                        </goals>
                        <configuration>
                            <imageName>${docker.registry.url}/${docker.registry.repository}/${docker.image.name}</imageName>
                        </configuration>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </pluginManagement>
</build>
```

What we see here is that we've bound the plugins `build` goal to the Maven package phase. We've instructed it to look for the `Dockerfile` in our modules base directory (using the `dockerDirectory` element), and name the image by property `docker.image.name`. And the image will be pushed to the private registry at the install phase.

### Config in Child POM

```
<build>
	<resources>
		<resource>
			<directory>${project.basedir}</directory>
			<filtering>true</filtering>
			<includes>
				<include>**/Dockerfile</include>
			</includes>
		</resource>
	</resources>
	<plugins>
		<plugin>
			<groupId>com.spotify</groupId>
			<artifactId>docker-maven-plugin</artifactId>
			<version>${docker.maven.plugin.version}</version>
			<configuration>
				<resources>
					<resource>
						<targetPath>/script</targetPath>
						<directory>${project.basedir}/script</directory>
					</resource>
				</resources>
			</configuration>
		</plugin>
	</plugins>
</build>
```

By enabling filtering in Maven's resource, we can gain access to these properties in POM file in the Dockerfile

### A Sample Dockerfile

```
FROM ${docker.registry.url}/${docker.repository}/${docker.base.image.name}:${docker.base.image.tag}

COPY script /opt/myapp/script
COPY app /opt/myapp/app

#ENTRYPOINT ["sh", "-c"]
ENTRYPOINT ["/opt/myapp/script/startService.sh"]

```

## Authentication

Since version 1.0.0, the docker-maven-plugin will automatically use any authentication present in the docker-cli configuration file at `~/.dockercfg` or `~/.docker/config.json`, without the need to configure anything (in earlier versions of the plugin this behavior had to be enabled with `<useConfigFile>true</useConfigFile>`, but now it is always active).

Additionally the plugin will enable support for Google Container Registry if it is able to successfully load [Google's "Application Default Credentials"](https://developers.google.com/identity/protocols/application-default-credentials). The plugin will also load Google credentials from the file pointed to by the environment variable DOCKER_GOOGLE_CREDENTIALS if it is defined. Since GCR authentication requires retrieving short-lived access codes for the given credentials, support for this registry is baked into the underlying docker-client rather than having to first populate the docker config file before running the plugin.

Lastly, authentication credentials can be explicitly configured in your pom.xml and in your Maven installation's `settings.xml` file as part of the `<servers></servers>` block.

```
<servers>
  <server>
    <id>docker-registry</id>
    <username>foo</username>
    <password>secret-password</password>
    <configuration>
      <email>foo@foo.bar</email>
    </configuration>
  </server>
</servers>
```

The plugin gives priority to any credentials in the docker-cli config file before explicitly configured credentials

### Using encrypted passwords for authentication

Credentials can be encrypted using [Maven's built in encryption function](https://maven.apache.org/guides/mini/guide-encryption.html). Only passwords enclosed in curly braces will be considered as encrypted

```
<servers>
  <server>
    <id>docker-registry</id>
    <username>foo</username>
    <password>{gc4QPLrlgPwHZjAhPw8JPuGzaPitzuyjeBojwCz88j4=}</password>
  </server>
</servers>
```

