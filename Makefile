octfiles:
	mkoctfile bvp_system.cpp

run:
	octave main.m

test:
	octave bvp_test.m