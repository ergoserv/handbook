# Naming Conventions

This document defines universal naming conventions for domains, Heroku resources, and AWS resources across all projects to ensure consistency, readability, and streamlined infrastructure management.

## General Best Practices

* **Case:** Use lowercase letters.

* **Delimiter:** Use hyphens for separation (kebab case). Avoid spaces, underscores, or special characters.

* **Environment Codes:** Use standard short abbreviations: `prod`, `staging`, `dev`, `pr` (Pull Request).

* **Base Structure:** `<project>-<service>-<environment>`.

* **Length Constraints & Abbreviations:** Cloud providers enforce strict character limits (e.g., Heroku apps max out at 30 characters). If a standard name exceeds the limit:

  * Shorten the region code first if one is used (e.g., `euw2` instead of `eu-west-2`).

  * Shorten the service name using recognizable abbreviations (e.g., `auth` instead of `authentication`, `notif` instead of `notifications`).

  * Use the short environment code (e.g., `stg` instead of `staging`).

  * Truncate the project name to an acronym as a last resort (e.g., `es` instead of `ergoserv`).

## 1. Domain Naming

Domain names should clearly indicate the service and environment, functioning as subdomains of the main project domain.

**Format:**

* **Production:** `<service>.<project_domain>`

* **Non-Production:** `<environment>.<service>.<project_domain>`

**Examples:**

* Production Auth App: `auth.ergoserv.com`

* Staging Auth App: `staging.auth.ergoserv.com`

## 2. Heroku Resources

Heroku application names share a global namespace, so they must be unique. Prefixing with the project name prevents naming collisions.

**App Naming Format:**
`<project>-<service>-<environment>`

**Examples:**

* Staging Auth App: `ergoserv-auth-staging`

* Production Auth App: `ergoserv-auth-prod`

## 3. AWS Resources

Standardizing tags is mandatory in AWS, but resource names themselves must self-describe their context and type. S3 buckets and some other resources require global uniqueness across all AWS accounts.

**General Resource Format:**
`<project>-<service>-<environment>-<resource_type>`

**Common Resource Type Abbreviations:**

* `s3`: Simple Storage Service bucket

* `rds`: Relational Database Service instance

* `ec2`: Elastic Compute Cloud instance

* `ecs`: Elastic Container Service cluster

* `vpc`: Virtual Private Cloud

**Examples for Staging Auth App:**

* S3 Bucket: `ergoserv-auth-staging-assets`

* RDS Database: `ergoserv-auth-staging-rds`

* EC2 Instance: `ergoserv-auth-staging-ec2-01`

* IAM Execution Role: `ergoserv-auth-staging-er`

## 4. Advanced Examples

**Core Project**

* **Domain:** `ergoserv.com`

* **Heroku team:** `ergoserv`

* **Heroku pipeline:** `ergoserv-server`

* **Heroku apps:** `ergoserv-server-staging` and `ergoserv-server-prod`

* **AWS S3 Buckets:** `ergoserv-staging-assets` and `ergoserv-prod-assets`

**Auth Service**

* **Domain:** `auth.ergoserv.com`

* **Heroku App:** `ergoserv-auth-prod`

* **AWS EC2 Instance:** `ergoserv-auth-prod-ec2-01`

* **AWS RDS Database:** `ergoserv-auth-prod-rds`

**Multiple Environments Case**

* **Domain:** `staging-2.auth.ergoserv.com`

* **Heroku App:** `ergoserv-auth-staging-2`

* **AWS EC2 Instance:** `ergoserv-auth-staging-2-ec2-01`

* **AWS RDS Database:** `ergoserv-auth-staging-2-rds`

**Multi-Region Case**

* **Domain:** `euw2.staging.auth.ergoserv.com`

* **Heroku App:** `ergoserv-auth-staging-euw2`

* **AWS EC2 Instance:** `ergoserv-auth-staging-euw2-ec2-01`

* **AWS RDS Database:** `ergoserv-auth-staging-euw2-rds`
