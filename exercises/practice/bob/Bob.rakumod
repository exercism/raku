#`[
    Declare role 'Bob' and unit-scope the role
    i.e. everything in this file is part of 'Bob'.
]
unit role Bob;

method hey () {
    return self;
}
