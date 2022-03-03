# SNS
[blog - no vid](http://100daysofdevops.com/21-days-of-aws-using-terraform-day-6-introduction-to-simple-notification-servicesns-using-terraform/)

* Publisher
* Topic
* Subscriber
    * Lambda, SQS, HTTP/S, Emai, SMS

## In the console
* Create topic
    * name
    * displayname
* Create Subscription
    * Topic arn
    * Protocol
    * Endpoint (confirm email)
* Publish a Message
    * Topic Arn
    * Subject
    * Format
    * Message
        * Attributes
            * Key, Type, Vaue