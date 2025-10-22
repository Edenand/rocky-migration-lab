# 🧱 Rocky Migration Lab

## Overview
This repository documents the setup and testing of a CentOS 7 → Rocky Linux 9 modernization lab environment using **KVM** and **libvirt** on Ubuntu 22.04.  
The goal is to simulate a real-world modernization workflow: migrating a legacy CentOS 7 system to a Rocky Linux 9 target while maintaining full network connectivity, SSH access, and reproducibility.

---

## 🖥️ Host System
- **Hostname:** larry  
- **OS:** Ubuntu 22.04.5 LTS  
- **Kernel:** 5.15.0-157-generic  
- **Hardware:** HP EliteDesk 705 G2 SFF  
- **Virtualization:** KVM + libvirt + virt-manager  
- **Network Bridge:** `virbr0` (default NAT)  

---

## 🧩 Phase 1 — Legacy CentOS 7 VM
**VM Name:** `legacy-centos7`  

**Configuration**
- OS: CentOS 7 (Minimal ISO)  
- vCPUs: 2  
- RAM: 2 GB  
- Disk: 15 GB (qcow2)  
- Network: NAT via `virbr0`  
- IP: `192.168.122.87`  
- SSH: Active and verified  

**Validation**
- DHCP via dnsmasq working  
- Host ↔ Guest pings successful  
- Internet access verified  
- Snapshot created: `baseline-network-ready`  

---

## 🚀 Phase 2 — Rocky Linux 9 Target VM
**VM Name:** `rocky9-target`  

**Configuration**
- OS: Rocky Linux 9.6 (Blue Onyx)  
- vCPUs: 2  
- RAM: 4 GB  
- Disk: 20 GB (qcow2)  
- Network: NAT via `virbr0`  
- IP: `192.168.122.89`  
- User: `edenand`  
- SSH: Active and verified  

**Validation**
- DHCP assigned IP successfully  
- Host ↔ Guest pings working  
- Internet connectivity verified  
- Snapshot created: `rocky9-clean-install`  

---

## 🔧 Phase 2A — Legacy Workload Deployment (Prometheus Stack)
**Purpose:** Introduce a containerized application on the CentOS 7 VM to simulate a real legacy workload for modernization.

**Workload**
- **Application:** Prometheus + Node Exporter  
- **Container Platform:** Docker 26.1.4 + Docker Compose v2.27.0  
- **Ports:** 9090 (Prometheus UI), 9100 (Node Exporter metrics)  
- **Network:** NAT via `virbr0`  
- **Status:** Running and validated in browser  

