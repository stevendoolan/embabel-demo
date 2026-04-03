# Incident Chat Log: Payment Gateway Outage

**Date:** 2025-12-10
**Severity:** P1
**Duration:** 45 minutes

---

**09:15 - Sarah (On-call Engineer):**
Getting alerts from monitoring — payment gateway returning 503s across all regions.

**09:16 - Mike (Platform Lead):**
Confirmed. Error rate spiked from 0.1% to 78% in the last 2 minutes. Customers can't complete bookings.

**09:18 - Sarah:**
Checked the upstream provider status page — no reported issues on their end. Our logs show connection timeouts to their API.

**09:20 - James (Network Ops):**
Found it. The firewall rule change we deployed at 09:12 is blocking outbound traffic on port 8443. Rolling back now.

**09:23 - James:**
Rollback complete. Firewall rules reverted to previous config.

**09:25 - Sarah:**
Error rate dropping. Down to 12% and falling.

**09:28 - Mike:**
Confirmed recovery. Error rate back to baseline 0.1%. All regions healthy.

**09:30 - Sarah:**
All clear. Monitoring stable for 5 minutes. Standing down the incident.

**09:45 - Mike (Post-incident note):**
Root cause was an untested firewall rule change that blocked the payment gateway port. Change was part of the security hardening sprint but was not validated against the port dependency map. Action item: add port 8443 to the pre-deployment checklist for firewall changes.
