# RISC-V 5-Stage Pipelined Processor with Hazard Unit (Verilog)

A 32-bit RISC-V (RV32I subset) five-stage pipelined processor in Verilog, simulated in Xilinx Vivado 2018. It includes a hazard unit with **data forwarding**, **load-use stalling**, and **pipeline flushing** on taken branches and jumps.

## Pipeline
```
 IF  →  ID  →  EX  →  MEM  →  WB
Fetch  Decode Execute Memory WriteBack
```
| Stage | File |
|---|---|
| Instruction Fetch | `Fetch.v` |
| Decode / register read | `decode.v` |
| Execute (ALU, branch target) | `execute.v` |
| Memory access | `Memory.v` |
| Write-back | `WriteBack.v` |
| Pipeline registers | `Buff_Reg.v`, `Buff_RegF.v` |
| Hazard unit | `hazard_unit.v` |
| Top level | `top_pipe.v` |

## Hazard handling (`hazard_unit.v`)
- **Forwarding:** `ForwardAE/ForwardBE` select the EX operands from the MEM stage (`10`) or WB stage (`01`) when `Rs1E/Rs2E` matches a destination register being written (x0 excluded).
- **Load-use stall:** when the instruction in EX is a load and its `rd` is needed by the instruction in ID, `StallF` and `StallD` freeze Fetch/Decode and `FlushE` inserts a bubble.
- **Control hazards:** when a branch is taken or `jal` executes (`PCSrcE`), `FlushD` and `FlushE` clear the two wrongly fetched instructions.

## Supported instructions
R-type (`add`, `sub`, `and`, `or`), I-type ALU (`addi`, …), `lw`, `sw`, `beq`, `jal`.

## Verification
`tb/tb_top_pipe.v` runs a test program and prints every cycle: PC per stage, forwarding selects, stall/flush signals and registers x1–x10. The captured run in [`sim/simulation_log.txt`](sim/simulation_log.txt) exercises:
- **4** clock cycles with active forwarding
- **1** load-use stall
- **3** flush cycles from a taken branch and `jal`

Final register state: `x1=5, x2=10, x3=15, x4=25, x5=25, x6=30, x7=11, x8=48, x9=9, x10=77`.

## Repository structure
```
rtl/    Verilog design sources
tb/     tb_top_pipe.v (full pipeline) + unit testbenches
sim/    Simulation log from Vivado
docs/   Full report: pipeline design, hazard analysis, waveforms
```

## How to simulate
1. Add everything in `rtl/` to a Vivado project.
2. Add `tb/tb_top_pipe.v` as the simulation top.
3. Run behavioral simulation; the per-cycle trace prints to the Tcl console.

## Report
See [`docs/Pipelined_Report.pdf`](docs/Pipelined_Report.pdf).

---
Built as part of the Computer Architecture module, Chip Design & Verification program, GIKI.
Reference: Harris & Harris, *Digital Design and Computer Architecture: RISC-V Edition*.
