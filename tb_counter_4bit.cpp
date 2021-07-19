#include <iostream>
#include <verilated.h>
#include "Vcounter_4bit.h"

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);

    Vcounter_4bit *dut = new Vcounter_4bit();

    dut->reset_n = 0;
    dut->clk = 0;
    dut->en = 0;

    int time_counter = 0;
    while(time_counter < 100){
        dut->eval();
        time_counter++;
    }

    dut->reset_n = 1;

    int cycle = 0;
    while(time_counter < 500){
        if(time_counter % 5 == 0)
            dut->clk = !dut->clk;
        if(time_counter % 10 == 0)
            cycle++;

        if(cycle % 5 == 0)
            dut->en = 1;
        else
            dut->en = 0;

        dut->eval();
        time_counter++;
    }

    printf("Final Counter Value = %d\n", dut->cnt);

    dut->final();
}
