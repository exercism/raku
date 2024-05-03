#`[
    Declare role 'Bob' and unit-scope the role
    i.e. everything in this file is part of 'Bob'.
]
unit role Bob;

method hey () {
    my \shouting = /<:L>/ ^ /<:Ll>/;
    given self.trim {
        when .ends-with: ‘?’ {
            when shouting { ‘Calm down, I know what I'm doing!’ }
            default       { ‘Sure.’ }
        }
        when shouting { ‘Whoa, chill out!’ }
        when .not     { ‘Fine. Be that way!’ }
        default       { ‘Whatever.’ };
    }
}
