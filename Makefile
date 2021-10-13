SRC_DIR := src
OBJ_DIR := obj
BIN_DIR := bin

EXE := $(BIN_DIR)/bsm2

LEXER_H := $(SRC_DIR)/FlexLexer.h
LEXER_CPP := $(SRC_DIR)/lex.yy.cpp
LEXER := $(LEXER_H) $(LEXER_CPP)

SRC := $(LEXER_CPP) $(wildcard $(SRC_DIR)/*.cpp)

OBJ := $(patsubst $(SRC_DIR)/%.cpp, $(OBJ_DIR)/%.o, $(SRC))

CPPFLAGS := -Iinclude -MMD -MP -std=c++17
CFLAGS   := -Wall -Wpedantic
LDFLAGS  := 
LDLIBS   := 

all: $(EXE)

$(EXE): $(OBJ) | $(BIN_DIR)
	$(CXX) $(LDFLAGS) $^ $(LDLIBS) -o $@

$(LEXER_CPP):	$(SRC_DIR)/scanner.flex
	flex -+ --header-file=$(LEXER_H) -o $(LEXER_CPP) $(SRC_DIR)/scanner.flex

$(SRC_DIR)/%.cpp: $(LEXER)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp | $(OBJ_DIR)
	$(CXX) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

$(BIN_DIR) $(OBJ_DIR):
	mkdir -p $@

.PHONY: clean

clean:
	@$(RM) -rv $(BIN_DIR) $(OBJ_DIR) $(LEXER)

-include $(OBJ:.o=.d)
