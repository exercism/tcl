# append

## Implementation Notes

You will write an implementation of a doubly linked list.

Implement a Node to hold a value and pointers to the next and previous nodes.

Then implement a LinkedList which holds references to the first and last node and offers an array-like interface for adding and removing items:

- `push` (*insert value at back*);
- `pop` (*remove value at back*);
- `shift` (*remove value at front*);
- `unshift` (*insert value at front*);
- `delete` (*remove the first matching node*)

To keep your implementation simple, the tests will not cover error conditions.
Specifically: `pop` or `shift` will never be called on an empty list.
