OTPROOT = $(wildcard /opt/erlang/lib/erl_interface-*)
NVCC = /usr/local/cuda/bin/nvcc
NVCC_FLAGS = -g -G -Xcompiler -Wall

all: cnode

clean:
		rm -rf bin

bin/Elixir.ElixirCudaExample.beam: lib/elixir_cuda_example.ex
		elixirc -o bin $<

cnode:
		mkdir -p bin
			$(NVCC) $(NVCC_FLAGS) cnode/cuda_cnode.cu -o bin/cuda_cnode \
						-I$(OTPROOT)/include -L$(OTPROOT)/lib -lerl_interface -lei -lpthread -lnsl
				epmd -daemon
					./bin/cuda_cnode 3456

start_server:
		epmd -daemon
			bin/cnodeserver 3456

start_elixir:
		echo "run 'ElixirCudaExample.foo(4)' via elixir shell"
			iex --sname e1 --cookie secretcookie -pa bin
