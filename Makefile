run: *.rkt
	racket main.rkt

# Add more moudles if needed
test: test.rkt testtools.rkt game.rkt 
	raco test test.rkt game.rkt



