## Prerequisite
 - JDK 8
 - virtual box (optional)
 - Docker (Install docker on your machine. [Community version](https://docs.docker.com/install/) is fine)
 - Mac users [sdkman](https://sdkman.io/sdks) helps to manage versions of required sdk quite nicely (on top of `brew` of course). 
 
 ## Maven 
 - Create a [Github personal access token](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token) and add to your ~/.m2/settings.xml file 
  
 ```
   <servers>
      <server>
          <id>github-fms-lib</id>
          <username>mikebarnes-farmiq</username>
          <password>${personal_access_token}</password>
      </server>
   </servers>
 ```

## SQL Server
The app needs a particularly configured SQL server. You can get this from AWS.
* Generate yourself an AWS access token in the AWS IAM service
* run `aws configure` (you'll need to get the AWS CLI to do this - `brew install awscli` or something different)
* get Docker to log in to our AWS docker service: `aws ecr get-login-password --region ap-southeast-2 | docker login --username AWS --password-stdin 021624021317.dkr.ecr.ap-southeast-2.amazonaws.com`
* pull and run the server: `docker run -p 1433:1433 --name sqlserver 021624021317.dkr.ecr.ap-southeast-2.amazonaws.com/sqlserver:synlait`
* This will give you a running docker container with these credentials:
  * global user: `admin`, `password`
  * Company User: `admin-synlait`, `password`
  
## Tomcat
- [Download](https://apache.inspire.net.nz/tomcat/tomcat-8/v8.5.68/bin/apache-tomcat-8.5.68.tar.gz) and [install](https://codingexplained.com/dev-ops/mac/installing-tomcat-8-os-x-yosemite) Tomcat 8.

## IntelliJ IDEA

- [Download](https://www.jetbrains.com/idea/download)

## Run

- ```mvn install```
- Add Local Tomcat run configuration to Intellij IDEA:
  - Click store as project file, Done, and OK. 
  - ![store_as_project_file](images/store_as_project_file.png?raw=true "store_as_project_file")
  - Open the newly created file in .run, and replace with the following XML: (Unfortunately you can import a run config in IntelliJ but this is a workaround)
```
  <component name="ProjectRunConfigurationManager">
  <configuration default="false" name="tomcat" type="#com.intellij.j2ee.web.tomcat.TomcatRunConfigurationFactory" factoryName="Local" APPLICATION_SERVER_NAME="Tomcat 8.5.68" ALTERNATIVE_JRE_ENABLED="true" ALTERNATIVE_JRE_PATH="/${path_to_java_home}">
    <option name="OPEN_IN_BROWSER_URL" value="http://localhost:8080/farmiq" />
    <option name="COMMON_VM_ARGUMENTS" value="-Dorg.apache.activemq.SERIALIZABLE_PACKAGES=* -Xmx8g -XX:MaxPermSize=256m -Dspring.profiles.active=dev" />
    <option name="UPDATING_POLICY" value="restart-server" />
    <deployment>
      <artifact name="farmiq-with-crv:war exploded">
        <settings>
          <option name="CONTEXT_PATH" value="/farmiq" />
        </settings>
      </artifact>
    </deployment>
    <server-settings>
      <option name="BASE_DIRECTORY_NAME" value="596d16ee-b936-446b-a717-11f9f001232c" />
    </server-settings>
    <predefined_log_file enabled="true" id="Tomcat" />
    <predefined_log_file enabled="true" id="Tomcat Catalina" />
    <predefined_log_file id="Tomcat Manager" />
    <predefined_log_file id="Tomcat Host Manager" />
    <predefined_log_file id="Tomcat Localhost Access" />
    <RunnerSettings RunnerId="Debug">
      <option name="DEBUG_PORT" value="50136" />
    </RunnerSettings>
    <ConfigurationWrapper VM_VAR="JAVA_OPTS" RunnerId="Cover">
      <option name="USE_ENV_VARIABLES" value="true" />
      <STARTUP>
        <option name="USE_DEFAULT" value="true" />
        <option name="SCRIPT" value="" />
        <option name="VM_PARAMETERS" value="" />
        <option name="PROGRAM_PARAMETERS" value="" />
      </STARTUP>
      <SHUTDOWN>
        <option name="USE_DEFAULT" value="true" />
        <option name="SCRIPT" value="" />
        <option name="VM_PARAMETERS" value="" />
        <option name="PROGRAM_PARAMETERS" value="" />
      </SHUTDOWN>
    </ConfigurationWrapper>
    <ConfigurationWrapper VM_VAR="JAVA_OPTS" RunnerId="Debug">
      <option name="USE_ENV_VARIABLES" value="true" />
      <STARTUP>
        <option name="USE_DEFAULT" value="true" />
        <option name="SCRIPT" value="" />
        <option name="VM_PARAMETERS" value="" />
        <option name="PROGRAM_PARAMETERS" value="" />
      </STARTUP>
      <SHUTDOWN>
        <option name="USE_DEFAULT" value="true" />
        <option name="SCRIPT" value="" />
        <option name="VM_PARAMETERS" value="" />
        <option name="PROGRAM_PARAMETERS" value="" />
      </SHUTDOWN>
    </ConfigurationWrapper>
    <ConfigurationWrapper VM_VAR="JAVA_OPTS" RunnerId="Profile">
      <option name="USE_ENV_VARIABLES" value="true" />
      <STARTUP>
        <option name="USE_DEFAULT" value="true" />
        <option name="SCRIPT" value="" />
        <option name="VM_PARAMETERS" value="" />
        <option name="PROGRAM_PARAMETERS" value="" />
      </STARTUP>
      <SHUTDOWN>
        <option name="USE_DEFAULT" value="true" />
        <option name="SCRIPT" value="" />
        <option name="VM_PARAMETERS" value="" />
        <option name="PROGRAM_PARAMETERS" value="" />
      </SHUTDOWN>
    </ConfigurationWrapper>
    <ConfigurationWrapper VM_VAR="JAVA_OPTS" RunnerId="Run">
      <option name="USE_ENV_VARIABLES" value="true" />
      <STARTUP>
        <option name="USE_DEFAULT" value="true" />
        <option name="SCRIPT" value="" />
        <option name="VM_PARAMETERS" value="" />
        <option name="PROGRAM_PARAMETERS" value="" />
      </STARTUP>
      <SHUTDOWN>
        <option name="USE_DEFAULT" value="true" />
        <option name="SCRIPT" value="" />
        <option name="VM_PARAMETERS" value="" />
        <option name="PROGRAM_PARAMETERS" value="" />
      </SHUTDOWN>
    </ConfigurationWrapper>
    <method v="2">
      <option name="BuildArtifacts" enabled="true">
        <artifact name="farmiq-with-crv:war exploded" />
      </option>
    </method>
  </configuration>
</component>
```
- Make sure you update ${path_to_java_home}. Once you save it the run config will be updated.
- If there are any issues, check the Tomcat config is pointing to the Tomcat installation.



  
