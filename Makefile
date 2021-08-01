
TOP := riscv.sv
INCLUDE := ./src

SRC := ./src/$(TOP)

TB_SRC := tb_counter_4bit.cpp

OBJ_DIR := obj_dir

OBJ := vtest

MKFILE := V${TOP:.sv=.mk}

.PHONY:test
test: $(OBJ_DIR)/$(OBJ)
	./$(OBJ_DIR)/$(OBJ)

$(OBJ_DIR)/$(OBJ): $(OBJ_DIR)
	make -C $(OBJ_DIR) -f $(MKFILE)

$(OBJ_DIR): $(SRC) $(TB_SRC)
	verilator -cc $(SRC) -exe $(TB_SRC) -I$(INCLUDE) -o $(OBJ)

.PHONY:clean
clean:
	rm -r $(OBJ_DIR)
