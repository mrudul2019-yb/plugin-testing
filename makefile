# Set compiler to g++ or clang++ as needed
CXX := g++
CXXFLAGS := -g -O2 -Wall -std=c++2a
LDFLAGS := 

ifeq ($(CXX), clang++)
# Use the LLD linker
LDFLAGS := -fuse-ld=lld
endif

CT_ERR = compile_errors.txt
RT_ERR = runtime_errors.txt
OUTPUT = output.txt
TIMEOUT = 20s

MAIN = testing
PROG = $(MAIN)
# LIB = cp
# $(CXX) $(MAIN).cpp $(CXXFLAGS) $(LDFLAGS)-l$(LIB) -o $(PROG) > $(CT_ERR) 2>&1

run: $(PROG)		
	timeout $(TIMEOUT) ./$(PROG) > $(OUTPUT) 2> $(RT_ERR)


$(PROG): $(MAIN).cpp
	$(CXX) $(MAIN).cpp $(CXXFLAGS) $(LDFLAGS) -o $(PROG) > $(CT_ERR) 2>&1


abort:
	pkill $()

clean: 
	rm $(PROG)

.phony: run