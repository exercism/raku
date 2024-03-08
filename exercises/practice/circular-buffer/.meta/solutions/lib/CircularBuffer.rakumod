my class X::CircularBuffer::BufferIsEmpty is Exception {
    method message {'Buffer is empty'}
}

my class X::CircularBuffer::BufferIsFull is Exception {
    method message {'Buffer is full'}
}

role Circular-Buffer-Interface is export {
      has UInt $.capacity is required;
      multi method clear(             --> Bool) {...}
      multi method read(              --> Any ) {...}
      multi method read(UInt $count   --> Seq ) {...}
      multi method write(**@items     --> UInt) {...}
      multi method overwrite(**@items --> UInt) {...}
  }

  class CircularBuffer does Circular-Buffer-Interface is export {

      has UInt $.elems = 0;
      has UInt $!read-pointer = 0;
      has UInt $!write-pointer = 0;
      has @!buffer = [];

      multi method clear( --> Bool) {
          $!elems = 0;
          $!read-pointer = 0;
          $!write-pointer = 0;
          @!buffer = [];
          True
      }

      method !is-empty(                   --> Bool) { $!elems == 0 }
      method !is-full(                    --> Bool) { $!elems == $!capacity }
      method !has-space-for( UInt $count, --> Bool) { $count <= ($!capacity - $!elems) }
      method !tic( $pointer is rw,        --> UInt) { $pointer = ($pointer + 1) % $!capacity }

      multi method read(--> Any) { self!get-item }
      multi method read(UInt $count --> Seq){
          PRE { $count <= $!elems }
          gather { take self!get-item for ^$count }
      }
      multi method write { 0 }    
      multi method write(**@items --> UInt){ 
          PRE { +@items and self!has-space-for(+@items) or X::CircularBuffer::BufferIsFull.new.throw }

          self!write-item($_) for @items;
          +@items
      }
      multi method overwrite(**@items --> UInt){ 
          PRE { +@items }

          for @items -> $item {
              self!tic($!read-pointer) if self!is-full;
              self!write-item( $item )
          }
          +@items
      }
      method !get-item {
          PRE   { not self!is-empty or X::CircularBuffer::BufferIsEmpty.new.throw }
          
          LEAVE { $!elems-- unless self!is-empty;
                  @!buffer[ $!read-pointer ] = Nil;
                  self!tic($!read-pointer)
          }
          @!buffer[ $!read-pointer ]
      }
      method !write-item($item) {
          LEAVE { $!elems++ unless self!is-full;
                  self!tic($!write-pointer)
          }
          @!buffer[ $!write-pointer ] = $item.clone # clone: slow but prevents reference capturing/leaking!
      }
  }
