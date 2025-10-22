# Phase 5 — Benchmark + Validation (Sysbench Results)

## CPU Benchmark

- Rocky Linux 9.6 results: see `reports/sysbench-rocky9.txt`
- (Optional) CentOS 7.9 results: see `reports/sysbench-centos7.txt`

### Key Observations
- Modernized kernel and toolchain (Rocky 9) may yield slightly faster CPU event handling.
- Both environments remained stable during benchmarking.
- No significant regressions — confirming modernization preserved performance integrity.

## CIQ Alignment
- Mirrors CIQ’s **Lifecycle Validation** process, where certified Rocky builds undergo automated regression and performance testing before release.  
- Demonstrates that modernization (CentOS → Rocky) can maintain or improve efficiency under CIQ’s managed lifecycle approach.  
- In CIQ’s production tooling, this validation would be part of **continuous compliance pipelines** run via **Fuzzball** or **Ansible test harnesses**.
