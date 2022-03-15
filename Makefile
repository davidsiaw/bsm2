SRC_DIR := src
MSBSRC_DIR := src/msb2
OBJ_DIR := obj
MSBOBJ_DIR := obj/msb2
BIN_DIR := bin

EXE := $(BIN_DIR)/bsm2
MSBEXE := $(BIN_DIR)/msb2

LEXER_H := $(SRC_DIR)/FlexLexer.h
LEXER_CPP := $(SRC_DIR)/lex.yy.cpp
LEXER := $(LEXER_H) $(LEXER_CPP)

SRC := $(LEXER_CPP) $(wildcard $(SRC_DIR)/*.cpp)
MSBSRC := $(wildcard $(MSBSRC_DIR)/*.cpp)

OBJ := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SRC))
MSBOBJ := $(patsubst $(MSBSRC_DIR)/%.cpp, $(MSBOBJ_DIR)/%.o, $(MSBSRC))

CPPFLAGS := -Iinclude -MMD -MP -std=c++17
CFLAGS   := -Wall -Wpedantic
LDFLAGS  := 
LDLIBS   := 

all: $(EXE) $(MSBEXE)

$(MSBEXE): $(MSBOBJ) | $(BIN_DIR)
	$(CXX) $(LDFLAGS) $^ $(LDLIBS) -o $@

$(EXE): $(OBJ) | $(BIN_DIR)
	$(CXX) $(LDFLAGS) $^ $(LDLIBS) -o $@

$(LEXER_CPP):	$(SRC_DIR)/scanner.flex
	flex -+ --header-file=$(LEXER_H) -o $(LEXER_CPP) $(SRC_DIR)/scanner.flex

$(SRC_DIR)/%.cpp: $(LEXER)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(OBJ_DIR)
	$(CXX) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(MSBOBJ_DIR)/%.o: $(MSBSRC_DIR)/%.cpp | $(MSBOBJ_DIR)
	$(CXX) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BIN_DIR) $(OBJ_DIR) $(MSBOBJ_DIR):
	mkdir -p $@

.PHONY: clean

clean:
	@$(RM) -rv $(BIN_DIR) $(OBJ_DIR) $(MSBOBJ_DIR) $(LEXER)

-include $(OBJ:.o=.d) $(MSBOBJ:.o=.d)
