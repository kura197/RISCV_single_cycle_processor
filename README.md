#  RISCV_single_cycle_processor
RISC-V single cycle processor supporting rv32i instructions.  
 

# Test
All instructions are tested by [riscv-tests](https://github.com/riscv/riscv-tests.git).   
Hardware modules are compiled by Verilator.
```
make
TEST_DIR=/path/to/riscv-tests ./test.sh
```
