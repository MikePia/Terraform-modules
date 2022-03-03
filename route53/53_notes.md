# Route 53
[blog](http://100daysofdevops.com/21-days-of-aws-using-terraform-day-9-introduction-to-route53-using-terraform/)


Amazon Route 53 is a highly available and scalable Domain Name System (DNS) web service. You can use Route 53 to perform three main functions in any combination:
* Domain Registration
* DNS Routing
* Health Checking

## Definitions I have been using without understanding ...
* Record
 : A record is used to translate human-friendly domain names such as “www.example.com” into IP-addresses such as 192.168.0.1 (machine friendly numbers).

* nCNAME Record
 : A Canonical Name record (abbreviated as CNAME record) is a type of resource record in the Domain Name System (DNS) which maps one domain name (an alias) to another (the Canonical Name.)

* NameServer Record
: NS-records identify the DNS servers responsible (authoritative) for a zone.


## Detour How to  Add a Subdfomain in Route 53

* https://www.youtube.com/watch?v=mz2WLMnPMXo

Some stuff I learned. Using AWS Certificates is a vendor lockin. The conveninece may be worth it but it won't transfer to Google, Heroku or anything. I am going to try to use my current registrar with CNAME records instead. Revist it at a calm time in my work.
