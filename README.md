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

## 🪣 Phase 3 — Migration Simulation (Next Step)
The next phase will recreate the Prometheus stack on the Rocky 9 target VM to demonstrate a successful modernization.  
Planned steps:
1. Copy the `prom-stack/` directory from CentOS 7 to Rocky 9.  
2. Install Docker + Compose on Rocky 9.  
3. Deploy identical containers and validate service availability (9090 / 9100).  
4. Capture snapshot `prom-stack-migrated`.  
5. Document results and Ansible automation workflow.  

---

## 🧾 Version Control
**Current Milestone:**  
> “Legacy CentOS 7 Prometheus stack running and validated (ports 9090 + 9100). Snapshot saved as `prom-stack-ready`. Next phase: Rocky Linux migration simulation.”
