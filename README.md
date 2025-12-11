# Project : QNX based VoIP Gateway Design Evaluation

## Executive Summary
The project undertook the development and assessment of a VoIP Gateway on the Broadcom BCM2711 processor. From establishing a QNX build environment to booting QNX and scripting with Linux, each phase was meticulously executed. The successful implementation of a PBX system using Asterisk highlighted the processor's capability in telecom scenarios. Additionally, a Morse Code decoder and encoder application was developed, demonstrating the processor's robust performance in complex telecom tasks.

## Problem Statement and Objectives
The project's aim was to assess the suitability of the Broadcom BCM2837 processor for VoIP applications by evaluating its hardware capabilities, software performance, and overall efficiency in real-time telecom tasks.

## Approach and Methodology for Evaluation
The methodology involved setting up various operating environments, creating a PBX system, developing telecom applications, and conducting extensive scripting to evaluate the processor's performance.

### Key Phases:
- **Module 1:** Set up QNX SDP and momentics
- **Module 2:** Boot QNX on Raspberry Pi 4 B.
- **Module 3:** Script execution at startup in Linux for system monitoring.
- **Module 4:** PBX system construction with Asterisk.
- **Module 5:** Development of Iot application on QNX.
- **Module 6:** Scripting on QNX


## Module Test Results
Each module's test results demonstrated the Broadcom processor's versatility and efficacy. With detailed DMIPS scores, the processor showcased its robust capabilities in various computational scenarios.

## List of Project Deliverables
The repository contains:
- Source code for each module
- Documentation of test results
- Individual module reports
- Block diagrams and flowcharts
- BOM and project staffing details

## Recommendations 
For the VoIP Gateway Design Evaluation project, the Broadcom BCM2711 processor, as found in the Raspberry Pi 4, is recommended as the primary computing platform. While this MPU is highly capable, it is primarily available as a commercial product, and direct cost data for individual units was not obtainable. Therefore, for practical budgetary and procurement purposes, the BCM49408 is recommended as the alternative. The BCM2711 remains a strong option due to its compatibility with both QNX and Linux, which enables flexibility across multiple operating environments. Its large community ecosystem and support for a wide range of open-source tools further streamline development and troubleshooting. However, it is most suitable for projects where sourcing from Raspberry Pi is feasible, typically larger-scale deployments. The BCM49408, by contrast, meets budget constraints while providing sufficient processing power and memory resources. Its bill of materials totals $37.70. Key specifications include a low-power quad-core Cortex-A53 64-bit ARM processor running at 1.8 GHz, 1 MB shared L2 cache with ECC, 32-bit DDR3-1600 memory interface, 3× PCIe Gen2 lanes, USB3, SATA3, 2.5G PHY support (SGMII+), and 5 integrated Gigabit Ethernet PHYs with switch capabilities. Combined with Linux and QNX support, the BCM49408 represents a cost-effective and technically sufficient solution for achieving the objectives of the VoIP Gateway Design Evaluation project.

## Appendix
- Detailed module test results
- References
- FAQs
- BOM
- Project Staffing information

## Authors
- Nimish 
- Hannah
- Nimisha

## Additional Notes
This README serves as an overview of the VoIP Gateway Design Evaluation project, hosting essential information for stakeholders and contributors to understand the project's scope, objectives, and outcomes. 

