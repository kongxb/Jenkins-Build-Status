##Preview
![bla](http://f.cl.ly/items/33e0c2a7a7b00cc2e0aa/jenkins_status_failed.png)

https://gist.github.com/joepadmiraal/33e0c2a7a7b00cc2e0aa/raw/82a52dce365e9c57a81f81ec294302a33e69e3c8/

## Description

Simple [Dashing](http://shopify.github.com/dashing) widget (and associated job) to display the current build status of a Jenkins server. When all jobs are fine a blue background with a thumbs-up icons is shown. When one or more jobs are in a failed state, they are listed on a red background.

Calls are made to the [Jenkins API](https://wiki.jenkins-ci.org/display/JENKINS/Remote+access+API) to retrieve the build status and culprits if they are available.

Installing the widget
===============
Place the following files in your `widgets/jenkinsbuildstatus` folder:  
  - `jenkinsbuildstatus.coffee`
  - `jenkinsbuildstatus.html`
  - `jenkinsbuildstatus.scss`

Place the following file in your `jobs/` folder:
  - `jenkinsbuildstatus.rb`

## Configuring the widget for use with your Jenkins instance
There are a few parameters that must be set up before using this widget with your Jenkins instance.

In the **jenkinsbuildstatus.rb** file, modify the following parameters according to your needs:

|Parameter|Meaning | 
|:------------- |:------------------|
| `JENKINS_URI` | Jenkins base URL  | 
| `JENKINS_AUTH` | Jenkins user credentials |



## Adding the Jenkins build status widget to your dashboard
To add this widget to your dashboard, add the following to your **[Dashboard-filename].erb** file:
```HTML

    <li data-row="1" data-col="1" data-sizex="2" data-sizey="1">
      <div data-id="jenkinsBuildStatus" data-view="JenkinsBuildStatus" data-title="Jenkins"></div>
    </li>

```