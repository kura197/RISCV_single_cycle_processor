
SRC := counter_4bit.sv

TB_SRC := tb_counter_4bit.cpp

OBJ_DIR := obj_dir

OBJ := $(OBJ_DIR)/counter_4bit

MKFILE := V${SRC:.sv=.mk}

$(OBJ): $(OBJ_DIR)
	make -C $(OBJ_DIR) -f $(MKFILE)

$(OBJ_DIR): $(SRC) $(TB_SRC)
	verilator -cc $(SRC) -exe $(TB_SRC) -o $(OBJ)

.PHONY:clean
clean:
	rm -r $(OBJ_DIR)
