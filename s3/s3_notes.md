# S3
## Everything changed with new version for aws_s3_bucket
I think the crux is that a standard bucket is implemented with resource aws_s3_bucket.
There is something about a canned bucket but yet there are the followiong resources available. The good news is the canned bucket is what is wanted 99% fo the time. So KISS and not do the folowing.
```
resource aws_s3_bucket_acl {}
resource aws_s3_bucket_versioning {}
resource aws_s3_bucket_lifecycle_configuration {}
```
