# Phase 6 — Cloud Portability Simulation (Terraform Stub)

## Overview
This Terraform configuration acts as a **non-functional stub**, representing how the Rocky 9 VM could be deployed in AWS using Infrastructure as Code (IaC).

It mirrors CIQ’s philosophy of **hybrid consistency** — the ability to manage Rocky systems the same way whether they run on bare metal, VMs, or public cloud.

## File: `terraform/rocky9_cloud.tf`
- Defines the AWS provider (HashiCorp)
- Simulates a Rocky 9 EC2 instance using a placeholder AMI
- Demonstrates tagging and structure consistent with real IaC workflows

## CIQ Alignment
- Reflects CIQ’s **Hybrid Consistency** and **Lifecycle Management** messaging.  
- In CIQ environments, real Terraform modules would interact with **RLC-certified images** and validated AMIs.  
- Demonstrates that the Rocky 9 system can extend seamlessly into CI/CD and IaC ecosystems (Terraform, Ansible, Fuzzball).  
- Reinforces that CIQ’s product suite supports both on-prem and cloud-native deployments with unified management.

## Next Steps (if extended)
- Replace placeholder AMI with an official Rocky 9 AMI (`aws ec2 describe-images ...`)
- Add networking, security group, and SSH key resources
- Integrate into CI/CD pipelines or Terraform Cloud for full automation