**Validation**
- Prometheus reachable at [http://192.168.122.87:9090](http://192.168.122.87:9090)  
- Node Exporter metrics available at [http://192.168.122.87:9100/metrics](http://192.168.122.87:9100/metrics)  
- Verified Docker daemon active and containers listed with `docker ps`  

**Snapshot Created**  

**Artifacts Captured**
- `snapshots/legacy-centos7.xml` (VM definition)  
- `snapshots/virbr0.xml` (Network definition)  
- `/home/eden/prom-stack/` (Docker configs)  
- Browser validation successful  

---

## ⚙️ Phase 3 — Ansible Migration Simulation
**Purpose:** Demonstrate an automated migration workflow between legacy CentOS 7 and Rocky 9 using Ansible.

**Workflow**
1. Configured `ansible.cfg` and `inventory.ini` for both VMs.  
2. Verified connectivity with `ansible -m ping all`.  
3. Created playbook `migrate.yml` to simulate a config transfer:  
   - Fetched `/etc/hosts` from CentOS 7  
   - Deployed it to Rocky Linux 9 via delegation  
4. Verified successful run (`changed = 1`) showing automated migration.  

**Outcome**
✅ Working automation demonstration reflecting CIQ-style modernization and cross-environment reproducibility.  

**Artifacts Captured**
- `ansible/playbooks/precheck.yml`  
- `ansible/playbooks/migrate.yml`  
- `docs/migration-summary.md`  

---

## 🔒 Phase 4 — Security Hardening & Validation
**Purpose:** Validate system integrity and align the Rocky 9 VM with CIQ’s RLC-Hardened standards.

**Steps**
1. Enforced SELinux and confirmed with `getenforce` → `reports/selinux_status.txt`  
2. Enabled `firewalld` and verified it’s active → `reports/firewalld_status.txt`  
3. Ran `rpm -Va --nofiles --noscripts` for package integrity → `reports/rpm_verify.txt`  
4. Documented findings in `docs/hardening-validation.md`.

**CIQ Alignment**
- Mirrors CIQ’s **RLC-Hardened** baseline (SELinux, Firewalld, signed package integrity).  
- Reflects **Lifecycle Validation** by ensuring no unauthorized drift in system binaries.  
- Ties directly into CIQ’s FIPS 140-3 readiness and compliance posture.  

**Artifacts**
- `docs/hardening-validation.md`  
- `reports/selinux_status.txt`  
- `reports/firewalld_status.txt`  
- `reports/rpm_verify.txt`

---

## 📈 Phase 5 — Benchmark + Validation
**Purpose:** Measure CPU performance post-migration and confirm no degradation occurred compared to CentOS 7.

**Steps**
1. Installed Sysbench (`dnf install -y sysbench`).  
2. Executed `sysbench cpu run` and captured → `reports/sysbench-rocky9.txt`.  
3. (Optional) Ran the same test on CentOS 7 for comparison → `reports/sysbench-centos7.txt`.  
4. Documented results in `docs/benchmark-summary.md`.

**CIQ Alignment**
- Reflects CIQ’s **Lifecycle Validation** testing pipeline — regression and performance validation before image release.  
- Demonstrates modernization consistency under CIQ’s lifecycle management.  

**Artifacts**
- `docs/benchmark-summary.md`  
- `reports/sysbench-rocky9.txt`  
- `reports/sysbench-centos7.txt` (optional)

---

## ☁️ Phase 6 — Cloud Portability Simulation (Terraform Stub)
**Purpose:** Illustrate cloud readiness and hybrid consistency using Terraform as a declarative IaC framework.

**Stub Overview**
- File: `terraform/rocky9_cloud.tf`  
- Defines AWS provider configuration and a placeholder EC2 instance.  
- Non-functional (no AMI or credentials) — demonstrates structure only.

**CIQ Alignment**
- Reflects CIQ’s **Hybrid Consistency** model — Rocky can be deployed and managed identically across on-prem and cloud.  
- Simulates **Lifecycle Management as Code**, foundational to CIQ’s infrastructure automation approach.  

**Artifacts**
- `terraform/rocky9_cloud.tf`  
- `docs/cloud-portability.md`

---

## 🧾 Final Deliverables Summary
| Phase | Description | Key Artifacts |
|-------|--------------|----------------|
| 1 | Legacy CentOS 7 VM | `snapshots/legacy-centos7.xml` |
| 2 | Rocky 9 Target VM | `snapshots/rocky9-target.xml`, `snapshots/virbr0.xml` |
| 2A | Prometheus Legacy Workload | `/home/eden/prom-stack/`, Docker Compose configs |
| 3 | Ansible Migration Simulation | `ansible/playbooks/*.yml`, `docs/migration-summary.md` |
| 4 | Security Hardening | `reports/*.txt`, `docs/hardening-validation.md` |
| 5 | Benchmark Validation | `reports/sysbench-*.txt`, `docs/benchmark-summary.md` |
| 6 | Terraform Cloud Stub | `terraform/rocky9_cloud.tf`, `docs/cloud-portability.md` |

---

## 🎤 Demo Flow (5-Minute Summary)
1. Show reproducibility (`snapshots/*.xml`).  
2. Highlight migration automation (`ansible-playbook migrate.yml`).  
3. Display hardening & validation outputs (`reports/selinux_status.txt`, `firewalld_status.txt`).  
4. Review benchmark results (`reports/sysbench-rocky9.txt`).  
5. End with the Terraform stub to illustrate CIQ’s hybrid consistency message.  

---

## 🧠 Key Takeaway
This lab simulates CIQ’s modernization approach:  
**Migration → Automation → Security → Lifecycle → Portability.**  
Rocky Linux delivers the open-source foundation, while CIQ provides the hardened, lifecycle-managed, and hybrid-consistent ecosystem around it.
