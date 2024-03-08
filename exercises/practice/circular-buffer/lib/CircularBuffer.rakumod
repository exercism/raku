my class X::CircularBuffer::BufferIsEmpty is Exception {
    method message {'Buffer is empty'}
}

my class X::CircularBuffer::BufferIsFull is Exception {
    method message {'Buffer is full'}
}

class CircularBuffer {
    has $.capacity;
    
    method read () {}

    method write ($item) {}

    method clear () {}

    method overwrite ($item) {}
}
