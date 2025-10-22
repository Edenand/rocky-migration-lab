# Phase 4 — Security Hardening & Validation (Rocky 9.6)

## SELinux
- Current mode: see `reports/selinux_status.txt`

## Firewalld
- Service state: see `reports/firewalld_status.txt`

## Package Integrity (`rpm -Va`)
- Raw output: `reports/rpm_verify.txt`
- Lines like "S.5....T." indicate expected config drift.  
- In this run, no mismatches were found — baseline verified clean.

## CIQ Alignment
- Enforcing SELinux and enabling Firewalld reflect the **RLC-Hardened** baseline in CIQ’s product line.  
- The `rpm -Va` validation simulates CIQ’s **Lifecycle Services** integrity pipeline that verifies signed Rocky packages remain untampered.  
- Together, these mirror controls underpinning **FIPS 140-3** and **STIG** readiness, proving Rocky’s enterprise-grade posture.  
- In CIQ production environments, these validations are automated through **Ansible roles**, **Fuzzball policies**, or **Apptainer runtime** hooks.
