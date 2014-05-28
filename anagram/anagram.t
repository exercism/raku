use v6;
use Test;
use lib './';

plan 11;

BEGIN { EVAL('use Example') }; pass 'Load module';

ok Anagram.can('match'), 'Class Anagram has match method';

is_deeply Anagram.match('diaper', ['hello', 'world', 'zombies', 'pants']), [], 'no matches';
is_deeply Anagram.match('ant', ['tan', 'stand', 'at']), ['tan'], 'detect simple anagram';
is_deeply Anagram.match('master', ['stream', 'pigeon', 'maters']), ['stream', 'maters'], 'multiple anagrams';
is_deeply Anagram.match('galea', ['eagle']), [], 'does not confuse different duplicates';
is_deeply Anagram.match('good', ['dog', 'goody']), [], 'eleminates anagram subsets';
is_deeply Anagram.match('listen', ['enlists', 'google', 'inlets', 'banana']), ['inlets'], 'detect anagram';
is_deeply Anagram.match('allergy', ['gallery', 'ballerina', 'regally', 'clergy', 'largely', 'leading']), ['gallery', 'regally', 'largely'], 'multiple anagrams';
is_deeply Anagram.match('Orchestra', ['cashregister', 'Carthorse', 'radishes']), ['Carthorse'], 'anagrams are case-sensitive';
is_deeply Anagram.match('banana', ['banana']), [], 'same word is not an anagram';
