.PHONY: all test clean check
PATH  := "$(PATH):$(PWD)/_VM/scripts"
SHELL := env PATH=$(PATH) /bin/bash -xe
inis  = $(sort $(wildcard */test.ini))
inis2  = $(sort $(dir $(wildcard */test.ini)))

all:
	@echo $(inis)
	@echo $(inis2)

clean:
	git clean -fd
