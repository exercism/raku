my class X::CircularBuffer::BufferIsEmpty is Exception {
    method message {'Buffer is empty'}
}

class CircularBuffer {
    has $.capacity;
    
    method read {}

    method write {}

    method clear {}

    method overwrite {}
}
