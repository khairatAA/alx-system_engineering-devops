# Error 500 outage incident report

<b>Posted</b>: Sunday, January 21, 2024
<br>

By the Software Engineering Team

## Issue Summary

From 4:00 PM to 5:45 PM WAT, request to our company sites resulted in 500 error response messages. At its peak, the issue affected 100% traffic our company's wesite in both mobile apps and web pages. The roor cause of the outage was an invalid configuration change that exposed a bug in the website functionality.

## Timeline

- 4:00 PM: Configuration push begins
- 4:26 PM: Outage begins
- 4:26 PM: Pagers alter teams
- 4:54 PM: Failed configuration change rollback
- 5:15 PM: Sucessful configuration rollback
- 5:19 PM: Server restarts begin
- 5:45 PM: 100% of traffic back online

## Root Cause

At 4:OO PM WAT, a configuration change was inadvertently released to our production environment without first being released to the testing environment. The change specified an updated to the configuration file. This exposed bugs to the entire code which caused the 500 error display and at 4:26 PM WAT, the service outage began.

## Resolution and recovery

At 4:26 PM WAT, the monitoring system alterted our engineers who investigated and quickly escalated the issue. By 4:40 PM, the incident response team identified that the monitoring system was exacerbating the problem caused by a bug.

At 4:54 PM, we attempted to rollback the problematic configuration change. This rollback failed due to complexity in the configuration system. These problems were addressed and we sucessfully rolled back 5:15 PM.

We decided to restart the server at 5:19 PM, by 5:30PM, 25% of traffic was restored and %100 of traffic was actively on the site at 4:45 PM.

# Corrective and Preventative Measures

In the last two days, we've conducted an internal review and analysis of the outage. The following are actions we are taking to address the underlying cause of the issue and to help prevent recurrence and improve response time:

- Patch Nginx server.
- Add monitoring on server memory.
- Porper testing before deylopment.
