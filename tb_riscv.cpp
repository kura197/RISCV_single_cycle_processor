#include <iostream>
#include <vector>
#include <verilated.h>
#include "Vriscv.h"

void print_rf(Vriscv* dut){
    unsigned int pc = dut->v__DOT__datapath__DOT__pc;
    vector<unsigned int> x(32);
    for(int i = 0; i < 32; i++)
        x[i] = dut->v__DOT__datapath__DOT__regfile__DOT__data[i];
    printf("\rpc: %08x, x0: %08x, ra: %08x, sp: %08x,\n \
            \rgp: %08x, tp: %08x, t0: %08x, s0: %08x,\n \
            \ra0: %08x, a1: %08x, a2: %08x, a3: %08x,\n \
            \ra4: %08x, a5: %08x, a6: %08x, a7: %08x\n", \
            pc, x[0], x[1], x[2], \
            x[3], x[4], x[5], x[8], \
            x[10], x[11], x[12], x[13], \
            x[14], x[15], x[16], x[17]);
}

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);

    Vriscv *dut = new Vriscv();

    //// toggle reset_n
    dut->reset_n = 1;
    dut->clk = 0;
    int time_counter = 0;
    while(time_counter < 100){
        if(time_counter % 5 == 0)
            dut->clk = !dut->clk;

        if(time_counter == 20)
            dut->reset_n = 0;

        dut->eval();
        time_counter++;
    }

    //// initialize memory
    //// TODO: support elf loading
    const int IADDR = 16;
    const int DADDR = 16;
    vector<unsigned int> dmem(1 << DADDR), imem(1 << IADDR);

    //// start simulation
    dut->reset_n = 1;
    int cycle = 0;
    while(time_counter < 500){
        if(time_counter % 5 == 0)
            dut->clk = !dut->clk;
        if(time_counter % 10 == 0)
            cycle++;

        if(dut->dmem_wr_en)
            dmem[dut->dmem_addr] = dut->dmem_wdata;
        dut->dmem_rdata = dmem[dut->dmem_addr];
        dut->imem_rdata = imem[dut->imem_addr];

        dut->eval();
        time_counter++;
    }

    printf("Final cycle count = %d\n", cycle);
    print_rf(dut);

    dut->final();
    delete dut;
}
