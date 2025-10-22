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

## 🪣 Next Steps
1. Phase 4 – Security hardening + validation (SELinux + firewalld + rpm verify)  
2. Phase 5 – Sysbench performance benchmark + validation playbook  
3. Phase 6 – Terraform cloud portability stub + final README narrative  

---

## 🧾 Version Control
**Current Milestone:**  
> “Phase 3 Ansible migration simulation completed — demonstrating automated config transfer between CentOS 7 and Rocky 9, aligned with CIQ modernization principles.”
