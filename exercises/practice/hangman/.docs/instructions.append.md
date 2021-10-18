# New approach to the exercise

Please ignore the part regarding an FRP library, a third party library is
not required for this exercise.  This exercise focuses on event-driven
programming using callbacks and Tcl's event loop.

You are required to construct a TCP server and a domain-specific protocol.
This server is launched with the word to guess and a port number. 
The test script implements the client that sends commands to the server.

The protocol commands to implement are:

- `STATUS` to return the current state of the game. The response will be a
  three-elememt list:
    1) the number of bad guesses remaining,
    2) the word masked with underscores for unguessed letters, and
    3) a status field (one of "ongoing", "win"
  or "lose")
- `GUESS x` where `x` is a letter to guess. The server will respond with the
  status list after each guess.
- `SHUTDOWN` to remotely shutdown the server. The server will otherwise
  exit after a win or loss.

The server should be able to handle these commands case-insensitively.

## Hints

You'll need these Tcl commands:
[`socket`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/socket.htm),
[`fileevent`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/fileevent.htm),
[`vwait`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/vwait.htm).

This [example socket program](https://www.tcl-lang.org/about/netserver.html) can get you started.
