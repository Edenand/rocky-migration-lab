# Phase 3B — Workload Migration Validation (Prometheus Stack)

## Objective
Verify that the legacy Prometheus + Node Exporter workload has been successfully migrated from CentOS 7 to Rocky Linux 9 and remains accessible post-migration.

## Steps Performed
1. Created `prom-stack.tar.gz` on CentOS 7 via Ansible and transferred it to the control host.
2. Copied and extracted the workload on the Rocky 9 target.
3. Installed Docker CE and Compose on Rocky.
4. Started the stack with `docker compose up -d`.

## Validation
- Verified containers running with `docker ps`:
  - `prom/prometheus:latest`
  - `prom/node-exporter:latest`
- Confirmed access in browser:
  - Prometheus UI → [http://192.168.122.89:9090](http://192.168.122.89:9090)
  - Node Exporter metrics → [http://192.168.122.89:9100/metrics](http://192.168.122.89:9100/metrics)
- Both services reachable and serving metrics as expected.

## Outcome
✅ Prometheus stack successfully migrated and operational on Rocky Linux 9.

## CIQ Alignment
This phase demonstrates **application-level lifecycle continuity**—the same containerized workload runs identically on Rocky’s hardened base.  
It mirrors CIQ’s modernization deliverables:
- **Lifecycle Management:** validated deployment of a pre-existing workload on a new OS baseline.  
- **Hybrid Consistency:** containers reproduce seamlessly across environments.  
- **Automation First:** migration codified via Ansible playbook.  

**Artifacts**
- `ansible/playbooks/migrate_prometheus.yml`
- `docs/workload-validation.md`
