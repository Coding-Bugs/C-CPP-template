.SUFFIXES:.c.o.cpp
# Makefile mode
MODE = "C"															# "C" for C and "C++" for C++

# Compiler Related Info
CC =																# Compiler
CFLAGS =															# Compiler flags
LIBS =																# Libraries needing linked

# Directory Related Info 
SRC_DIR = src														# Source file directory
OBJ_DIR = obj														# object file directory
INC_DIR = src/include												# Header file directory

# Executable Related Info
EXEC = .exe															# Executable's name

ifeq MODE "C"														
SRC_C := $(wildcard $(SRC_DIR)/*.c)									# C Source files, grabs all files matching the condition
OBJECTS_C := $(SRC_C:$(SRC_DIR)/%.c=$(OBJ_DIR)/%.o)					# Creates C object files names from source file names

else ifeq MODE "C++"															
SRC_CPP := $(wildcard $(SRC_DIR)/*.cpp)								# CPP Source files, grabs all files matching the condition
OBJECTS_CPP := $(SRC_CPP:$(SRC_DIR)/%.cpp=$(OBJ_DIR)/%.o)			# Creates C object files names from source file names

endif

# Rule to start compliation of executable and source files
make: $(EXEC)														

# Linking
$(EXEC): $(OBJECTS)													# Rule to link the object files and libraries into the executable
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)								# Linking command to compile the executable
	@echo "Executable linked successfully"							# Alert user that compilation was successful

# object file Compilation
ifeq MODE "C"								
$(OBJECTS): $(OBJ_DIR)/%.o : $(SRC_DIR)/%.c | $$(@D)/				# Make object file directory if missing, then process each object file
	$(CC) $(CFLAGS) -c $< -o $@										# Compile the C file into an object file
	@echo "Compiled "$<" successfully"								# Alert user that compilation was successful

else ifeq MODE "C++"
$(OBJECTS): $(OBJ_DIR)/%.o : $(SRC_DIR)/%.cpp | $$(@D)/				# Make object file directory if missing, then process each object file
	$(CC) $(CFLAGS) -c $< -o $@										# Compile the C++ file into an object file
	@echo "Compiled "$<" successfully"								# Alert user that compilation was successful

endif

# Rule to create object file directory if missing
$(OBJ_DIR)/:		
	mkdir -p $(OBJ_DIR)												# Command to create object file directory if it is missing


# Run executable
run: $(EXEC)
	./$(EXEC)														# Execute the executable

# Clean project folder to initial state
clean:
	rm -rf $(OBJ_DIR)												# Recursively clean the object file directory and then remove that directory
	rm -f $(EXEC)													# Remove the executable