OS = LINUX
PKGS = \
    --pkg gtk+-3.0
FLAGS = -v -g
FILES = \
    src/main.vala

all: $(FILES)
	valac $(FLAGS) $(PKGS) -o main $(FILES)
install:
	./main
