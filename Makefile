
TOP := riscv.sv
INCLUDE := ./src

SRC := ./src/$(TOP)

TB_SRC := testbench/tb_riscv.cpp testbench/read_elf.cpp

OBJ_DIR := obj_dir

OBJ := vtest

MKFILE := V${TOP:.sv=.mk}

CFLAGS := -std=c++14

# need to set TEST_BIN for simulation
.PHONY:test
test: $(OBJ_DIR)/$(OBJ)
	./$(OBJ_DIR)/$(OBJ) $(TEST_BIN)

$(OBJ_DIR)/$(OBJ): $(OBJ_DIR)
	make -C $(OBJ_DIR) -f $(MKFILE)

$(OBJ_DIR): $(SRC) $(TB_SRC)
	if [ -d "$(OBJ_DIR)" ]; then rm -r $(OBJ_DIR); fi
	verilator -cc $(SRC) -CFLAGS $(CFLAGS) -exe $(TB_SRC) -I$(INCLUDE) -o $(OBJ)

.PHONY:clean
clean:
	rm -r $(OBJ_DIR)
