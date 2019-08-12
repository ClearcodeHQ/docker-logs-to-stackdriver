# Centralized Logging with Stackdriver
Stackdriver logs are not only for Google Cloud Platform. You can drop your logs into Stackdriver from anywhere and this docker-compose will help you to achieve that.

## What is the Centralized Logging?
Main idea of Centralized Logging is collecting all logs' data across a system into one storage. By parsing, filtering and searching logs you will be able to monitor health of the system from one place. By having all the logs in one place, you gain comprehensive source of truth about your system. Based on it you can search for patterns, dig for information and prepare system reports which can be later utilized in process of decision making. If you are not convinced, please [check this reddit thread for some inspiration](https://www.reddit.com/r/aws/comments/a754le/what_is_centralized_logging_and_why_should_we_use/).

## Why Stackdriver?
Centralized Logging can be provisioned On Premises, mostly by utilizing [ELK stack](https://www.elastic.co/what-is/elk-stack) or emerging [Kubernates Logging](https://kubernetes.io/docs/concepts/cluster-administration/logging/#cluster-level-logging-architectures). Maintaing own logging stack come with performance and costs issues. The most popular mitigation of those isssues is done by reducing logs' data retention. 

On the other hand Centralized Logging as a Service like [Sentry](https://sentry.io/welcome/) or [Papertrail](https://papertrailapp.com/) can also be costly. How much? It depends how much data you will push and again what data retention should be granted.

Knowing above, Stackdriver Logging comes into the game. It's pricing plan guarantee [**first 50 GiB free allotment per month per project**](https://cloud.google.com/stackdriver/pricing) and [**30 days retention period**](https://cloud.google.com/logging/quotas) (last checked at August 12th, 2019).

50 GiB per month? Is it much? Again it depends, nowadays we are working in a project which generates at least 5 GiB logs per day. But lets face it, your project really need to explode to reach this amounts.

Pricing in Stackdriver starts when you would like to automate monitoring based on collected logs. Just logs almost comes for free.

## Requirements
Discalaimar: This package is for educational purpose, it is not production ready solution. To run it locally you will need to install:
- Docker 18.06.0+

## Installation

1. Clone this repo
1. Register in GCP and create a new project
1. [Generate Service Account Key](https://cloud.google.com/logging/docs/agent/authorization#create-service-account) and place it into `./config/service-key.json` 
1. In [docker-compose.yml](./docker-compose.yml) file set environment variables `STACKDRIVER_VM_ID` and `STACKDRIVER_ZONE_ID` accordingly to your needs
1. Start Docker Compose `$ docker-compose up`
1. Enter `http://0.0.0.0:8080` to open default Nginx page
1. Open your project in GCP and navigate to Logging tab
1. From `resources` dropdown choose `GCE VM Instance`
1. Your Nginx's logs should appear

## Used technologies
It is always cool to read about parts which were used to build a solution, this is a reference:
- [Docker](https://www.docker.com/)
  - [Docker Compose](https://docs.docker.com/compose/)
  - [Docker Secrets](https://docs.docker.com/engine/swarm/secrets/)
  - [Docker Environment Variables](https://docs.docker.com/compose/environment-variables/)
  - [Fluentd's Docker logging driver](https://docs.docker.com/config/containers/logging/fluentd/)
- [Fluentd](https://www.fluentd.org/)
  - [Fluentd's Docker Image](https://hub.docker.com/r/fluent/fluentd/)
  - [Fluentd's Google Cloud plugin](https://github.com/GoogleCloudPlatform/fluent-plugin-google-cloud)
- [Stackdriver](https://cloud.google.com/stackdriver/)
  - [Google Cloud Platform](https://cloud.google.com/)
  - [Google Logging API](https://cloud.google.com/logging/docs/api/)
  - [Google Service Account Key](https://cloud.google.com/iam/docs/creating-managing-service-account-keys)
- [Nginx](https://www.nginx.com/) (just for an example purpose)
  - [Nginx's Docker Image](https://hub.docker.com/_/nginx)

## How does it works

Nginx Logs -> Docker Logs plugin -> Fluentd -> Fluentd's Google Cloud plugin -> Google Logging API -> Stackdriver

## Contributors

[Adam Łukaszczyk](https://github.com/adamlukaszczyk)

# TODO Topics:

Official docs states it will work only with GCP and AWS, but 
API and Agent
 - API has official documentation 
 - Agent has official documentation only for GCP and AWS

KNative has support for Stackdriver even if the cluster is set outside of GCP/AWS

Add license