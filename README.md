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

## 🪣 Next Steps
1. Prepare migration test (CentOS 7 → Rocky 9).  
2. Configure Ansible for automation between VMs.  
3. Compare package sets, kernel modules, and SELinux configs.  
4. Document CIQ-aligned modernization findings.

---

## 🧾 Version Control
**Current Milestone:**  
> “Rocky Linux 9.6 target VM clean install, network + SSH verified, snapshot saved as `rocky9-clean-install`.”
